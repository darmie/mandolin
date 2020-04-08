package co.zenturi.mandolin.xnative;

#if ((java || !macro ) && !cpp)
@:build(co.zenturi.mandolin.macros.JNI.bind())
@:keep
#if java
interface JavascriptObject {
    public  function getType():JavascriptType;
    public  function isNull():Bool;
    public  function asBoolean():Bool;
    public  function asDouble():Float;

    public  function asInt():Int;

    public  function asString():String;

    public  function asArray():JavascriptArray;
    public  function asMap():JavascriptMap;

    @native @static public function fromNull():JavascriptObject;
    @native @static public function fromBoolean(value:Bool):JavascriptObject;
    @native @static public function fromDouble(value:Float):JavascriptObject;

    @native @static public function fromInt(value:Int):JavascriptObject;
    @native @static public function fromString(value:String):JavascriptObject;
    @native @static public function fromArray(value:JavascriptArray):JavascriptObject;
    @native @static public function fromMap(value:JavascriptMap):JavascriptObject;

}
#else 
class JavascriptObject {
    public  function getType():MandolinObject<JavascriptType> {
        return null;
    }
    public  function isNull():Bool {
        return false;
    }
    public  function asBoolean():Bool { return false;}
    public  function asDouble():Float { return 0;}

    public  function asInt():Int { return 0;}

    public  function asString():String { return null;}

    public  function asArray():MandolinObject<JavascriptArray> { return null;}
    public  function asMap():MandolinObject<JavascriptMap> {return null;}

    @native @static public static function fromNull():MandolinObject<JavascriptObject> {return null;}
    @native @static public static function fromBoolean(value:Bool):MandolinObject<JavascriptObject> {return null;}
    @native @static public static function fromDouble(value:Float):MandolinObject<JavascriptObject> {return null;}

    @native @static public static function fromInt(value:Int):MandolinObject<JavascriptObject> {return null;}
    @native @static public static function fromString(value:String):MandolinObject<JavascriptObject> {return null;}
    @native @static public static function fromArray(value:MandolinObject<JavascriptArray>):MandolinObject<JavascriptObject> {return null;}
    @native @static public static function fromMap(value:MandolinObject<JavascriptMap>):MandolinObject<JavascriptObject> {return null;}

}
#end
#elseif cpp 
import haxe.io.FPHelper;

@:headerCode('
#include <cstdint>
#include <memory>
#include <string>
#include <co/zenturi/mandolin/xnative/IJavascriptType.h>
#include <hxcpp.h>



class JavascriptArray;
class JavascriptMap;
enum class JavascriptType;

class JavascriptObject {
public:
    virtual ~JavascriptObject() {}

    virtual JavascriptType getType() = 0;

    virtual bool isNull() = 0;

    static std::shared_ptr<JavascriptObject> fromNull();

    virtual bool asBoolean() = 0;

    static std::shared_ptr<JavascriptObject> fromBoolean(bool value);

    virtual double asDouble() = 0;

    static std::shared_ptr<JavascriptObject> fromDouble(double value);

    virtual int32_t asInt() = 0;

    static std::shared_ptr<JavascriptObject> fromInt(int32_t value);

    virtual std::string asString() = 0;

    static std::shared_ptr<JavascriptObject> fromString(const std::string & value);

    virtual std::shared_ptr<JavascriptArray> asArray() = 0;

    static std::shared_ptr<JavascriptObject> fromArray(const std::shared_ptr<JavascriptArray> & value);

    virtual std::shared_ptr<JavascriptMap> asMap() = 0;

    virtual ::Dynamic asHaxeObject() = 0;

    static std::shared_ptr<JavascriptObject> fromMap(const std::shared_ptr<JavascriptMap> & value);
    static std::shared_ptr<JavascriptObject> fromHaxe(::Dynamic value);
};
')
@:keep
interface IJavascriptObject {
}
@:include('co/zenturi/mandolin/xnative/IJavascriptArray.h')
@:include('co/zenturi/mandolin/xnative/IJavascriptMap.h')
@:include('co/zenturi/mandolin/xnative/IJavascriptObject.h')
@:include('co/zenturi/mandolin/xnative/IJavascriptType.h')
@:native('std::shared_ptr<::JavascriptObject>')
extern class JavascriptObject {
    public static inline function init():JavascriptObject {
        return untyped __cpp__('std::make_shared<::JavascriptObject>()');
    }
    @:native('getType')
    public function getType():JavascriptType;

    @:native('isNull')
    public  function isNull():Bool;

    @:native('fromNull')
    public function fromNull():JavascriptObject;

    @:native('asBoolean')
    public function asBoolean():Bool;

    @:native('asDouble')
    public function asDouble():Float;

    @:native('fromBoolean')
    public function fromBoolean(b:Bool):JavascriptObject;

    @:native('fromDouble')
    public function fromDouble(d:Float):JavascriptObject;

    @:native('asInt')
    public function asInt():Int;

    @:native('fromInt')
    public function fromInt(i:Int):JavascriptObject;


    @:native('asString')
    public function asString():String;

    @:native('fromString')
    public function fromString(s:String):JavascriptObject;

    @:native('asArray')
    public function asArray():JavascriptArray;

    @:native('fromArray')
    public function fromArray(a:JavascriptArray):JavascriptObject;

    @:native('fromMap')
    public function fromMap(a:JavascriptMap):JavascriptObject;

    @:native('asHaxeObject')
    public function asHaxeObject():Dynamic;

    @:native('fromHaxe')
    public function fromHaxe(d:Dynamic):JavascriptObject;

}
#end