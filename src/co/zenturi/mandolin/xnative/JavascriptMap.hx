package co.zenturi.mandolin.xnative;

#if (!macro || java)
#if java
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
#elseif !macro
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

	public function getType(?name:String):MandolinObject<JavascriptType> {
		return MandolinReact.wrap(mReadableMap.getType(name));
	}

	public function keySetIterator():MandolinObject<JavascriptMapKeyIterator> {
		return MandolinReact.wrap(mReadableMap.keySetIterator());
	}

	public function putNull(key:String) {
		mWritableMap.putNull(key);
	}

	public function putBoolean(key:String, value:Bool) {
		mWritableMap.putBoolean(key, value);
	}

	public function putDouble(key:String, value:Float) {
		mWritableMap.putDouble(key, value);
	}

	public function putInt(key:String, value:Int) {
		mWritableMap.putInt(key, value);
	}

	public function putString(key:String, value:String) {
		mWritableMap.putString(key, value);
	}

	public function putArray(key:String, value:MandolinObject<JavascriptArray>) {
        var _value:JavascriptArray = value;
		mWritableMap.putArray(key, MandolinReact.unwrap(_value));
	}

	public function putMap(key:String, value:MandolinObject<JavascriptMap>) {
        var _value:JavascriptMap = value;
		mWritableMap.putMap(key, MandolinReact.unwrap(_value));
	}

	public function putObject(key:String, value:MandolinObject<JavascriptObject>) {
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

	public function merge(source:MandolinObject<JavascriptMap>) {
		var _s:JavascriptMap = source;
		mWritableMap.merge(_s.getReadableMap());
	}

	public function getReadableMap() {
		return mReadableMap;
	}

	public function getWritableMap() {
		return mWritableMap;
	}
}
#end
