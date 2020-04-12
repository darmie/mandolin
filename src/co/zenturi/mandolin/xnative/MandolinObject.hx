package co.zenturi.mandolin.xnative;

import haxe.Serializer;
import haxe.Unserializer;
@:nativeGen
abstract MandolinObject<T>(Dynamic) from Dynamic to T to String to Int to Float to haxe.Int64 {
    inline function new(x:Dynamic){
        if(Std.is(x, String)) this = Unserializer.run(x);
        else this = x;
    }

    @:to public inline function get():T {
        return this;
    }

    @:to public inline function toString():String {
        return Serializer.run(this);
    }

    @:from public static inline function fromString(s:String):MandolinObject<Dynamic> {
        return new MandolinObject<Dynamic>(s);
    }
}
