package co.zenturi.mandolin.xnative;

#if java 

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.WritableArray;

import co.zenturi.mandolin.xnative.JavascriptMap.IJavascriptMap;
import co.zenturi.mandolin.xnative.JavascriptObject.IJavascriptObject;


@:native("co.zenturi.mandolin.xnative.react.JavascriptArray")
extern class IJavascriptArray {

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
    public function getArray(index:Int):IJavascriptArray;

    @:native('getMap')
    public function getMap(index:Int):IJavascriptMap;

    @:native('getObject')
    public function getObject(index:Int):IJavascriptObject;

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
    public function pushArray(array:IJavascriptArray):Void;

    @:native('pushMap')
    public function pushMap( map:IJavascriptMap):Void;

    @:native('pushObject')
    public function pushObject(value:IJavascriptObject):Void;

    @:native('append')
    public function append(source:IJavascriptArray):Void;
}

@:build(co.zenturi.mandolin.macros.JNI.bind())
@:build(co.zenturi.mandolin.macros.JNI.proxy())
@dep("com.facebook.react.bridge.*")
@:keep
@:nativeGen
class JavascriptArray extends IJavascriptArray {

   
    private var mReadableArray:ReadableArray;
    private var mWritableArray:WritableArray;
   

    
    public function new(?arr:ReadableArray) {
        mWritableArray = arr != null ? null : Arguments.createArray();
        mReadableArray = arr != null ? arr :  cast mWritableArray;
    }
   
    

    override public function size():Int {
        return mReadableArray.size();
    }

    override public function isNull(index:Int):Bool {
        return mReadableArray.isNull(index);
    }

    override public function getBoolean(index:Int):Bool {
        return mReadableArray.getBoolean(index);
    }

    override public function getDouble(index:Int):Float {
        return mReadableArray.getDouble(index);
    }

    override public function getInt(index:Int):Int {
        return mReadableArray.getInt(index);
    }

    override public function getString(index:Int):String {
        return mReadableArray.getString(index);
    }

    override public function getArray(index:Int):IJavascriptArray {
        return MandolinReact.wrap(mReadableArray.getArray(index));
    }

    override public function getMap(index:Int):IJavascriptMap {
        return MandolinReact.wrap(mReadableArray.getMap(index));
    }

    override public function getObject(index:Int):IJavascriptObject {
        return MandolinReact.wrap(mReadableArray.getDynamic(index));
    }

    override public function getType(index:Int):JavascriptType {
        return MandolinReact.wrap(mReadableArray.getType(index));
    }


    override public function pushNull():Void {
        mWritableArray.pushNull();
    }

    
    override public function pushBoolean(value:Bool ):Void {
        mWritableArray.pushBoolean(value);
    }

    
    override public function pushDouble(value:Float ):Void {
        mWritableArray.pushDouble(value);
    }

    
    override public function pushInt(value:Int):Void {
        mWritableArray.pushInt(value);
    }

    
    override public function pushString(value:String):Void {
        mWritableArray.pushString(value);
    }

    
    override public function pushArray(array:MandolinObject<JavascriptArray>):Void {
        mWritableArray.pushArray(MandolinReact.unwrap(array));
    }

    
    override public function pushMap( map:MandolinObject<JavascriptMap>):Void {

        var writer:Dynamic = mWritableArray;
        writer.pushMap(MandolinReact.unwrap(map));
 
        
    }

    
    override public function pushObject(value:MandolinObject<JavascriptObject> ):Void {
        var type:JavascriptType = value.get().getType();
        var _value:JavascriptObject = value;
        switch (type) {
            case JavascriptType.ARRAY:
                mWritableArray.pushArray(MandolinReact.unwrap(_value.asArray()));
            case JavascriptType.BOOLEAN:
                mWritableArray.pushBoolean(_value.asBoolean());
            case JavascriptType.MAP:
                this.pushMap(_value.asMap());
            case JavascriptType.NUMBER:
                mWritableArray.pushDouble(_value.asDouble());
            case JavascriptType.STRING:
                mWritableArray.pushString(_value.asString());
            default: mWritableArray.pushNull();
            case JavascriptType.NIL:
                mWritableArray.pushNull();
        }
    }

    
    override public function append(source:MandolinObject<JavascriptArray> ):Void {
        var _source:JavascriptArray = source;
        if (mWritableArray != null) {
           MandolinReact.copyReactArray(_source.getReadableArray(), mWritableArray);
        }
    }
    @ignore public function getReadableArray():  ReadableArray {
        return mReadableArray;
    }

    @ignore public function getWritableArray():WritableArray {
        return mWritableArray;
    }

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
@:nativeGen
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