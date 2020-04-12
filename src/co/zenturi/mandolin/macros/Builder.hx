package co.zenturi.mandolin.macros;

import haxe.macro.Context;
import haxe.macro.Expr.Field;
import sys.io.File;
import sys.FileSystem;

using StringTools;

class Builder {
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
					if (packagePrefix.replace(".", "-") != "co-zenturi-mandolin-macros") {
						if (fullpack.replace(".", "-") != 'co-zenturi-mandolin-react-ReactBuild') {
							packages.push(fullpack);
						}
					}
				}
			}

			genJavaMake();
		} catch (e:Dynamic) {
			throw 'source path "src/" no found in current working directory: Make sure your project Haxe files are in "src" directory: $e ';
		}
		return null;
	}

	static function genJavaMake() {
		var sbuf = new StringBuf();
		recursiveLoop('${Sys.getCwd()}/gen/jni');
		recursiveLoop('${Sys.getCwd()}/bin/java/src');
		sbuf.add('
JFLAGS = -g
JC = javac
.SUFFIXES: .java .class
.java.class:
			$(JC) $(JFLAGS) -sourcepath gen/jni  -cp ".:lib/react-native-0.61.5.jar:lib/javax-inject.jar:lib/android.jar:" ${javaFiles.join(" ")}\n
CLASSES = ');

		recursiveLoop('${Sys.getCwd()}/gen/jni');

		for (j in javaFiles) {
			sbuf.add('$j ');
		}

		sbuf.add('
default: classes

classes: $(CLASSES:.java=.class)
clean:
		$(RM) *.class
		');

		File.saveContent('${Sys.getCwd()}Makefile', sbuf.toString());

		File.saveContent('${Sys.getCwd()}make-jar.sh', '
jar cvf react-java1.jar -C gen/jni . \\\n
jar cvf react-java2.jar -C bin/java/src . \\\n
mkdir tempjar && cd tempjar \\\n
jar -xf ../react-java1.jar \\\n
jar -xf ../react-java2.jar \\\n
jar -cf ../react-module-lib.jar . \\\n
cd .. && rm -rf tempjar \\\n
sleep 5
rm react-java1.jar \\\n
rm react-java2.jar \\\n
		');
	}

	static function recursiveLoop(directory:String = "path/to/") {
		if (sys.FileSystem.exists(directory)) {
			//   trace("directory found: " + directory);
			for (file in sys.FileSystem.readDirectory(directory)) {
				var path = haxe.io.Path.join([directory, file]);
				if (!sys.FileSystem.isDirectory(path)) {
					//   trace("file found: " + path);
					var re = ~/[^.]+$/;
					if (re.match(path)) {
						var ext = re.matched(0);
						if (ext == "cpp")
							cppFiles.push(path);
						if (ext == "hx")
							hxFiles.push(path);
						if (ext == "java")
							javaFiles.push(path);
						if (ext == "class")
							classFiles.push(path);
					}
					// do something with file
				} else {
					var directory = haxe.io.Path.addTrailingSlash(path);
					//   trace("directory found: " + directory);
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
-java bin/java/

-cmd make && bash make-jar.sh

--next
-dce full
-cpp bin/Mandolin_64
-D -verbose
-D no-debug
-D android 
-D static_link 
-D HXCPP_ARM64
-D HXCPP_OPTIMIZE_LINK
-D PLATFORM=android-21
            
--next
-dce full        
-cpp bin/Mandolin_V7
-D no-debug
-D android 
-D static_link 
-D HXCPP_ARMV7
-D HXCPP_OPTIMIZE_LINK
-D PLATFORM=android-21
                    
--next
-dce full          
-cpp bin/Mandolin_X86
-D no-debug
-D android 
-D static_link 
-D HXCPP_X86
-D HXCPP_OPTIMIZE_LINK
-D PLATFORM=android-21
            
            
--next
-dce full       
-cpp bin/Mandolin_X86_64
-D no-debug
-D android 
-D static_link 
-D HXCPP_X86_64
-D HXCPP_OPTIMIZE_LINK
-D PLATFORM=android-21

            ');

			File.saveContent('${Sys.getCwd()}compile-react.hxml', sbuf.toString());
		} else {
			throw "source path 'src/' no found in current working directory: Make sure your project Haxe files are in 'src' directory";
		}
	}
}
