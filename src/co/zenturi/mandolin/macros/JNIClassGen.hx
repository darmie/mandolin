package co.zenturi.mandolin.macros;

#if (macro && !java)
import sys.io.FileSeek;
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.Expr.Access;
import sys.io.File;
import sys.FileSystem;

using StringTools;

class JNIClassGen {
	static var moduleName:String;
	static var moduleFields:Array<Field> = [];
	static var hasProxy:Bool = false;

	public static function init(pack:String, fields:Array<Field>, isProxy:Bool = false) {
		moduleFields = fields;
		hasProxy = isProxy;
		var unpack:Array<String> = pack.split(".");
		var pathLength = unpack.length;

		var name = unpack[pathLength - 1];
		moduleName = name;
		var _package = unpack.slice(0, pathLength - 1).join("/");

		var dir = Sys.getCwd();
		if (!FileSystem.exists('${dir}gen')) {
			if (FileSystem.exists('${dir}gen/jni')) {
				FileSystem.createDirectory('${dir}gen/jni');
			}

			FileSystem.createDirectory('${dir}gen/jni');
		}

		var classPath = '${dir}gen/jni/$_package/react';
		if (!FileSystem.exists(classPath)) {
			FileSystem.createDirectory(classPath);
		}

		File.saveContent('$classPath/$moduleName.java', '');

		constructJNIClass('$classPath/$moduleName.java', unpack.slice(0, pathLength - 1).join("."));

		// if (!hasProxy) {
		// 	File.saveContent('$classPath/${moduleName}Impl.java', '');
		// 	constructClassImpl('$classPath/${moduleName}Impl.java', unpack.slice(0, pathLength - 1).join("."));
		// }
	}

	static function constructJNIClass(file, _package) {
		var sbuf = new StringBuf();

		sbuf.add('package $_package.react;\n\n');
		for (dep in Context.getLocalClass().get().meta.extract('dep')) {
			for (p in dep.params) {
				switch (p.expr) {
					case EConst(CString(s)):
						{
							sbuf.add('import $s;\n');
						}
					case _:
				}
			}
		}
		sbuf.add('import co.zenturi.mandolin.xnative.JavascriptType;\n');
		sbuf.add('import java.util.concurrent.atomic.AtomicBoolean;\n\n');

		sbuf.add('public abstract class $moduleName {\n');
		for (field in moduleFields) {
			switch (field.kind) {
				case FFun(f):
					{
						var fname = field.name;
						if (fname == "new")
							continue;
						var isStatic = false;
						var access:Array<Access> = field.access;
						var params = [];
						for (arg in f.args) {
							var argName = arg.name;
							var argType = null;
							switch arg.type {
								case TPath(p): {
										argType = p.name;
										if (argType == "MandolinObject") {
											for (_p in p.params) {
												switch (_p) {
													case TPType(t): {
															switch (t) {
																case TPath(p): {
																		argType = p.name;
																	}
																case _:
															}
														}
													case _:
												}
											}
										}
									}
								case _:
							}
							argType = getTypes(argType);
							params.push(['$argName', '$argType']);
						}

						for (a in access) {
							switch a {
								case AStatic: {
										isStatic = true;
									}
								case _:
							}
						}

						// returns
						var returnType = null;
						switch (f.ret) {
							case TPath(p): {
									if (p.name == "MandolinObject") {
										for (_p in p.params) {
											switch (_p) {
												case TPType(t): {
														switch (t) {
															case TPath(p): {
																	returnType = getTypes(p.name);
																}
															case _:
														}
													}
												case _:
											}
										}
									} else {
										returnType = getTypes(p.name);
									}
								}
							case _:
						}

						sbuf.add('\tpublic ');
						if (isStatic)
							sbuf.add('static native ');
						if (!isStatic)
							sbuf.add('abstract ');
						sbuf.add('$returnType ');
						sbuf.add('$fname (');
						for (i in 0...params.length) {
							var param = params[i];
							var name = param[0];
							var ptype = param[1];

							sbuf.add('$ptype $name');
							if (i < params.length - 1) {
								sbuf.add(',');
							}
						}
						sbuf.add(');\n');
					}
				case _:
			}
		}

		if (hasProxy) {
			genCppProxy(file, sbuf);
		} else {
			sbuf.add('}\n');

			File.saveContent(file, sbuf.toString());
		}
	}

