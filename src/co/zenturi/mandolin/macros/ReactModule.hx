package co.zenturi.mandolin.macros;

import sys.io.FileSeek;
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;
import sys.io.File;
import sys.FileSystem;

using StringTools;

class ReactModule {
	static var moduleName:String;

	macro static public function bind():Array<Field> {
		var pack = Context.getLocalModule();
		// (new Builder.HxmlBuilder()).push(pack);
        var unpack = pack.split(".");
        var pathLength = unpack.length;
        var name = unpack[pathLength - 1];
		init(name);
		return null;
	}

	static function init(name:String) {
		moduleName = name;
		genJNI();
	}

	static function genJNI() {
		genJNIClass(createJNIdir());
	}

	static function createJNIdir() {
		var dir = Sys.getCwd();
		if (!FileSystem.exists('${dir}gen')) {
			if (FileSystem.exists('${dir}gen/jni')) {
				FileSystem.createDirectory('${dir}gen/jni');
			}

			FileSystem.createDirectory('${dir}gen');
		}

		return '${dir}/gen/jni';
	}

	static function genJNIClass(path) {
		var dir = Sys.getCwd();

		var pack = Context.getLocalModule();
		var pathLength = pack.split(".").length;
		var unpack = pack.split(".");
		var packPath = unpack.slice(0, pathLength - 1).join("/");
		var classPath = '${dir}gen/jni/$packPath';
		if (!FileSystem.exists(classPath)) {
			FileSystem.createDirectory(classPath);
		}

		File.saveContent('$classPath/$moduleName.java', '');

		constructJNIClass('$classPath/$moduleName.java');
	}

	static function constructJNIClass(fileName:String) {
		var sbuf = new StringBuf();
		var pack = Context.getLocalModule();
		var unpack = pack.split(".");
		var pathLength = unpack.length;
		var _package = unpack.slice(0, pathLength - 1).join(".");

		sbuf.add("// AUTOGENERATED FILE - DO NOT MODIFY!\n");
		sbuf.add("// This file is generated by Mandolin - (c) Zenturi.co\n\n");

		sbuf.add('package $_package.react;\n\n');
		sbuf.add('import co.zenturi.mandolin.xnative.react.*;\n');
		// sbuf.add('import co.zenturi.mandolin.xnative.react.MandolinReact;\n');
		sbuf.add('import com.facebook.react.bridge.*;\n');
		sbuf.add('import com.facebook.react.module.annotations.ReactModule;\n');
		sbuf.add('import java.util.HashMap;\nimport java.util.Map;\nimport java.util.concurrent.atomic.AtomicBoolean;\n');
		sbuf.add('\n');
		sbuf.add('@ReactModule(name = "$moduleName")\npublic final class $moduleName extends ReactContextBaseJavaModule {\n\n');

		sbuf.add('\tprivate final CppProxy mModule;\n\n');

		// Constructor
		sbuf.add('\tpublic $moduleName(ReactApplicationContext reactContext){\n');
		sbuf.add('\t\tsuper(reactContext);\n');
		sbuf.add('\t\tmModule = create(MandolinReact.createReactBridge(reactContext));\n');
		sbuf.add('\t}\n');

		sbuf.add('\n\tprivate static native CppProxy create(co.zenturi.mandolin.xnative.react.ReactBridge bridge);\n');

		// Fields
		var fields:Array<Field> = Context.getBuildFields();

		sbuf.add('\tpublic String getName(){\n
			return "$moduleName";
		}\n');

		genJNIFields(sbuf, fields);

		// C++ Proxy
		genJNIFields(sbuf, fields, true);

		sbuf.add('}');

		File.saveContent(fileName, sbuf.toString());
	}

