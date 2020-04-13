package co.zenturi.mandolin.macros;

import haxe.macro.Context;
import haxe.macro.Expr.Field;
import sys.io.File;
import sys.FileSystem;
import haxe.io.Path;

using StringTools;

class ReactBuilder {
	static var cppFiles:Array<String> = [];
	static var hxFiles:Array<String> = [];
	static var javaFiles:Array<String> = [];
	static var classFiles:Array<String> = [];

	macro static function run():Array<Field> {
		var clazz = Context.getLocalModule();
		var builder = new StringBuf();

		var dir = Sys.getCwd();
		trace(dir);

		builder.add("<files id='haxe'>\n");
		builder.add('\t<compilerflag value="-I${dir}helpers"/>\n');
		builder.add('\t<compilerflag value="-I${dir}gen/cpp/co/zenturi/mandolin/xnative"/>\n');

		recursiveLoop('${dir}helpers');

		for (cpp in cppFiles) {
			builder.add('\t<file name="$cpp" />\n');
		}

		builder.add("</files>\n");

		var _class = Context.getLocalClass();
		var _pos = Context.currentPos();
		var _pos_info = Context.getPosInfos(_pos);
		_class.get().meta.add(":buildXml", [{expr: EConst(CString('${builder.toString()}')), pos: _pos}], _pos);

		var xdir = '${Sys.getCwd()}src';

		try {
			recursiveLoop('${dir}');
			var packages = new HxmlBuilder();
			for (x in hxFiles) {
				var rex = ~/.*package.*/;
				var exRex = ~/[^.]+$/;
				var code = sys.io.File.getContent(x);
				var packagePrefix = "";

				if (rex.match(code)) {
					var packageName = rex.matched(0);
					packagePrefix = packageName.replace('package ', "").replace(';', '');
				}
				if (exRex.match(x)) {
					var m = exRex.matchedLeft().split("/");
					var length = m.length;
					var fileName = (m[length - 1]).replace(".", "");

					var fullpack = '$packagePrefix.$fileName';
					if (packagePrefix.replace(".", "-") == "co-zenturi-mandolin-macros") {
						continue;
					}
					// if (fullpack.replace(".", "-") == 'co-zenturi-mandolin-react-ReactBuild') {
					// 	continue;
					// }
					if(fullpack.replace(".", "-") == 'co-zenturi-mandolin-react-ReactJavaMake'){
						continue;
					}

					packages.push(fullpack);
				}
			}

		} catch (e:Dynamic) {
			throw 'source path "src/" no found in current working directory: Make sure your project Haxe files are in "src" directory: $e ';
		}
		return null;
	}

