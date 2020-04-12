package co.zenturi.mandolin.xnative.react;

import com.facebook.react.bridge.*;
import co.zenturi.mandolin.xnative.JavascriptType;
import java.util.concurrent.atomic.AtomicBoolean;

public abstract class JavascriptArray {
	public abstract int size ();
	public abstract boolean isNull (int index);
	public abstract boolean getBoolean (int index);
	public abstract double getDouble (int index);
	public abstract int getInt (int index);
	public abstract String getString (int index);
	public abstract JavascriptArray getArray (int index);
	public abstract JavascriptMap getMap (int index);
	public abstract JavascriptObject getObject (int index);
	public abstract JavascriptType getType (int index);
	public abstract void pushNull ();
	public abstract void pushBoolean (boolean value);
	public abstract void pushDouble (double value);
	public abstract void pushInt (int value);
	public abstract void pushString (String value);
	public abstract void pushArray (JavascriptArray array);
	public abstract void pushMap (JavascriptMap map);
	public abstract void pushObject (JavascriptObject value);
	public abstract void append (JavascriptArray source);
	public abstract ReadableArray getReadableArray ();
	public abstract WritableArray getWritableArray ();
}
