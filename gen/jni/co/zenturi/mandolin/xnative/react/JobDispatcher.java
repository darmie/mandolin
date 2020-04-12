package co.zenturi.mandolin.xnative.react;

import co.zenturi.mandolin.xnative.JavascriptType;
import java.util.concurrent.atomic.AtomicBoolean;

public abstract class JobDispatcher {
	public abstract boolean isDestroyed ();
	public abstract void start ();
	public abstract void quit ();
}
