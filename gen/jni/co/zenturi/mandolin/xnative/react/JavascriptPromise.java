package co.zenturi.mandolin.xnative.react;

import co.zenturi.mandolin.xnative.JavascriptType;
import java.util.concurrent.atomic.AtomicBoolean;

public abstract class JavascriptPromise {
	public abstract void resolveMap (JavascriptMap map);
	public abstract void resolveArray (JavascriptArray arr);
	public abstract void resolveObject (JavascriptObject obj);
	public abstract void resolveDouble (double v);
	public abstract void resolveInt (int v);
	public abstract void resolveString (String v);
	public abstract void resolveNull ();
	public abstract void resolveBoolean (boolean v);
	public abstract void reject (String code,String message);
}
