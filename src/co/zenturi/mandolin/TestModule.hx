package co.zenturi.mandolin;

import co.zenturi.mandolin.react.ReactModule;

@:keep
class TestModule implements  ReactModule {

    @:isVar public var value(get, set):String;

    public function new() {}
    
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

    function set_update(callback:String->Int) {
        
    }

    function add(x:Int, y:haxe.Int64):Int{
        return 0;
    }

    function testArray(arr:Array<String>){

    }

    function testMap(map:Map<String, Int>){
        
    }
}