	static function constructClassImpl(file, _package) {
		var sbuf = new StringBuf();

		sbuf.add('package $_package.react;\n\n');
		for (dep in Context.getLocalClass().get().meta.extract('dep')) {
			for (p in dep.params) {
				switch (p.expr) {
					case EConst(CString(s)):
						{
							sbuf.add('import $s;\n');
						}
					case _:
				}
			}
		}
		sbuf.add('import co.zenturi.mandolin.xnative.JavascriptType;\n');
		sbuf.add('import com.facebook.react.bridge.*;\n');
		sbuf.add('public class ${moduleName}Impl extends ${moduleName} {\n');
		sbuf.add('\tpublic $_package.$moduleName mImpl;\n');

		for (field in moduleFields) {
			switch (field.kind) {
				case FFun(f):
					{
						var fname = field.name;

						var isStatic = false;
						var access:Array<Access> = field.access;
						var params = [];
						for (arg in f.args) {
							var argName = arg.name;
							var argType = null;
							switch arg.type {
								case TPath(p): {
										argType = p.name;
										if (argType == "MandolinObject") {
											for (_p in p.params) {
												switch (_p) {
													case TPType(t): {
															switch (t) {
																case TPath(p): {
																		argType = p.name;
																	}
																case _:
															}
														}
													case _:
												}
											}
										}
									}
								case _:
							}
							argType = getTypes(argType);
							params.push(['$argName', '$argType']);
						}

						for (a in access) {
							switch a {
								case AStatic: {
										isStatic = true;
									}
								case _:
							}
						}

						// returns
						var returnType = null;
						switch (f.ret) {
							case TPath(p): {
									if (p.name == "MandolinObject") {
										for (_p in p.params) {
											switch (_p) {
												case TPType(t): {
														switch (t) {
															case TPath(p): {
																	returnType = getTypes(p.name);
																}
															case _:
														}
													}
												case _:
											}
										}
									} else {
										returnType = getTypes(p.name);
									}
								}
							case _:
						}

						if (fname == "new") {
							sbuf.add('\tpublic ${moduleName}Impl(');
							for (i in 0...params.length) {
								var param = params[i];
								var name = param[0];
								var ptype = param[1];

								sbuf.add('$ptype $name');
								if (i < params.length - 1) {
									sbuf.add(',');
								}
							}
							sbuf.add('){\n');
							sbuf.add('\t\tmImpl = new $_package.$moduleName(');
							for (i in 0...params.length) {
								var param = params[i];
								var name = param[0];
								// var ptype = param[1];

								sbuf.add('$name');
								if (i < params.length - 1) {
									sbuf.add(',');
								}
							}
							sbuf.add(');\n');
							sbuf.add('\t}\n');
						} else {
							if (!isStatic) sbuf.add('\t@Override\n');
							sbuf.add('\tpublic ');
							if (isStatic)
								sbuf.add('static ');
							
							sbuf.add('$returnType ');
							sbuf.add('$fname (');
							for (i in 0...params.length) {
								var param = params[i];
								var name = param[0];
								var ptype = param[1];

								sbuf.add('$ptype $name');
								if (i < params.length - 1) {
									sbuf.add(',');
								}
							}
							sbuf.add('){\n');
							if (returnType != null)
								if (returnType != 'void')
									sbuf.add('\t\treturn ($returnType)(');
								else
									sbuf.add('\t\t');
							if(!isStatic) sbuf.add('mImpl.$fname(');
							if(isStatic) sbuf.add('$_package.$moduleName.$fname(');
							for (i in 0...params.length) {
								var param = params[i];
								var ptype = param[1];
								var name = param[0];
								sbuf.add('$name');
								// if(ptype == 'JavascriptObject[]'){
								// 	sbuf.add('.stream().map(n -> n.mImpl).collect(Collectors.toList())');
								// }
								if (i < params.length - 1) {
									sbuf.add(',');
								}
							}
							if (returnType != 'void')sbuf.add(')');
							sbuf.add(');\n');
							sbuf.add('\t}\n\n');
						}
					}
				case _:
			}
		}

		if (hasProxy) {
			genCppProxy(file, sbuf);
		} else {
			sbuf.add('}\n');

			File.saveContent(file, sbuf.toString());
		}
	}

