package co.zenturi.mandolin.xnative.react;

#if java 


import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;

import co.zenturi.mandolin.xnative.react.JavascriptObject.IJavascriptObject;
import co.zenturi.mandolin.xnative.react.JavascriptArray.IJavascriptArray;
import co.zenturi.mandolin.xnative.react.JavascriptMapKeyIterator.IJavascriptMapKeyIterator;

@:native('co.zenturi.mandolin.xnative.react.JavascriptMap')
extern class IJavascriptMap {
    
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
	public function getArray(name:String):IJavascriptArray;
	@:native('getMap')
	public function getMap(name:String):IJavascriptMap;
	@:native('getObject')
	public function getObject(name:String):IJavascriptObject;
	@:native('getType')
	public function getType(?name:String):JavascriptType;
	@:native('keySetIterator')
	public function keySetIterator():IJavascriptMapKeyIterator;
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
	public function putArray(key:String, value:IJavascriptArray):Void;
	@:native('putMap')
	public function putMap(key:String, value:IJavascriptMap):Void;
	@:native('putObject')
	public function putObject(key:String, value:IJavascriptObject):Void;
	@:native('merge')
	public function merge(source:IJavascriptMap):Void;
}


@:build(co.zenturi.mandolin.macros.JNI.bind())
@:build(co.zenturi.mandolin.macros.JNI.proxy())
@dep("com.facebook.react.bridge.*")
@:nativeGen
@:keep
@:native('co.zenturi.mandolin.xnative.JavascriptMap')
class JavascriptMap extends IJavascriptMap {
	
	private var mReadableMap:ReadableMap;
	private var mWritableMap:WritableMap;
	


	public function new(?map:ReadableMap) {
		mWritableMap = map != null ? null : Arguments.createMap();
		mReadableMap = map != null ? map : cast mWritableMap;
	}
	
    

	override public function hasKey(name:String):Bool {
		return mReadableMap.hasKey(name);
	}

	override public function isNull(name:String):Bool {
		return mReadableMap.isNull(name);
	}

	override public function getBoolean(name:String):Bool {
		return mReadableMap.getBoolean(name);
	}

	override public function getDouble(name:String):Float {
		return mReadableMap.getDouble(name);
	}

	override public function getInt(name:String):Int {
		return mReadableMap.getInt(name);
	}

	override public function getString(name:String):String {
		return mReadableMap.getString(name);
	}

	override public function getArray(name:String):IJavascriptArray {
		return MandolinReact.wrap(mReadableMap.getArray(name));
	}

	override public function getMap(name:String):IJavascriptMap {
		return MandolinReact.wrap(mReadableMap.getMap(name));
	}

	override public function getObject(name:String):IJavascriptObject {
		return MandolinReact.wrap(mReadableMap.getDynamic(name));
	}

	override public function getType(?name:String):JavascriptType {
		return MandolinReact.wrap(mReadableMap.getType(name));
	}

	override public function keySetIterator():IJavascriptMapKeyIterator {
		return MandolinReact.wrap(mReadableMap.keySetIterator());
	}

	override public function putNull(key:String):Void {
		mWritableMap.putNull(key);
	}

	override public function putBoolean(key:String, value:Bool):Void {
		mWritableMap.putBoolean(key, value);
	}

	override public function putDouble(key:String, value:Float):Void {
		mWritableMap.putDouble(key, value);
	}

	override public function putInt(key:String, value:Int):Void {
		mWritableMap.putInt(key, value);
	}

	override public function putString(key:String, value:String):Void {
		mWritableMap.putString(key, value);
	}

	override public function putArray(key:String, value:IJavascriptArray):Void {
        var _value:JavascriptArray = cast value;
		mWritableMap.putArray(key, MandolinReact.unwrap(_value));
	}

	override public function putMap(key:String, value:IJavascriptMap):Void {
        var _value:JavascriptMap = cast value;
		mWritableMap.putMap(key, MandolinReact.unwrap(_value));
	}

	override public function putObject(key:String, value:IJavascriptObject):Void {
		var _value:JavascriptObject = cast value;
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

	override public function merge(source:IJavascriptMap):Void {
		var _s:JavascriptMap = cast source;
		mWritableMap.merge(_s.getReadableMap()); 
	}


	@ignore public function getReadableMap(): ReadableMap {
		return mReadableMap;
	}

	@ignore public function getWritableMap():WritableMap {
		return mWritableMap;
	}
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
@:nativeGen
interface IJavascriptMap {}
@:include('co/zenturi/mandolin/xnative/react/IJavascriptArray.h')
@:include('co/zenturi/mandolin/xnative/react/IJavascriptMap.h')
@:include('co/zenturi/mandolin/xnative/react/IJavascriptObject.h')
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
