// AUTOGENERATED FILE - DO NOT MODIFY!
// This file is generated by Mandolin - (c) Zenturi.co

package co.zenturi.mandolin.react;

import co.zenturi.madolin.Mandolin;
import com.facebook.react.bridge.*;
import com.facebook.react.module.annotations.ReactModule;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;

@ReactModule(name = "TestModule")
public final class TestModule extends ReactContextBaseJavaModule {

	private final CppProxy mModule;

	public TestModule(ReactApplicationContext reactContext){
		super(reactContext);
		mModule = create(Mandolin.createReactBridge(reactContext));
	}

	private static native CppProxy create(co.zenturi.mandolin.ReactBridge bridge);

	@ReactMethod
	public void init(){
		mModule.init();
	}


	@ReactMethod
	public void doSomething(){
		mModule.doSomething();
	}


	@ReactMethod
	public void getValue(Promise promise){
		mModule.getValue(Mandolin.wrap(promise));
	}


	@ReactMethod
	public void setValue(String value, Promise promise){
		mModule.setValue(value, Mandolin.wrap(promise));
	}


	@ReactMethod
	public void setUpdate(Callback callback){
		mModule.setUpdate(Mandolin.wrap(callback));
	}


	@ReactMethod
	public void add(int x, long y, Promise promise){
		mModule.add(x, y, Mandolin.wrap(promise));
	}


	@ReactMethod
	public void testArray(ReadableArray arr){
		mModule.testArray(Mandolin.wrap(arr));
	}


	@ReactMethod
	public void testMap(ReadableMap map){
		mModule.testMap(Mandolin.wrap(map));
	}


	private static final class CppProxy {
		private final long nativeRef;
		private final AtomicBoolean destroyed = new AtomicBoolean(false);

		private CppProxy(long nativeRef){
			if (nativeRef == 0) throw new RuntimeException("nativeRef is zero");
			this.nativeRef = nativeRef;
		}

		private native void nativeDestroy(long nativeRef);
		public void destroy(){
			boolean destroyed = this.destroyed.getAndSet(true);
			if (!destroyed) nativeDestroy(this.nativeRef);
		}

		protected void finalize(){
			destroy();
			super.finalize();
		}


		public void init(){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_init(this.nativeRef);
		}
		private native void native_init(long _nativeRef);


		public void doSomething(){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_doSomething(this.nativeRef);
		}
		private native void native_doSomething(long _nativeRef);


		public void getValue(co.zenturi.mandolin.xnative.Promise promise){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_getValue(this.nativeRef, promise);
		}
		private native void native_getValue(long _nativeRef, co.zenturi.mandolin.xnative.Promise promise);


		public void setValue(String value, co.zenturi.mandolin.xnative.Promise promise){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_setValue(this.nativeRef, value, promise);
		}
		private native void native_setValue(long _nativeRef, String value, co.zenturi.mandolin.xnative.Promise promise);


		public void setUpdate(co.zenturi.mandolin.xnative.Callback callback){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_setUpdate(this.nativeRef, callback);
		}
		private native void native_setUpdate(long _nativeRef, co.zenturi.mandolin.xnative.Callback callback);


		public void add(int x, long y, co.zenturi.mandolin.xnative.Promise promise){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_add(this.nativeRef, x, y, promise);
		}
		private native void native_add(long _nativeRef, int x, long y, co.zenturi.mandolin.xnative.Promise promise);


		public void testArray(co.zenturi.mandolin.xnative.Array arr){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_testArray(this.nativeRef, arr);
		}
		private native void native_testArray(long _nativeRef, co.zenturi.mandolin.xnative.Array arr);


		public void testMap(co.zenturi.mandolin.xnative.Map map){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_testMap(this.nativeRef, map);
		}
		private native void native_testMap(long _nativeRef, co.zenturi.mandolin.xnative.Map map);

	}
}