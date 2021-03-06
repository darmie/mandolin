package co.zenturi.mandolin.xnative.react;

import co.zenturi.mandolin.xnative.JavascriptType;
import java.util.concurrent.atomic.AtomicBoolean;

public abstract class JobQueue {
	public abstract Job poll ();
	public abstract void interruptPoll ();
	private static final class CppProxy extends JobQueue {
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
		public Job poll (){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			return native_poll(nativeRef);
		}
		private native Job native_poll (long _nativeRef);

		@Override
		public void interruptPoll (){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_interruptPoll(nativeRef);
		}
		private native void native_interruptPoll (long _nativeRef);

	}
}
