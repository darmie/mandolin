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

    macro static public function bind():Array<Field> {
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
    
    static function genCpp(){
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
    
    static function genCppNamespace(path: String) {
        var dir = Sys.getCwd();

		var pack = Context.getLocalModule();
		var pathLength = pack.split(".").length;
		var unpack = pack.split(".");
		var packPath = unpack.slice(0, pathLength - 1).join("/");
		var classPath = '${dir}gen/cpp/$packPath/react';
		if (!FileSystem.exists(classPath)) {
			FileSystem.createDirectory(classPath);
		}

		File.saveContent('$classPath/$moduleName.cpp', '');

        constructCPPNamespace('$classPath/$moduleName.cpp');

        File.saveContent('$classPath/$moduleName.hpp', '');

        constructCPPHeader('$classPath/$moduleName.hpp');
        
    }

    static function constructCPPNamespace(name: String) {
        var sbuf = new StringBuf();
        sbuf.add("// AUTOGENERATED FILE - DO NOT MODIFY!\n");
        sbuf.add("// This file is generated by Mandolin - (c) Zenturi.co\n\n");
        sbuf.add('#include "$moduleName.hpp"\n\n');
        sbuf.add("namespace mandolin_generated {\n\n");
        sbuf.add("}\n");

        File.saveContent(name, sbuf.toString());
    }


    static function constructCPPHeader(name: String) {
        var sbuf = new StringBuf();
        var pack = Context.getLocalModule();
        var nHeader = pack.replace(".", "/");
        sbuf.add("#pragma once\n\n");
        
        sbuf.add('#include <$nHeader.h>\n\n');
        sbuf.add('#include <mandolin_helpers.h>\n\n');

        sbuf.add("namespace mandolin_generated {\n\n");
        sbuf.add("}\n");

        File.saveContent(name, sbuf.toString());
    }

}