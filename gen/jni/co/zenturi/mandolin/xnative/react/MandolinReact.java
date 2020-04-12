package co.zenturi.mandolin.xnative.react;

import com.facebook.react.bridge.*;
import co.zenturi.mandolin.xnative.JavascriptType;
import java.util.concurrent.atomic.AtomicBoolean;

public abstract class MandolinReact {
	public static native ReactBridge createReactBridge (ReactApplicationContext context);
	public static native JavascriptMap createMap (JavascriptMap map);
	public static native JavascriptArray createArray (JavascriptArray arr);
	public static native Object wrap (Object object);
	public static native Object unwrap (Object value);
	public static native void copyReactArray (ReadableArray source,WritableArray dest);
	public static native void copyReactMap (ReadableMap source,WritableMap dest);
}