	macro static function genJavaMake():Array<Field> {
		var sbuf = new StringBuf();
		recursiveLoop('${Sys.getCwd()}/gen/jni');
		recursiveLoop('${Sys.getCwd()}/bin/react/java/src');
		sbuf.add('
JFLAGS = -g
JC = javac
.SUFFIXES: .java .class
.java.class:
			$(JC) $(JFLAGS) -sourcepath jni  -cp ".:../lib/react-native-0.61.5.jar:../lib/javax-inject.jar:../lib/android.jar:" ${javaFiles.join(" ")}\n
CLASSES = ');

		recursiveLoop('${Sys.getCwd()}/gen/jni');

		for (j in javaFiles) {
			sbuf.add('$j ');
		}

		sbuf.add('
default: classes

classes: $(CLASSES:.java=.class)
clean:
		find ./jni -name "*.class" -exec $(RM)  {} +
		find ../bin/react/java/src -name "*.class" -exec $(RM)  {} +
		');

		File.saveContent('${Sys.getCwd()}gen/Makefile', sbuf.toString());

		File.saveContent('${Sys.getCwd()}gen/make-jar.sh', '
jar cvf react-java1.jar -C jni . \\\n
jar cvf react-java2.jar -C ../bin/react/java/src . \\\n
mkdir tempjar && cd tempjar \\\n
jar -xf ../react-java1.jar \\\n
jar -xf ../react-java2.jar \\\n
jar -cf ../react-module-lib.jar . \\\n
cd .. && rm -rf tempjar \\\n
sleep 5
rm react-java1.jar \\\n
rm react-java2.jar \\\n
		');

		return null;
	}

	static function recursiveLoop(directory:String = "path/to/") {
		if (sys.FileSystem.exists(directory)) {
			for (file in sys.FileSystem.readDirectory(directory)) {
				var path = haxe.io.Path.join([directory, file]);
				if (!sys.FileSystem.isDirectory(path)) {
					if (Path.extension(path) == "cpp")
						cppFiles.push(path);
					if (Path.extension(path) == "hx")
						hxFiles.push(path);
					if (Path.extension(path) == "java")
						javaFiles.push(path);
					if (Path.extension(path) == "class")
						classFiles.push(path);
				} else {
					var directory = Path.addTrailingSlash(path);
					recursiveLoop(directory);
				}
			}
		} else {
			trace('"$directory" does not exists');
		}
	}
}

abstract HxmlBuilder(Array<String>) from Array<String> to Array<String> {
	public inline function new() {
		this = XBuilder.modules;
	}

	public inline function indexOf(x:String):Int {
		return this.indexOf(x);
	}

	public inline function push(x:String) {
		if (this.indexOf(x) == -1) {
			this.push(x);
		}
		var sbuf = new StringBuf();
		sbuf.add('\n');
		var dir = '${Sys.getCwd()}src/';
		if (FileSystem.exists(dir)) {
			sbuf.add('-cp ${dir}\n\n');
			for (module in this) {
				sbuf.add('$module\n');
			}
			sbuf.add('\n-dce full\n--each\n--interp\n');

			// cpp compile
			sbuf.add('

--next

-D no-root
-D no-compilation
-java-lib lib/javax-inject.jar
-java-lib lib/android.jar
-java-lib lib/react-native-0.61.5.jar
-java bin/react/java/

--next 
co.zenturi.mandolin.react.ReactJavaMake

--interp

--next

-cmd cd gen 
-cmd make && bash make-jar.sh && make clean

--next
-dce full
-cpp bin/react/Mandolin_64
-D -verbose
-D no-debug
-D android 
-D static_link 
-D HXCPP_ARM64
-D HXCPP_OPTIMIZE_LINK
-D PLATFORM=android-21
            
--next
-dce full        
-cpp bin/react/Mandolin_V7
-D no-debug
-D android 
-D static_link 
-D HXCPP_ARMV7
-D HXCPP_OPTIMIZE_LINK
-D PLATFORM=android-21
                    
--next
-dce full          
-cpp bin/react/Mandolin_X86
-D no-debug
-D android 
-D static_link 
-D HXCPP_X86
-D HXCPP_OPTIMIZE_LINK
-D PLATFORM=android-21
            
            
--next
-dce full       
-cpp bin/react/Mandolin_X86_64
-D no-debug
-D android 
-D static_link 
-D HXCPP_X86_64
-D HXCPP_OPTIMIZE_LINK
-D PLATFORM=android-21

-cmd rm -rf gen/android
-cmd mkdir gen/android
-cmd mkdir gen/android/react

-cmd mkdir gen/android/react/ARM64 && cp bin/react/Mandolin_64/liboutput-64.a gen/android/react/ARM64/native_lib.a 
-cmd mkdir gen/android/react/ARMV7 && cp bin/react/Mandolin_V7/liboutput-v7.a gen/android/react/ARMV7/native_lib.a
-cmd mkdir gen/android/react/X86 && cp bin/react/Mandolin_X86/liboutput-x86.a gen/android/react/X86/native_lib.a
-cmd mkdir gen/android/react/X86_64 && cp bin/react/Mandolin_X86_64/liboutput-x86_64.a gen/android/react/X86_64/native_lib.a
-cmd mkdir gen/android/react/lib && mv gen/react-module-lib.jar gen/android/react/lib/react-module-lib.jar
            ');

			File.saveContent('${Sys.getCwd()}gen/compile-react.hxml', sbuf.toString());
		} else {
			throw "source path 'src/' no found in current working directory: Make sure your project Haxe files are in 'src' directory";
		}
	}
}
