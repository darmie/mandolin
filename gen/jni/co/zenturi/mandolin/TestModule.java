// AUTOGENERATED FILE - DO NOT MODIFY!
// This file is generated by Mandolin - (c) Zenturi.co

package co.zenturi.mandolin.react;

import co.zenturi.mandolin.xnative.react.*;
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
		mModule = create(MandolinReact.createReactBridge(reactContext));
	}

	private static native CppProxy create(co.zenturi.mandolin.xnative.react.ReactBridge bridge);
	public String getName(){

			return "TestModule";
		}

	@ReactMethod
	public void init(int x){
		mModule.init((int)x);
	}


	@ReactMethod
	public void doSomething(){
		mModule.doSomething();
	}


	@ReactMethod
	public void getValue(Promise promise){
		mModule.getValue((JavascriptPromise)MandolinReact.wrap((Promise) promise));
	}


	@ReactMethod
	public void setValue(String value, Promise promise){
		mModule.setValue((String)value, (JavascriptPromise)MandolinReact.wrap((Promise) promise));
	}


	@ReactMethod
	public void setUpdate(Callback callback){
		mModule.setUpdate((JavascriptCallback)MandolinReact.wrap((Callback) callback));
	}


	@ReactMethod
	public void add(int x, long y, Promise promise){
		mModule.add((int)x, (long)y, (JavascriptPromise)MandolinReact.wrap((Promise) promise));
	}


	@ReactMethod
	public void testArray(JavascriptArray arr, Promise promise){
		mModule.testArray((JavascriptArray)arr, (JavascriptPromise)MandolinReact.wrap((Promise) promise));
	}


	@ReactMethod
	public void testMap(JavascriptMap map, Promise promise){
		mModule.testMap((JavascriptMap)map, (JavascriptPromise)MandolinReact.wrap((Promise) promise));
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

		protected void finalize() throws java.lang.Throwable {
			destroy();
			super.finalize();
		}


		public void init(int x){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_init(this.nativeRef, x);
		}
		private native void native_init(long _nativeRef, int x);


		public void doSomething(){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_doSomething(this.nativeRef);
		}
		private native void native_doSomething(long _nativeRef);


		public void getValue(co.zenturi.mandolin.xnative.react.JavascriptPromise promise){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_getValue(this.nativeRef, promise);
		}
		private native void native_getValue(long _nativeRef, co.zenturi.mandolin.xnative.react.JavascriptPromise promise);


		public void setValue(String value, co.zenturi.mandolin.xnative.react.JavascriptPromise promise){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_setValue(this.nativeRef, value, promise);
		}
		private native void native_setValue(long _nativeRef, String value, co.zenturi.mandolin.xnative.react.JavascriptPromise promise);


		public void setUpdate(co.zenturi.mandolin.xnative.react.JavascriptCallback callback){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_setUpdate(this.nativeRef, callback);
		}
		private native void native_setUpdate(long _nativeRef, co.zenturi.mandolin.xnative.react.JavascriptCallback callback);


		public void add(int x, long y, co.zenturi.mandolin.xnative.react.JavascriptPromise promise){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_add(this.nativeRef, x, y, promise);
		}
		private native void native_add(long _nativeRef, int x, long y, co.zenturi.mandolin.xnative.react.JavascriptPromise promise);


		public void testArray(co.zenturi.mandolin.xnative.react.JavascriptArray arr, co.zenturi.mandolin.xnative.react.JavascriptPromise promise){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_testArray(this.nativeRef, arr, promise);
		}
		private native void native_testArray(long _nativeRef, co.zenturi.mandolin.xnative.react.JavascriptArray arr, co.zenturi.mandolin.xnative.react.JavascriptPromise promise);


		public void testMap(co.zenturi.mandolin.xnative.react.JavascriptMap map, co.zenturi.mandolin.xnative.react.JavascriptPromise promise){
			assert !this.destroyed.get() : "trying to use a destroyed object";
			native_testMap(this.nativeRef, map, promise);
		}
		private native void native_testMap(long _nativeRef, co.zenturi.mandolin.xnative.react.JavascriptMap map, co.zenturi.mandolin.xnative.react.JavascriptPromise promise);

	}
}