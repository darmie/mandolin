package co.zenturi.mandolin.xnative;

#if ((java || !macro ) && !cpp)
#if java
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.WritableArray;
#end
@:build(co.zenturi.mandolin.macros.JNI.bind())
@:build(co.zenturi.mandolin.macros.JNI.proxy())
@:keep
class JavascriptArray {
   
    private var mReadableArray: #if java ReadableArray #else Dynamic #end;
    private var mWritableArray: #if java WritableArray #else Dynamic #end;

    #if java
    public function new(?arr:ReadableArray) {
        mWritableArray = arr != null ? arr : Arguments.createArray();
        mReadableArray = arr != null ? null : mWritableArray;
    }
    #else 
    public function new() {

    }
    #end

    public function size():Int {
        return mReadableArray.size();
    }

    public function isNull(index:Int):Bool {
        return mReadableArray.isNull(index);
    }

    public function getBoolean(index:Int):Bool {
        return mReadableArray.getBoolean(index);
    }

    public function getDouble(index:Int):Float {
        return mReadableArray.getDouble(index);
    }

    public function getInt(index:Int):Int {
        return mReadableArray.getInt(index);
    }

    public function getString(index:Int):String {
        return mReadableArray.getString(index);
    }

    public function getArray(index:Int):MandolinObject<JavascriptArray> {
        return MandolinReact.wrap(mReadableArray.getArray(index));
    }

    public function getMap(index:Int):MandolinObject<JavascriptMap> {
        return MandolinReact.wrap(mReadableArray.getMap(index));
    }

    public function getObject(index:Int):JavascriptObject {
        return MandolinReact.wrap(mReadableArray.getDynamic(index));
    }

    public function getType(index:Int):JavascriptType {
        return MandolinReact.wrap(mReadableArray.getType(index));
    }


    public function pushNull():Void {
        mWritableArray.pushNull();
    }

    
    public function pushBoolean(value:Bool ):Void {
        mWritableArray.pushBoolean(value);
    }

    
    public function pushDouble(value:Float ):Void {
        mWritableArray.pushDouble(value);
    }

    
    public function pushInt(value:Int):Void {
        mWritableArray.pushInt(value);
    }

    
    public function pushString(value:String):Void {
        mWritableArray.pushString(value);
    }

    
    public function pushArray(array:MandolinObject<JavascriptArray>):Void {
        mWritableArray.pushArray(MandolinReact.unwrap(array));
    }

    
    public function pushMap( map:MandolinObject<JavascriptMap>):Void {
        mWritableArray.pushMap(MandolinReact.unwrap(map));
    }

    
    public function pushObject(value:MandolinObject<JavascriptObject> ):Void {
        var type:JavascriptType = value.get().getType();
        var _value:JavascriptObject = value;
        switch (type) {
            case JavascriptType.ARRAY:
                mWritableArray.pushArray(MandolinReact.unwrap(_value.asArray()));
            case JavascriptType.BOOLEAN:
                mWritableArray.pushBoolean(_value.asBoolean());
            case JavascriptType.MAP:
                mWritableArray.pushMap(MandolinReact.unwrap(_value.asMap()));
            case JavascriptType.NUMBER:
                mWritableArray.pushDouble(_value.asDouble());
            case JavascriptType.STRING:
                mWritableArray.pushString(_value.asString());
            default: mWritableArray.pushNull();
            case JavascriptType.NIL:
                mWritableArray.pushNull();
        }
    }

    
    public function append(source:MandolinObject<JavascriptArray> ):Void {
        var _source:JavascriptArray = source;
        if (mWritableArray != null) {
           #if java MandolinReact.copyReactArray(_source.getReadableArray(), mWritableArray); #end
        }
    }
    #if java
    public function getReadableArray(): #if  java ReadableArray #else Dynamic #end {
        return mReadableArray;
    }

    public function getWritableArray():#if  java ReadableArray #else Dynamic #end {
        return mWritableArray;
    }
    #end

}
#elseif cpp
@:headerCode('
#include <cstdint>
#include <memory>

class JavascriptMap;
class JavascriptObject;
enum class JavascriptType;

class JavascriptArray {
public:
    virtual ~JavascriptArray() {}

    virtual int32_t size() = 0;

    virtual bool isNull(int32_t index) = 0;

    virtual bool getBoolean(int32_t index) = 0;

    virtual double getDouble(int32_t index) = 0;

    virtual int32_t getInt(int32_t index) = 0;

    virtual std::string getString(int32_t index) = 0;

    virtual std::shared_ptr<JavascriptArray> getArray(int32_t index) = 0;

    virtual std::shared_ptr<JavascriptMap> getMap(int32_t index) = 0;

    virtual std::shared_ptr<JavascriptObject> getObject(int32_t index) = 0;

    virtual JavascriptType getType(int32_t index) = 0;

    virtual void pushNull() = 0;

    virtual void pushBoolean(bool value) = 0;

    virtual void pushDouble(double value) = 0;

    virtual void pushInt(int32_t value) = 0;

    virtual void pushString(const std::string & value) = 0;

    virtual void pushArray(const std::shared_ptr<JavascriptArray> & array) = 0;

    virtual void pushMap(const std::shared_ptr<JavascriptMap> & map) = 0;

    virtual void pushObject(const std::shared_ptr<JavascriptObject> & object) = 0;

    virtual void append(const std::shared_ptr<JavascriptArray> & source) = 0;
};
')
@:keep
interface IJavascriptArray{

}
@:include('co/zenturi/mandolin/xnative/IJavascriptArray.h')
@:include('co/zenturi/mandolin/xnative/IJavascriptMap.h')
@:include('co/zenturi/mandolin/xnative/IJavascriptObject.h')
@:include('co/zenturi/mandolin/xnative/IJavascriptType.h')
@:native('std::shared_ptr<::JavascriptArray>')
extern class JavascriptArray {
    public static inline function init():JavascriptArray {
        return untyped __cpp__('std::make_shared<::JavascriptArray>()');
    }

    @:native('size')
    public function size():Int;

    @:native('isNull')
    public function isNull(index:Int):Bool;

    @:native('getBoolean')
    public function getBoolean(index:Int):Bool;

    @:native('getDouble')
    public function getDouble(index:Int):Float;
    
    @:native('getInt')
    public function getInt(index:Int):Int; 

    @:native('getString')
    public function getString(index:Int):String; 

    @:native('getArray')
    public function getArray(index:Int):JavascriptArray;

    @:native('getMap')
    public function getMap(index:Int):JavascriptMap;

    @:native('getObject')
    public function getObject(index:Int):JavascriptObject;

    @:native('getType')
    public function getType(index:Int):JavascriptType;

    @:native('pushNull')
    public function pushNull():Void;

    @:native('pushBoolean')
    public function pushBoolean(value:Bool ):Void;

    @:native('pushDouble')
    public function pushDouble(value:Float ):Void;

    @:native('pushInt')
    public function pushInt(value:Int):Void;

    @:native('pushString')
    public function pushString(value:String):Void;

    @:native('pushArray')
    public function pushArray(array:JavascriptArray):Void;

    @:native('pushMap')
    public function pushMap( map:JavascriptMap):Void;

    @:native('pushObject')
    public function pushObject(value:JavascriptObject):Void;

    @:native('append')
    public function append(source:JavascriptArray):Void;

}
#end