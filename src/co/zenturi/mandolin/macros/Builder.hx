package co.zenturi.mandolin.macros;

import haxe.macro.Context;
import haxe.macro.Expr.Field;
import sys.io.File;
import sys.FileSystem;

class Builder {
    static var cppFiles:Array<String> = [];
	macro static function run():Array<Field> {
		var clazz = Context.getLocalModule();
        var builder = new StringBuf();
        
        var dir = Sys.getCwd();

		builder.add("<files id='haxe'>\n");
        builder.add('\t<compilerflag value="-I${dir}helpers"/>\n');
        
        recursiveLoop('${dir}helpers');

        for(cpp in cppFiles){
            builder.add('\t<file name="$cpp" />\n');
        }

        builder.add("</files>\n");

        var _class = Context.getLocalClass();
		var _pos =  Context.currentPos();
        var _pos_info = Context.getPosInfos(_pos);
		_class.get().meta.add(":buildXml", [{ expr:EConst( CString( '${builder.toString()}' ) ), pos:_pos }], _pos );

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
              if(re.match(path)){
                var ext = re.matched(0);
                if(ext == "cpp") cppFiles.push(path);
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
