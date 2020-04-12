package co.zenturi.mandolin.xnative.react;

import com.facebook.react.bridge.ReadableMapKeySetIterator;
import co.zenturi.mandolin.xnative.JavascriptType;
import java.util.concurrent.atomic.AtomicBoolean;

public abstract class JavascriptMapKeyIterator {
	public abstract boolean hasNextKey ();
	public abstract String nextKey ();
}
