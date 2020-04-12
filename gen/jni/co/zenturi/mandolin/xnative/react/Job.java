package co.zenturi.mandolin.xnative.react;

import co.zenturi.mandolin.xnative.JavascriptType;
import java.util.concurrent.atomic.AtomicBoolean;

public abstract class Job {
	public abstract void run ();
	private static final class CppProxy extends Job {
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
		public void run (){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_run(nativeRef);
		}
		private native void native_run (long _nativeRef);

	}
}
