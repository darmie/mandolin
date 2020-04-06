package co.zenturi.mandolin.macros;

import sys.io.FileSeek;
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;
import sys.io.File;
import sys.FileSystem;

using StringTools;

class ReactModuleCpp {
	static var moduleName:String;

	static var cppFiles:Array<String> = [];

	static var withImpl:Bool = false;

	macro static public function bind(impl:Bool = false):Array<Field> {
		withImpl = impl;
		var pack = Context.getLocalModule();
		var unpack = pack.split(".");
		var pathLength = unpack.length;
		var name = 'Native${unpack[pathLength - 1]}';
		init(name);
		return null;
	}

	static function init(name:String) {
		moduleName = name;
		genCpp();
	}

	static function genCpp() {
		genCppNamespace(createCppdir());
	}

	static function createCppdir() {
		var dir = Sys.getCwd();
		if (!FileSystem.exists('${dir}gen')) {
			if (FileSystem.exists('${dir}gen/cpp')) {
				FileSystem.createDirectory('${dir}gen/cpp');
			}

			FileSystem.createDirectory('${dir}gen');
		}

		return '${dir}/gen/jni';
	}

	static function genCppNamespace(path:String) {
		var dir = Sys.getCwd();

		var pack = Context.getLocalModule();
		var pathLength = pack.split(".").length;
		var unpack = pack.split(".");
		var packPath = unpack.slice(0, pathLength - 1).join("/");
		var classPath = '${dir}gen/cpp/$packPath/react';
		var _name = unpack[pathLength - 1];

		if (!FileSystem.exists(classPath)) {
			FileSystem.createDirectory(classPath);
		}

		File.saveContent('$classPath/$moduleName.cpp', '');

		constructJNINamespace('$classPath/$moduleName.cpp');

		File.saveContent('$classPath/$moduleName.hpp', '');

		constructJNIHeader('$classPath/$moduleName.hpp');

		if(withImpl){
			constructImplHeader('$classPath/$_name.hpp');
		}
	

		if(cppFiles.indexOf('${dir}gen/cpp/$packPath/react/$moduleName.cpp') == -1){
			cppFiles.push('${dir}gen/cpp/$packPath/react/$moduleName.cpp');
		}

		if(cppFiles.indexOf('${dir}gen/cpp/$packPath/react/$_name.hpp') == -1){
			cppFiles.push('${dir}gen/cpp/$packPath/react/$_name.hpp');
		}
		
		
		var buildXml = new StringBuf();
		buildXml.add("<files id='haxe'>\n");
		buildXml.add('<compilerflag value="-I$classPath"/>\n');
		for(cp in cppFiles){
			buildXml.add('<file name="$cp" />\n');
		}
		buildXml.add("</files>\n");

		var _class = Context.getLocalClass();
		var _pos =  Context.currentPos();
        var _pos_info = Context.getPosInfos(_pos);
		_class.get().meta.add(":buildXml", [{ expr:EConst( CString( '${buildXml.toString()}' ) ), pos:_pos }], _pos );

	}

