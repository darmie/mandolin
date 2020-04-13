package co.zenturi.mandolin;

#if cpp
import co.zenturi.mandolin.xnative.react.*;

@:build(co.zenturi.mandolin.macros.ReactModule.bind())
@:build(co.zenturi.mandolin.macros.ReactModuleCpp.bind(true))
@:keep
@:unreflective
@:nativeGen
class TestModule {

    @:isVar public var value(get, set):String;

    public function new(x:Int) {}
    
    @:keep
    public function doSomething() {
        trace("hello world");
    }

    function get_value():String {
        return value;  
    }

    function set_value(value:String):String {
        this.value = value;

        return this.value;
    }

    function set_update(callback:JavascriptCallback) {
        
    }

    function add(x:Int, y:haxe.Int64):Int{
        return 0;
    }

    function testArray(arr:JavascriptArray):JavascriptArray {
        return arr;
    }

    function testMap(map:JavascriptMap):JavascriptMap {
        return map;
    }
}
#end