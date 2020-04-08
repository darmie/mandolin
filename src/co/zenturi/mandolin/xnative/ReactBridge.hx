package co.zenturi.mandolin.xnative;


#if ((java || !macro ) && !cpp)
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
interface IReactBridge{}
@:include('co/zenturi/mandolin/xnative/IReactBridge.h')
@:include('co/zenturi/mandolin/xnative/IJavascriptArray.h')
@:include('co/zenturi/mandolin/xnative/IJavascriptMap.h')
@:include('co/zenturi/mandolin/xnative/IJobQueue.h')
@:native('std::shared_ptr<::ReactBridge>')
extern class ReactBridge {
    public static inline function init():ReactBridge {
        return untyped __cpp__('std::make_shared<::ReactBridge>()');
    }
    @:native('createMap')
    public function createMap():JavascriptMap;
    @:native('createArray')
    public function createArray():JavascriptMap;
    @:native('copyMap')
    public function copyMap(m:JavascriptMap):Void;
    @:native('copyArray')
    public function copyArray(a:JavascriptArray):Void;
    @:native('emitEventWithMap')
    public function emitEventWithMap(name:String, params:JavascriptMap):Void;
    @:native('emitEventWithArray')
    public function emitEventWithArray(name:String, params:JavascriptArray):Void;
    @:native('createJobDispatcher')
    public function createJobDispatcher(queue:JobQueue):Void;
}
#end