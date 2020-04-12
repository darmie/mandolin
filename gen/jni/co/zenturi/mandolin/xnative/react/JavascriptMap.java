package co.zenturi.mandolin.xnative.react;

import com.facebook.react.bridge.*;
import co.zenturi.mandolin.xnative.JavascriptType;
import java.util.concurrent.atomic.AtomicBoolean;

public abstract class JavascriptMap {
	public abstract boolean hasKey (String name);
	public abstract boolean isNull (String name);
	public abstract boolean getBoolean (String name);
	public abstract double getDouble (String name);
	public abstract int getInt (String name);
	public abstract String getString (String name);
	public abstract JavascriptArray getArray (String name);
	public abstract JavascriptMap getMap (String name);
	public abstract JavascriptObject getObject (String name);
	public abstract JavascriptType getType (String name);
	public abstract JavascriptMapKeyIterator keySetIterator ();
	public abstract void putNull (String key);
	public abstract void putBoolean (String key,boolean value);
	public abstract void putDouble (String key,double value);
	public abstract void putInt (String key,int value);
	public abstract void putString (String key,String value);
	public abstract void putArray (String key,JavascriptArray value);
	public abstract void putMap (String key,JavascriptMap value);
	public abstract void putObject (String key,JavascriptObject value);
	public abstract void merge (JavascriptMap source);
	public abstract ReadableMap getReadableMap ();
	public abstract WritableMap getWritableMap ();
}
