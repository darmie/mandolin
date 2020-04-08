package co.zenturi.mandolin.macros;

import haxe.macro.Context;
import haxe.macro.Expr.Field;
import sys.io.File;
import sys.FileSystem;

using StringTools;

class Builder {
	static var cppFiles:Array<String> = [];
	static var hxFiles:Array<String> = [];

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
					if (packagePrefix.replace(".","-") != "co-zenturi-mandolin-macros") {
						if(fullpack.replace(".","-") != 'co-zenturi-mandolin-react-ReactBuild'){
							packages.push(fullpack);
						}
						
					}
				}
			}
		} catch (e:Dynamic) {
			throw 'source path "src/" no found in current working directory: Make sure your project Haxe files are in "src" directory: $e ';
		}
		return null;
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

-cpp bin/Mandolin
-D -verbose
-D android 
-D static_link 
-D HXCPP_ARM64
-D PLATFORM=android-21
            
--next
            
-cpp bin/Mandolin
-D -verbose
-D android 
-D static_link 
-D HXCPP_ARMV7
-D PLATFORM=android-21
            
            
--next
            
-cpp bin/Mandolin
-D -verbose
-D android 
-D static_link 
-D HXCPP_X86
-D PLATFORM=android-21
            
            
--next
            
-cpp bin/Mandolin
-D -verbose
-D android 
-D static_link 
-D HXCPP_X86_64
-D PLATFORM=android-21
            ');

			File.saveContent('${Sys.getCwd()}compile-react.hxml', sbuf.toString());
		} else {
			throw "source path 'src/' no found in current working directory: Make sure your project Haxe files are in 'src' directory";
		}
	}
}