	static function constructJNINamespace(name:String) {
		var sbuf = new StringBuf();
		var pack = Context.getLocalModule();
		var unpack = pack.split(".");
		var pathLength = unpack.length;
		var _name = '${unpack[pathLength - 1]}';
		var _package = unpack.slice(0, pathLength - 1).join("/");

		var JNIPrefix = 'Java_${_package.replace("/", "_")}_react_${_name}_00024CppProxy_';

		sbuf.add("// AUTOGENERATED FILE - DO NOT MODIFY!\n");
		sbuf.add("// This file is generated by Mandolin - (c) Zenturi.co\n\n");
		sbuf.add('#include "$moduleName.hpp"\n\n');
		sbuf.add("namespace mandolin_generated {\n\n");
		var CppProxy = "$CppProxy";
		sbuf.add('\t$moduleName::$moduleName() : ::mandolin::JniInterface<::$_name, $moduleName>("$_package/react/$_name$CppProxy") {}\n\n');
		sbuf.add('\t$moduleName::~$moduleName() = default;\n\n');

		// Fields
		var fields:Array<Field> = Context.getBuildFields();

		// destroy
		sbuf.add('\tCJNIEXPORT void JNICALL ${JNIPrefix}_nativeDestroy(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef) {\n');
		sbuf.add('\t\ttry {\n');
		sbuf.add('\t\t\tDJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);\n');
		sbuf.add('\t\t\tdelete reinterpret_cast<::mandolin::CppProxyHandle<::$_name>*>(nativeRef);\n');
		sbuf.add('\t\t} JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )\n');
		sbuf.add('\t}\n\n');

		// create
		sbuf.add('\tCJNIEXPORT object JNICALL Java_${_package.replace("/", "_")}_react_${_name}_create(JNIEnv* jniEnv, jobject /*this*/, ::mandolin_generated::NativeReactBridge::JniType j_bridge) {\n');
		sbuf.add('\t\ttry {\n');
		sbuf.add('\t\t\tDJINNI_FUNCTION_PROLOGUE0(jniEnv);\n');
		sbuf.add('\t\t\tauto r = ::$_name::create(::mandolin_generated::NativeReactBridge::toCpp(jniEnv, j_bridge));\n');
		sbuf.add('\t\t\treturn ::mandolin::release(::mandolin_generated::$moduleName::fromCpp(jniEnv, r));\n');
		sbuf.add('\t\t} JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0)\n');
		sbuf.add('\t}\n\n');

		for (field in fields) {
			switch (field.kind) {
				case FFun(f):
					{
						var re = ~/([-_][a-z])/;
						var fname = field.name;
						if (re.match(field.name)) {
							for (i in 0...re.matchedPos().len) {
								fname = re.replace(field.name, re.matched(i).toUpperCase()).replace("_", "").replace("-", "");
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
							argType = getJNICppTypes(argType);
							params.push(['j_$argName', '$argType']);
						}
						if (f.ret != null) {
							var _type = "::mandolin_generated::NativeJavascriptPromise::JniType";
							params.push(['j_promise', _type]);
						}

						sbuf.add('\tCJNIEXPORT void JNICALL ${JNIPrefix}native_1$fname(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef');
						if (params.length > 0)
							sbuf.add(', ');
						for (i in 0...params.length) {
							var param = params[i];
							var pname = param[0];
							var ptype = param[1];
							sbuf.add('$ptype $pname');
							if (i < params.length - 1) {
								sbuf.add(', ');
							}
						}
						sbuf.add('){\n');

						// function body
						sbuf.add('\t\ttry {\n');
						sbuf.add('\t\t\tMANDOLIN_FUNCTION_PROLOGUE1(jniEnv, nativeRef);\n');
						sbuf.add('\t\t\tconst auto& ref = ::mandolin::objectFromHandleAddress<::$_name>(nativeRef);\n');
						sbuf.add('\t\t\tref->$fname(');

						for (i in 0...params.length) {
							var param = params[i];
							var pname = param[0];
							var ptype = param[1];
							sbuf.add(transformParams(ptype, pname));
							if (i < params.length - 1) {
								sbuf.add(',\n\t\t\t ');
							}
						}
						sbuf.add(');\n');
						sbuf.add('\t\t} JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )\n');
						sbuf.add('\t}\n\n');
					}
				case _:
			}
		}

		sbuf.add("}\n");

		File.saveContent(name, sbuf.toString());
	}

	static function getJNICppTypes(type:String) {
		return switch type {
			case "String": "jstring";
			case "Int" | "haxe.Int32": "jint";
			case "Int64": "jlong";
			case "Float": "jdouble";
			case "Event": "::mandolin_generated::NativeJavascriptEvent::JniType";
			case "Callback": "::mandolin_generated::NativeJavascriptCallback::JniType";
			case "Map": "::mandolin_generated::NativeJavascriptMap::JniType";
			case "Array": "::mandolin_generated::NativeJavascriptArray::JniType";
			case "Promise": "::mandolin_generated::NativeJavascriptPromise::JniType";
			case _: throw "Type not supported";
		}
	}

	static function getCppTypes(type:String) {
		return switch type {
			case "String": "string";
			case "Int" | "haxe.Int32": "int32_t";
			case "Int64": "int64_t";
			case "Float": "double";
			// case "Event": "::mandolin_generated::NativeJavascriptEvent::JniType";
			case "Callback": "std::shared_ptr<::JavascriptCallback> &";
			case "Map": "std::shared_ptr<::JavascriptMap> &";
			case "Array": "std::shared_ptr<::JavascriptArray> &";
			case "Promise": "std::shared_ptr<::JavascriptPromise> &";
			case _: throw "Type not supported";
		}
	}

	static function transformParams(type:String, arg:String) {
		return switch type {
			case "jstring": '::mandolin::String::toCpp(jniEnv, $arg)';
			case "jint" | "haxe.Int32": '::mandolin::I32::toCpp(jniEnv, $arg)';
			case "jlong": '::mandolin::I64::toCpp(jniEnv, $arg)';
			case "jdouble": '::mandolin::F64::toCpp(jniEnv, $arg)';
			case "::mandolin_generated::NativeJavascriptEvent::JniType": '::mandolin_generated::NativeJavascriptEvent::toCpp(jniEnv, $arg)';
			case "::mandolin_generated::NativeJavascriptCallback::JniType": '::mandolin_generated::NativeJavascriptCallback::toCpp(jniEnv, $arg)';
			case "::mandolin_generated::NativeJavascriptMap::JniType": '::mandolin_generated::NativeJavascriptMap::toCpp(jniEnv, $arg)';
			case "::mandolin_generated::NativeJavascriptArray::JniType": '::mandolin_generated::NativeJavascriptArray::toCpp(jniEnv, $arg)';
			case "::mandolin_generated::NativeJavascriptPromise::JniType": '::mandolin_generated::NativeJavascriptPromise::toCpp(jniEnv, $arg)';
			case _: throw "Type not supported";
		}
	}

	static function constructJNIHeader(name:String) {
		var sbuf = new StringBuf();
		var pack = Context.getLocalModule();
		var unpack = pack.split(".");
		var pathLength = unpack.length;
		var _name = '${unpack[pathLength - 1]}';
		var nHeader = pack.replace(".", "/");
		var _package = unpack.slice(0, pathLength - 1).join("/");

		sbuf.add("// AUTOGENERATED FILE - DO NOT MODIFY!\n");
		sbuf.add("// This file is generated by Mandolin - (c) Zenturi.co\n\n");

		sbuf.add("#pragma once\n\n");

		// sbuf.add('#include <$_package/react/$_name.hpp>\n\n');
		sbuf.add('#include "$_name.hpp"\n\n');
		sbuf.add('#include <mandolin_helpers.h>\n\n');

		sbuf.add("namespace mandolin_generated {\n\n");
		sbuf.add('class $moduleName final : ::mandolin::JniInterface<::$_name, $moduleName> {\n');

		sbuf.add('public:\n');
		sbuf.add('\tusing CppType = std::shared_ptr<::$_name>;\n');
		sbuf.add('\tusing CppOptType = std::shared_ptr<::$_name>;\n');
		sbuf.add('\tusing JniType = jobject;\n');
		sbuf.add('\tusing Boxed = $moduleName;\n\n');
		sbuf.add('\t~$moduleName(){};\n\n');

		sbuf.add('\tstatic CppType toCpp(JNIEnv* jniEnv, JniType j) { return ::mandolin::JniClass<$moduleName>::get()._fromJava(jniEnv, j); }\n');
		sbuf.add('\tstatic ::mandolin::LocalRef<JniType> fromCppOpt(JNIEnv* jniEnv, const CppOptType& c) { return {jniEnv, ::mandolin::JniClass<$moduleName>::get()._toJava(jniEnv, c)}; }\n');
		sbuf.add('\tstatic ::mandolin::LocalRef<JniType> fromCpp(JNIEnv* jniEnv, const CppType& c) { return fromCppOpt(jniEnv, c); }\n\n');

		sbuf.add('private:\n');
		sbuf.add('\t$moduleName(){};\n');
		sbuf.add('\tfriend ::mandolin::JniClass<$moduleName>;\n');
		sbuf.add('\tfriend ::mandolin::JniInterface<::$_name, $moduleName>;\n\n');

		sbuf.add('};\n\n');
		sbuf.add("} // namespace mandolin_generated \n");

		File.saveContent(name, sbuf.toString());
	}

	static function constructImplHeader(name:String) {
		var sbuf = new StringBuf();
		var pack = Context.getLocalModule();
		var unpack = pack.split(".");
		var pathLength = unpack.length;
		var _name = '${unpack[pathLength - 1]}';
		var nHeader = pack.replace(".", "/");
		var _package = unpack.slice(0, pathLength - 1).join("/");

		var funcs:Array<String> = [];
		var imports:Array<String> = [];

		// Fields
		var fields:Array<Field> = Context.getBuildFields();

		for (field in fields) {
			switch (field.kind) {
				case FFun(f):
					{
						var impName = "";
						var re = ~/([-_][a-z])/;
						var fname = field.name;
						if (re.match(field.name)) {
							for (i in 0...re.matchedPos().len) {
								fname = re.replace(field.name, re.matched(i).toUpperCase()).replace("_", "").replace("-", "");
							}
						}
						var params = [];
						for (arg in f.args) {
							var argName = arg.name;
							var argType = null;
							switch arg.type {
								case TPath(p): {
										argType = p.name;
										switch p.name {
											case "Map": impName = '#include <co/zenturi/mandolin/xnative/JavascriptMap.h>\n';
											case "Array": impName = '#include <co/zenturi/mandolin/xnative/JavascriptArray.h>\n';
											case _:
										}
										
									}
								case TFunction(args, ret): {
										argType = "Callback";
										impName = '#include <co/zenturi/mandolin/xnative/JavascriptCallback.h>\n';
									}
								case _:
							}
							argType = getCppTypes(argType);
							params.push(['$argName', 'const $argType']);

							if(imports.indexOf(impName) == -1){
								imports.push(impName);
							}
						}
						var hasPromise = false;
						if (f.ret != null) {
							var _type = "const std::shared_ptr<::JavascriptPromise>";
							impName = '#include <co/zenturi/mandolin/xnative/JavascriptPromise.h>\n';
							params.push(['&promise', _type]);
							hasPromise = true;

							if(imports.indexOf(impName) == -1){
								imports.push(impName);
							}
						}

						funcs.push('\tvoid $fname(');
						// if (params.length > 0)
						// 	funcs.push(', ');
						for (i in 0...params.length) {
							var param = params[i];
							var pname = param[0];
							var ptype = param[1];
							funcs.push('$ptype $pname');
							if (i < params.length - 1) {
								funcs.push(', ');
							}
						}
						funcs.push(') {\n');
						
						if(fname == 'new'){
							funcs.push('\t\tthis->ref = ${_package.replace("/", "::")}::${_name}_obj::');
							funcs.push('__new');
						} else {
							if(hasPromise) funcs.push('\t\tauto ret = ');
							else funcs.push('\t\t');
							funcs.push('ref->');
							funcs.push('$fname');
						}
						funcs.push('(');
						
						for (i in 0...params.length) {
							var param = params[i];
							var pname = param[0];
							var ptype = param[1];
							if(ptype != "const std::shared_ptr<::JavascriptPromise>"){
								funcs.push('$pname');
							} 

							if (i < params.length - 2) {
								funcs.push(', ');
							}
						}
						funcs.push(');\n');
						if(hasPromise){
							funcs.push('\t\tpromise->');
							var returnType = f.ret;
							switch returnType {
								case TPath(p):{
									switch p.name {
										case "String": funcs.push('resolveString(ret);\n');
										case "Int" | "haxe.Int32": funcs.push('resolveInt(ret);\n');
										case "haxe.Int64" | "Float": funcs.push('resolveDouble(ret);\n');
										case "Map": funcs.push('resolveMap(::JavascriptObject::fromHaxe(ret));\n');
										case "Array": funcs.push('resolveArray(::JavascriptObject::fromHaxe(ret));\n');
										default: funcs.push('resolveNull();\n');
									}
								}
								case _: 
							}
							
						}
						funcs.push('\t}\n');
					}
				case _:
			}
		}


		sbuf.add("// AUTOGENERATED FILE - DO NOT MODIFY!\n");
		sbuf.add("// This file is generated by Mandolin - (c) Zenturi.co\n\n");
		sbuf.add("#pragma once\n\n");
		sbuf.add("#include <cstdint>\n");
		sbuf.add("#include <memory>\n");
		sbuf.add("#include <string>\n");
		sbuf.add('#include <$nHeader.h>\n');
		sbuf.add('#include <$_package/xnative/ReactBridge.h>\n\n');

		for (imp in imports) {
			sbuf.add(imp);
		}
		sbuf.add('\n\n');

		sbuf.add("namespace mandolin_generated {\n\n");

		sbuf.add('class $_name  {\n');

		sbuf.add('public:\n');
		sbuf.add('');
		sbuf.add('\thx::ObjectPtr< ${_package.replace("/", "::")}::${_name}_obj > ref;\n');

		sbuf.add('\t$_name(const std::shared_ptr< ::ReactBridge > & bridge){};\n');
		sbuf.add('\t~$_name(){};\n');
		sbuf.add('\tstatic std::shared_ptr<$_name> create(const std::shared_ptr< ::ReactBridge > & bridge) {\n');
		sbuf.add('\t\treturn std::make_shared<$_name>(bridge);\n');
		sbuf.add('\t}\n');

		for (func in funcs) {
			sbuf.add(func);
		}

		sbuf.add('}; // class $_name\n\n');

		sbuf.add("} // namespace mandolin_generated \n");

		File.saveContent(name, sbuf.toString());
	}
}
