package co.zenturi.mandolin.xnative.react;

import co.zenturi.mandolin.xnative.JavascriptType;
import java.util.concurrent.atomic.AtomicBoolean;

public abstract class JavascriptObject {
	public abstract JavascriptType getType ();
	public abstract boolean isNull ();
	public abstract boolean asBoolean ();
	public abstract double asDouble ();
	public abstract int asInt ();
	public abstract String asString ();
	public abstract JavascriptArray asArray ();
	public abstract JavascriptMap asMap ();
	public static native JavascriptObject fromNull ();
	public static native JavascriptObject fromBoolean (boolean value);
	public static native JavascriptObject fromDouble (double value);
	public static native JavascriptObject fromString (String value);
	public static native JavascriptObject fromArray (JavascriptArray value);
	public static native JavascriptObject fromMap (JavascriptMap value);
	private static final class CppProxy extends JavascriptObject {
		private final long nativeRef;
		private final AtomicBoolean destroyed = new AtomicBoolean(false);
		private CppProxy(long nativeRef) {
			if (nativeRef == 0) throw new RuntimeException("nativeRef is zero");
			this.nativeRef = nativeRef;
		}
		private native void nativeDestroy(long nativeRef);
		public void destroy(){
			boolean destroyed = this.destroyed.getAndSet(true);
			if (!destroyed) nativeDestroy(this.nativeRef);
		}
		protected void finalize() throws java.lang.Throwable {
			destroy();
			super.finalize();
		}
		@Override
		public JavascriptType getType (){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			return native_getType(nativeRef);
		}
		private native JavascriptType native_getType (long _nativeRef);

		@Override
		public boolean isNull (){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			return native_isNull(nativeRef);
		}
		private native boolean native_isNull (long _nativeRef);

		@Override
		public boolean asBoolean (){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			return native_asBoolean(nativeRef);
		}
		private native boolean native_asBoolean (long _nativeRef);

		@Override
		public double asDouble (){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			return native_asDouble(nativeRef);
		}
		private native double native_asDouble (long _nativeRef);

		@Override
		public int asInt (){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			return native_asInt(nativeRef);
		}
		private native int native_asInt (long _nativeRef);

		@Override
		public String asString (){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			return native_asString(nativeRef);
		}
		private native String native_asString (long _nativeRef);

		@Override
		public JavascriptArray asArray (){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			return native_asArray(nativeRef);
		}
		private native JavascriptArray native_asArray (long _nativeRef);

		@Override
		public JavascriptMap asMap (){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			return native_asMap(nativeRef);
		}
		private native JavascriptMap native_asMap (long _nativeRef);

	}
}