	static function genJNIFields(sbuf:StringBuf, fields:Array<Field>, isProxy:Bool = false) {
		if (isProxy) {
			sbuf.add('\n\tprivate static final class CppProxy {\n');
			sbuf.add('\t\tprivate final long nativeRef;\n');
			sbuf.add('\t\tprivate final AtomicBoolean destroyed = new AtomicBoolean(false);\n');
			sbuf.add("\n");

			sbuf.add('\t\tprivate CppProxy(long nativeRef){\n');
			sbuf.add('\t\t\tif (nativeRef == 0) throw new RuntimeException("nativeRef is zero");\n');
			sbuf.add('\t\t\tthis.nativeRef = nativeRef;\n');
			sbuf.add('\t\t}\n\n');

			sbuf.add('\t\tprivate native void nativeDestroy(long nativeRef);\n');
			sbuf.add('\t\tpublic void destroy(){\n');
			sbuf.add('\t\t\tboolean destroyed = this.destroyed.getAndSet(true);\n');
			sbuf.add('\t\t\tif (!destroyed) nativeDestroy(this.nativeRef);\n');
            sbuf.add('\t\t}\n\n');
            

			sbuf.add('\t\tprotected void finalize() throws java.lang.Throwable {\n');
			sbuf.add('\t\t\tdestroy();\n');
			sbuf.add('\t\t\tsuper.finalize();\n');
			sbuf.add('\t\t}\n\n');
		}
		for (field in fields) {
			switch (field.kind) {
				case FFun(f):
					{
						var re = ~/([-_][a-z])/;
						var name = field.name;
						if (re.match(field.name)) {
							for (i in 0...re.matchedPos().len) {
								name = re.replace(field.name, re.matched(i).toUpperCase()).replace("_", "").replace("-", "");
							}
						}
						var params = [];
						for (arg in f.args) {
							var argName = arg.name;
                            var argType = null;
							switch arg.type {
								case TPath(p): {
										argType = p.name;
									}
								case TFunction(args, ret): {
										argType = "Callback";
                                    }
								case _:
							}
							argType = getJNITypes(argType, isProxy);
							params.push(['$argName', '$argType']);
						}

						if (f.ret != null) {
							var _type = "Promise";
							if (isProxy)
								_type = "co.zenturi.mandolin.xnative.react.JavascriptPromise";
							params.push(['promise', _type]);
						}

						genJNIMethod(sbuf, name, params, isProxy);
					}

				case _:
			}
		}

		if (isProxy) {
			sbuf.add('\t}\n');
		}
	}

	static function genJNIMethod(sbuf:StringBuf, name:String, params:Array<Array<String>>, isProxy:Bool) {
		sbuf.add("\n");
		if (name == 'new')
			name = "init";
		if (!isProxy)
            sbuf.add('\t@ReactMethod\n');
        else sbuf.add('\t');
		sbuf.add('\tpublic void $name(');
		for (i in 0...params.length) {
			var param = params[i];
			sbuf.add('${param[1]} ${param[0]}');
			if (i < (params.length - 1)) {
				sbuf.add(", ");
			}
		}
		sbuf.add("){\n");
		if (isProxy) {
			sbuf.add('\t\t\tassert !this.destroyed.get() : "trying to use a destroyed object";\n');
            sbuf.add('\t\t\tnative_$name(this.nativeRef');
            if (params.length > 0)
				sbuf.add(", ");
			for (i in 0...params.length) {
				var param = params[i];
				sbuf.add('${param[0]}');
				if (i < (params.length - 1)) {
					sbuf.add(", ");
				}
			}
            sbuf.add(');\n');
            sbuf.add('\t\t');
        } else {
            sbuf.add('\t\tmModule.$name(');
            for (i in 0...params.length) {
                var param = params[i];
                switch(param[1]){
					case "Promise" | "Callback" : sbuf.add('(Javascript${param[1]})'+isMandolinType(param[1], '${param[0]}'));
					case _: sbuf.add('(${param[1]})'+isMandolinType(param[1], '${param[0]}'));
				}
				
				if (i < (params.length - 1)) {
					sbuf.add(", ");
				}
			}
            sbuf.add(');\n');
            sbuf.add('\t');
        }
        sbuf.add('}\n');
        if (isProxy) {
			sbuf.add('\t');
			sbuf.add('\tprivate native void native_$name(long _nativeRef');
			if (params.length > 0)
				sbuf.add(", ");

			for (i in 0...params.length) {
				var param = params[i];
				sbuf.add('${param[1]} ${param[0]}');
				if (i < (params.length - 1)) {
					sbuf.add(", ");
				}
			}
			sbuf.add(");");
			sbuf.add("\n");
		}
		sbuf.add("\n");
	}

	static function getJNITypes(type:String, isProxy:Bool) {
		return switch type {
			case "String": "String";
			case "Int" | "haxe.Int32": "int";
			case "Int64": "long";
            case "Float": "double";
            // case "Event": isProxy ? "co.zenturi.mandolin.xnative.react.JavascriptEvent" : "Event";
            case "JavascriptCallback": isProxy ? "co.zenturi.mandolin.xnative.react.JavascriptCallback" : "Callback";
            case "JavascriptMap": isProxy ? "co.zenturi.mandolin.xnative.react.JavascriptMap" : "JavascriptMap";
            case "JavascriptArray": isProxy ? "co.zenturi.mandolin.xnative.react.JavascriptArray" : "JavascriptArray";
			case _: throw "Type not supported";
		}
    }
    
    static function isMandolinType(type:String, name:String) {
        return switch  type {
            case "Promise" | "Callback" | "ReadableMap" | "ReadableArray" : 'MandolinReact.wrap(($type) $name)';
            case _: name;
        }
    }

}
