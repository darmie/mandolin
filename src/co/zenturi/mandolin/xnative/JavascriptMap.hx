package co.zenturi.mandolin.xnative;

#if ((java || !macro ) && !cpp)
#if java
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
#elseif !macro
@:build(co.zenturi.mandolin.macros.JNI.bind())
@:build(co.zenturi.mandolin.macros.JNI.proxy())
#end
@:keep
class JavascriptMap {
	private var mReadableMap:#if java ReadableMap #else Dynamic #end;
	private var mWritableMap:#if java WritableMap #else Dynamic #end;

	#if java
	public function new(?map:ReadableMap) {
		mWritableMap = map != null ? map : Arguments.createMap();
		mReadableMap = map != null ? null : mWritableMap;
	}
    #else 
    public function new() {
        
    }
    #end

	public function hasKey(name:String):Bool {
		return mReadableMap.hasKey(name);
	}

	public function isNull(name:String):Bool {
		return mReadableMap.isNull(name);
	}

	public function getBoolean(name:String):Bool {
		return mReadableMap.getBool(name);
	}

	public function getDouble(name:String):Float {
		return mReadableMap.getDouble(name);
	}

	public function getInt(name:String):Int {
		return mReadableMap.getInt(name);
	}

	public function getString(name:String):String {
		return mReadableMap.getString(name);
	}

	public function getArray(name:String):MandolinObject<JavascriptArray> {
		return MandolinReact.wrap(mReadableMap.getArray(name));
	}

	public function getMap(name:String):MandolinObject<JavascriptMap> {
		return MandolinReact.wrap(mReadableMap.getMap(name));
	}

	public function getObject(name:String):MandolinObject<JavascriptObject> {
		return MandolinReact.wrap(mReadableMap.getDynamic(name));
	}

	public function getType(?name:String):JavascriptType {
		return MandolinReact.wrap(mReadableMap.getType(name));
	}

	public function keySetIterator():MandolinObject<JavascriptMapKeyIterator> {
		return MandolinReact.wrap(mReadableMap.keySetIterator());
	}

	public function putNull(key:String):Void {
		mWritableMap.putNull(key);
	}

	public function putBoolean(key:String, value:Bool):Void {
		mWritableMap.putBoolean(key, value);
	}

	public function putDouble(key:String, value:Float):Void {
		mWritableMap.putDouble(key, value);
	}

	public function putInt(key:String, value:Int):Void {
		mWritableMap.putInt(key, value);
	}

	public function putString(key:String, value:String):Void {
		mWritableMap.putString(key, value);
	}

	public function putArray(key:String, value:MandolinObject<JavascriptArray>):Void {
        var _value:JavascriptArray = value;
		mWritableMap.putArray(key, MandolinReact.unwrap(_value));
	}

	public function putMap(key:String, value:MandolinObject<JavascriptMap>):Void {
        var _value:JavascriptMap = value;
		mWritableMap.putMap(key, MandolinReact.unwrap(_value));
	}

	public function putObject(key:String, value:MandolinObject<JavascriptObject>):Void {
		var _value:JavascriptObject = value;
		var type:JavascriptType = _value.getType();
		switch (type) {
			case JavascriptType.ARRAY:
				mWritableMap.putArray(key, MandolinReact.unwrap(_value.asArray()));
			case JavascriptType.BOOLEAN:
				mWritableMap.putBoolean(key, _value.asBoolean());

			case JavascriptType.MAP:
				mWritableMap.putMap(key, MandolinReact.unwrap(_value.asMap()));

			case JavascriptType.NUMBER:
				mWritableMap.putDouble(key, _value.asDouble());

			case JavascriptType.STRING:
				mWritableMap.putString(key, _value.asString());

			default: mWritableMap.putNull(key);
			case JavascriptType.NIL:
				mWritableMap.putNull(key);
		}
	}

	public function merge(source:MandolinObject<JavascriptMap>):Void {
		var _s:JavascriptMap = source;
		#if java mWritableMap.merge(_s.getReadableMap()); #end
	}

