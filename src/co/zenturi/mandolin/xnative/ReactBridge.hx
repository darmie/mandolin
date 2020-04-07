package co.zenturi.mandolin.xnative;


#if (!macro || java)
#if java
import com.facebook.react.bridge.*;
import com.facebook.react.modules.core.RCTNativeAppEventEmitter;
#end
@:build(co.zenturi.mandolin.macros.JNI.proxy())
@:keep
class ReactBridge {

   var mReactContext #if java :ReactApplicationContext #else :Dynamic #end;

    public function new(context:#if java ReactApplicationContext #else Dynamic #end) {
        mReactContext = context;
    }
   

    public function createMap():MandolinObject<JavascriptMap> {
        return MandolinReact.createMap();
    }

    public function createArray():MandolinObject<JavascriptArray> {
        return MandolinReact.createArray();
    }

    public function copyMap(m:MandolinObject<JavascriptMap>):MandolinObject<JavascriptMap> {
       return MandolinReact.createMap(m);
    }

    public function copyArray(a:MandolinObject<JavascriptArray>):MandolinObject<JavascriptArray> {
        return MandolinReact.createArray(a);
    }

    public function emitEventWithMap(name:String, params:MandolinObject<JavascriptMap>):Void {
        #if java
        mReactContext.getJSModule(untyped __java__('RCTNativeAppEventEmitter.class')).emit(name, MandolinReact.unwrap(params));
        #end
    }

    public function emitEventWithArray(name:String, params:MandolinObject<JavascriptArray>):Void {
        #if java
        mReactContext.getJSModule(untyped __java__('RCTNativeAppEventEmitter.class')).emit(name, MandolinReact.unwrap(params));
        #end
    }

    public function createJobDispatcher(queue:MandolinObject<JobQueue>):MandolinObject<JobDispatcher> {
        return new JobDispatcher(queue);
    }
} 
#end