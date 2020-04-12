package co.zenturi.mandolin.xnative.react;

import com.facebook.react.bridge.*;
import co.zenturi.mandolin.xnative.JavascriptType;
import java.util.concurrent.atomic.AtomicBoolean;

public abstract class JavascriptCallback {
	public abstract void invoke (JavascriptObject[] args);
	public abstract void invokeSingleArg (JavascriptObject o);
}
