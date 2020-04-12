package co.zenturi.mandolin.xnative.react;

import com.facebook.react.bridge.*;
import co.zenturi.mandolin.xnative.JavascriptType;
import java.util.concurrent.atomic.AtomicBoolean;

public abstract class ReactBridge {
	public abstract JavascriptMap createMap ();
	public abstract JavascriptArray createArray ();
	public abstract JavascriptMap copyMap (JavascriptMap m);
	public abstract JavascriptArray copyArray (JavascriptArray a);
	public abstract void emitEventWithMap (String name,JavascriptMap params);
	public abstract void emitEventWithArray (String name,JavascriptArray params);
	public abstract JobDispatcher createJobDispatcher (JobQueue queue);
}
