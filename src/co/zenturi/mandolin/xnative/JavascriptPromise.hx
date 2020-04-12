package co.zenturi.mandolin.xnative;

#if java 
import com.facebook.react.bridge.Promise;

import co.zenturi.mandolin.xnative.JavascriptMap.IJavascriptMap;
import co.zenturi.mandolin.xnative.JavascriptArray.IJavascriptArray;
import co.zenturi.mandolin.xnative.JavascriptObject.IJavascriptObject;

@:native('co.zenturi.mandolin.xnative.react.JavascriptPromise')
extern class IJavascriptPromise {

    @:native('resolveNull')
    public function resolveNull():Void;
    @:native('resolveBoolean')
    public function resolveBoolean(value:Bool):Void;
    @:native('resolveDouble')
    public function resolveDouble(value:Float):Void;
    @:native('resolveInt')
    public function resolveInt(value:Int):Void;
    @:native('resolveString')
    public function resolveString(value:String):Void;
    @:native('resolveArray')
    public function resolveArray(value:IJavascriptArray):Void;
    @:native('resolveMap')
    public function resolveMap(value:IJavascriptMap):Void;
    @:native('resolveObject')
    public function resolveObject(value:IJavascriptObject):Void;
    @:native('reject')
    public function reject(code:String, message:String):Void;
}

@:build(co.zenturi.mandolin.macros.JNI.bind())
@:build(co.zenturi.mandolin.macros.JNI.proxy())
@:keep
@:nativeGen
class JavascriptPromise extends IJavascriptPromise {
    private var mPromise:Promise;

    public function new(promise:Promise){
        this.mPromise = promise;
    }

    override public function resolveMap(map:IJavascriptMap):Void{
        mPromise.resolve(MandolinReact.unwrap(map));
    }

    override public function resolveArray(arr:IJavascriptArray):Void{
        mPromise.resolve(MandolinReact.unwrap(arr));
    }

    override public function resolveObject(obj:IJavascriptObject):Void{
        mPromise.resolve(MandolinReact.unwrap(obj));
    }

    override  public function resolveDouble(v:Float):Void{
        mPromise.resolve(v);
    }

    override public function resolveInt(v:Int):Void{
        mPromise.resolve(v);
    }

    override public function resolveString(v:String):Void{
        mPromise.resolve(v);
    }

    override public function resolveNull():Void{
        mPromise.resolve(null);
    }

    override public function resolveBoolean(v:Bool):Void{
        mPromise.resolve(v);
    }

    override public function reject(code:String, message:String):Void {
        mPromise.reject(code, message);
    }
}
#elseif cpp
@:headerCode('
#include <cstdint>
#include <memory>
// #include <string>

class JavascriptArray;
class JavascriptMap;
class JavascriptObject;

class JavascriptPromise {
public:
    virtual ~JavascriptPromise() {}

    virtual void resolveNull() = 0;

    virtual void resolveBoolean(bool value) = 0;

    virtual void resolveDouble(double value) = 0;

    virtual void resolveInt(int32_t value) = 0;

    virtual void resolveString(const std::string & value) = 0;

    virtual void resolveArray(const std::shared_ptr<JavascriptArray> & value) = 0;

    virtual void resolveMap(const std::shared_ptr<JavascriptMap> & value) = 0;

    virtual void resolveObject(const std::shared_ptr<JavascriptObject> & value) = 0;

    virtual void reject(const std::string & code, const std::string & message) = 0;
};
')
@:keep
@:nativeGen
interface IJavascriptPromise {}
@:include('co/zenturi/mandolin/xnative/IJavascriptPromise.h')
@:include('co/zenturi/mandolin/xnative/IJavascriptArray.h')
@:include('co/zenturi/mandolin/xnative/IJavascriptMap.h')
@:include('co/zenturi/mandolin/xnative/IJavascriptObject.h')
@:native('std::shared_ptr<::JavascriptPromise>')
extern class JavascriptPromise {

    public static inline function init():JavascriptPromise{
        return untyped __cpp__('std::make_shared<::JavascriptPromise>()');
    };

    @:native('resolveNull')
    public function resolveNull():Void;

    @:native('resolveBoolean')
    public function resolveBoolean(value:Bool):Void;

    @:native('resolveDouble')
    public function resolveDouble(value:Float):Void;

    @:native('resolveInt')
    public function resolveInt(value:Int):Void;

    @:native('resolveString')
    public function resolveString(value:String):Void;

    @:native('resolveArray')
    public function resolveArray(value:JavascriptArray):Void;

    @:native('resolveMap')
    public function resolveMap(value:JavascriptMap):Void;

    @:native('resolveObject')
    public function resolveObject(value:JavascriptObject):Void;

    @:native('reject')
    public function reject(code:String, message:String):Void;
}
#end