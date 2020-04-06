package co.zenturi.mandolin.xnative;

import haxe.Serializer;
import haxe.Unserializer;

abstract MandolinObject<T>(Dynamic) from Dynamic to T to String {
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

    @:from public static inline function fromString<T>(s:String):MandolinObject<T> {
        return new MandolinObject<T>(s);
    }
}
