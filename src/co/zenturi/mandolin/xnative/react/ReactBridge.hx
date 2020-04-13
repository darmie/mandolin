package co.zenturi.mandolin.xnative.react;


#if java  

import com.facebook.react.bridge.*;
import com.facebook.react.modules.core.RCTNativeAppEventEmitter;
// import com.facebook.react.modules.core.DeviceEventManagerModule.RCTDeviceEventEmitter;
import co.zenturi.mandolin.xnative.react.JavascriptMap.IJavascriptMap;
import co.zenturi.mandolin.xnative.react.JavascriptArray.IJavascriptArray;
import co.zenturi.mandolin.xnative.react.JobQueue;
import co.zenturi.mandolin.xnative.react.JobDispatcher.IJobDispatcher;

@:native('co.zenturi.mandolin.xnative.react.ReactBridge')
extern class IReactBridge {
    @:native('createMap')
    public function createMap():IJavascriptMap;
    @:native('createArray')
    public function createArray():IJavascriptArray;
    @:native('copyMap')
    public function copyMap(m:IJavascriptMap):IJavascriptMap;
    @:native('copyArray')
    public function copyArray(a:IJavascriptArray):IJavascriptArray;
    @:native('emitEventWithMap')
    public function emitEventWithMap(name:String, params:IJavascriptMap):Void;
    @:native('emitEventWithArray')
    public function emitEventWithArray(name:String, params:IJavascriptArray):Void;
    @:native('createJobDispatcher')
    public function createJobDispatcher(queue:JobQueue):IJobDispatcher;
}

@:build(co.zenturi.mandolin.macros.JNI.bind())
@:build(co.zenturi.mandolin.macros.JNI.proxy())
@dep("com.facebook.react.bridge.*")
@:keep
@:nativeGen
@:native('co.zenturi.mandolin.xnative.ReactBridge')
class ReactBridge extends IReactBridge {

   var mReactContext :ReactApplicationContext;

    public function new(context:ReactApplicationContext ) {
        mReactContext = context;
    }
   

    override public function createMap():IJavascriptMap {
        return MandolinReact.createMap();
    }

    override public function createArray():IJavascriptArray {
        return MandolinReact.createArray();
    }

    override public function copyMap(m:IJavascriptMap):IJavascriptMap {
       return MandolinReact.createMap(cast m);
    }

    override public function copyArray(a:IJavascriptArray):IJavascriptArray {
        return MandolinReact.createArray(cast a);
    }

    override public function emitEventWithMap(name:String, params:IJavascriptMap):Void {
  
        var args:JavascriptMap = cast params;
        var emitter:RCTNativeAppEventEmitter = mReactContext.getJSModule(java.lang.Class.forName('RCTNativeAppEventEmitter'));
        emitter.emit(name, args.getWritableMap());
    }

    override public function emitEventWithArray(name:String, params:IJavascriptArray):Void {

        var args:JavascriptArray = cast params;
        var emitter:RCTNativeAppEventEmitter = mReactContext.getJSModule(java.lang.Class.forName('RCTNativeAppEventEmitter'));
        emitter.emit(name, args.getWritableArray());
    }

    override public function createJobDispatcher(queue:JobQueue):IJobDispatcher {
        return new JobDispatcher(queue);
    }
} 
#elseif cpp
@:headerCode('
#include <memory>
#include <string>

class JavascriptArray;
class JavascriptMap;
class JobDispatcher;
class JobQueue;

class ReactBridge {
public:
    virtual ~ReactBridge() {}

    virtual std::shared_ptr<JavascriptMap> createMap() = 0;

    virtual std::shared_ptr<JavascriptArray> createArray() = 0;

    virtual std::shared_ptr<JavascriptMap> copyMap(const std::shared_ptr<JavascriptMap> & map) = 0;

    virtual std::shared_ptr<JavascriptArray> copyArray(const std::shared_ptr<JavascriptArray> & array) = 0;

    virtual void emitEventWithMap(const std::string & name, const std::shared_ptr<JavascriptMap> & params) = 0;

    virtual void emitEventWithArray(const std::string & name, const std::shared_ptr<JavascriptArray> & params) = 0;

    virtual std::shared_ptr<JobDispatcher> createJobDispatcher(const std::shared_ptr<JobQueue> & queue) = 0;
};
')
@:keep
@:nativeGen
interface IReactBridge{}
@:include('co/zenturi/mandolin/xnative/react/IReactBridge.h')
@:include('co/zenturi/mandolin/xnative/react/IJavascriptArray.h')
@:include('co/zenturi/mandolin/xnative/react/IJavascriptMap.h')
@:include('co/zenturi/mandolin/xnative/react/IJobQueue.h')
@:native('std::shared_ptr<::ReactBridge>')
extern class ReactBridge {
    public static inline function init():ReactBridge {
        return untyped __cpp__('std::make_shared<::ReactBridge>()');
    }
    @:native('createMap')
    public function createMap():JavascriptMap;
    @:native('createArray')
    public function createArray():JavascriptArray;
    @:native('copyMap')
    public function copyMap(m:JavascriptMap):JavascriptMap;
    @:native('copyArray')
    public function copyArray(a:JavascriptArray):JavascriptArray;
    @:native('emitEventWithMap')
    public function emitEventWithMap(name:String, params:JavascriptMap):Void;
    @:native('emitEventWithArray')
    public function emitEventWithArray(name:String, params:JavascriptArray):Void;
    @:native('createJobDispatcher')
    public function createJobDispatcher(queue:JobQueue):Void;
}
#end