	#if java
	public function getReadableMap():#if java ReadableMap #else Dynamic #end {
		return mReadableMap;
	}

	public function getWritableMap():#if java WritableMap #else Dynamic #end {
		return mWritableMap;
	}
	#end
}
#elseif cpp
@:headerCode('
#include <cstdint>
#include <memory>
#include <string>

class JavascriptArray;
class JavascriptMapKeyIterator;
class JavascriptObject;
enum class JavascriptType;

class JavascriptMap {
public:
    virtual ~JavascriptMap() {}

    virtual bool hasKey(const std::string & name) = 0;

    virtual bool isNull(const std::string & name) = 0;

    virtual bool getBoolean(const std::string & name) = 0;

    virtual double getDouble(const std::string & name) = 0;

    virtual int32_t getInt(const std::string & name) = 0;

    virtual std::string getString(const std::string & name) = 0;

    virtual std::shared_ptr<JavascriptArray> getArray(const std::string & name) = 0;

    virtual std::shared_ptr<JavascriptMap> getMap(const std::string & name) = 0;

    virtual std::shared_ptr<JavascriptObject> getObject(const std::string & name) = 0;

    virtual JavascriptType getType(const std::string & name) = 0;

    virtual std::shared_ptr<JavascriptMapKeyIterator> keySetIterator() = 0;

    virtual void putNull(const std::string & key) = 0;

    virtual void putBoolean(const std::string & key, bool value) = 0;

    virtual void putDouble(const std::string & key, double value) = 0;

    virtual void putInt(const std::string & key, int32_t value) = 0;

    virtual void putString(const std::string & key, const std::string & value) = 0;

    virtual void putArray(const std::string & key, const std::shared_ptr<JavascriptArray> & value) = 0;

    virtual void putMap(const std::string & key, const std::shared_ptr<JavascriptMap> & value) = 0;

    virtual void putObject(const std::string & key, const std::shared_ptr<JavascriptObject> & value) = 0;

    virtual void merge(const std::shared_ptr<JavascriptMap> & source) = 0;
};
')
@:keep 
interface IJavascriptMap {}
@:include('co/zenturi/mandolin/xnative/IJavascriptArray.h')
@:include('co/zenturi/mandolin/xnative/IJavascriptMap.h')
@:include('co/zenturi/mandolin/xnative/IJavascriptObject.h')
@:native('std::shared_ptr<::JavascriptMap>')
extern class JavascriptMap {

    public static inline function init():JavascriptMap {
        return untyped __cpp__('std::make_shared<::JavascriptMap>()');
    }
    
	@:native('hasKey')
	public function hasKey(name:String):Bool;
	@:native('isNull')
	public function isNull(name:String):Bool;
	@:native('getBoolean')
	public function getBoolean(name:String):Bool;
	@:native('getDouble')
	public function getDouble(name:String):Float;
	@:native('getInt')
	public function getInt(name:String):Int;
	@:native('getString')
	public function getString(name:String):String;
	@:native('getArray')
	public function getArray(name:String):JavascriptArray;
	@:native('getMap')
	public function getMap(name:String):JavascriptMap;
	@:native('getObject')
	public function getObject(name:String):JavascriptObject;
	@:native('getType')
	public function getType(?name:String):JavascriptType;
	@:native('keySetIterator')
	public function keySetIterator():JavascriptMapKeyIterator;
	@:native('putNull')
	public function putNull(key:String):Void;
	@:native('putBoolean')
	public function putBoolean(key:String, value:Bool):Void;
	@:native('putDouble')
	public function putDouble(key:String, value:Float):Void;
	@:native('putInt')
	public function putInt(key:String, value:Int):Void;
	@:native('putString')
	public function putString(key:String, value:String):Void;
	@:native('putArray')
	public function putArray(key:String, value:JavascriptArray):Void;
	@:native('putMap')
	public function putMap(key:String, value:JavascriptMap):Void;
	@:native('putObject')
	public function putObject(key:String, value:JavascriptObject):Void;
	@:native('merge')
	public function merge(source:JavascriptMap):Void;
}
#end