	static function genCppProxy(file, sbuf) {
		sbuf.add('\tprivate static final class CppProxy extends $moduleName {\n');

		sbuf.add('\t\tprivate final long nativeRef;\n');
		sbuf.add('\t\tprivate final AtomicBoolean destroyed = new AtomicBoolean(false);\n');

		sbuf.add('\t\tprivate CppProxy(long nativeRef) {\n');
		sbuf.add('\t\t\tif (nativeRef == 0) throw new RuntimeException("nativeRef is zero");\n');
		sbuf.add('\t\t\tthis.nativeRef = nativeRef;\n');
		sbuf.add('\t\t}\n');

		sbuf.add('\t\tprivate native void nativeDestroy(long nativeRef);\n');
		sbuf.add('\t\tpublic void destroy(){\n');
		sbuf.add('\t\t\tboolean destroyed = this.destroyed.getAndSet(true);\n');
		sbuf.add('\t\t\tif (!destroyed) nativeDestroy(this.nativeRef);\n');
		sbuf.add('\t\t}\n');

		sbuf.add('\t\tprotected void finalize() throws java.lang.Throwable {\n');
		sbuf.add('\t\t\tdestroy();\n');
		sbuf.add('\t\t\tsuper.finalize();\n');
		sbuf.add('\t\t}\n');

		for (field in moduleFields) {
			switch (field.kind) {
				case FFun(f):
					{
						var fname = field.name;
						if (fname == "new")
							continue;
						var isStatic = false;
						var access:Array<Access> = field.access;
						var params = [];
						for (arg in f.args) {
							var argName = arg.name;
							var argType = null;
							switch arg.type {
								case TPath(p): {
										argType = p.name;
										if (argType == "MandolinObject") {
											for (_p in p.params) {
												switch (_p) {
													case TPType(t): {
															switch (t) {
																case TPath(p): {
																		argType = p.name;
																	}
																case _:
															}
														}
													case _:
												}
											}
										}
									}
								case _:
							}
							argType = getTypes(argType);
							params.push(['$argName', '$argType']);
						}

						for (a in access) {
							switch a {
								case AStatic: {
										isStatic = true;
									}
								case _:
							}
						}

						// returns
						var returnType = null;
						switch (f.ret) {
							case TPath(p): {
									if (p.name == "MandolinObject") {
										for (_p in p.params) {
											switch (_p) {
												case TPType(t): {
														switch (t) {
															case TPath(p): {
																	returnType = getTypes(p.name);
																}
															case _:
														}
													}
												case _:
											}
										}
									} else {
										returnType = getTypes(p.name);
									}
								}
							case _:
						}

						if (!isStatic) {
							sbuf.add('\t\t@Override\n');
							sbuf.add('\t\tpublic ');
							sbuf.add('$returnType ');
							sbuf.add('$fname (');
							for (i in 0...params.length) {
								var param = params[i];
								var name = param[0];
								var ptype = param[1];

								sbuf.add('$ptype $name');
								if (i < params.length - 1) {
									sbuf.add(',');
								}
							}
							sbuf.add('){\n');
							sbuf.add('\t\t\tassert !this.destroyed.get() : "trying to use a destroyed object";\n');
							if (returnType == "void")
								sbuf.add('\t\t\tnative_$fname(');
							if (returnType != "void")
								sbuf.add('\t\t\treturn native_$fname(');
							sbuf.add('nativeRef');
							if (params.length > 0)
								sbuf.add(',');
							for (i in 0...params.length) {
								var param = params[i];
								var name = param[0];
								// var ptype = param[1];

								sbuf.add('$name');
								if (i < params.length - 1) {
									sbuf.add(',');
								}
							}
							sbuf.add(');\n');
							sbuf.add('\t\t}\n');

							sbuf.add('\t\tprivate native ');
							sbuf.add('$returnType ');
							sbuf.add('native_$fname (long _nativeRef');
							if (params.length > 0)
								sbuf.add(',');
							for (i in 0...params.length) {
								var param = params[i];
								var name = param[0];
								var ptype = param[1];

								sbuf.add('$ptype $name');
								if (i < params.length - 1) {
									sbuf.add(',');
								}
							}
							sbuf.add(');\n\n');
						}
					}
				case _:
			}
		}

		sbuf.add('\t}\n');
		sbuf.add('}\n');

		File.saveContent(file, sbuf.toString());
	}

	static function getTypes(_type) {
		return switch (_type) {
			case "Int" | "haxe.Int32": "int";
			case "Float": "double";
			case "haxe.Int64": "long";
			case "Bool": "boolean";
			case "Void": "void";
			case "Array" | "NativeArray" | "ArrayList": "JavascriptObject[]";
			case "String": "String";
			case "Dynamic": "Object";
			case "IJavascriptArray": "JavascriptArray";
			case "IJavascriptMap": "JavascriptMap";
			case "IJavascriptCallback": "JavascriptCallback";
			case "IJavascriptObject": "JavascriptObject";
			case "IJavascriptMapKeyIterator": "JavascriptMapKeyIterator";
			case "IJob": "Job";
			case "IJobDispatcher": "JobDispatcher";
			case "IReactBridge": "ReactBridge";
			default: _type;
		}
	}
}
#end
