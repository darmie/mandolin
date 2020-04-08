package co.zenturi.mandolin.xnative;

#if ((java || !macro ) && !cpp)
#if java
import com.facebook.react.bridge.Promise;
#end
@:build(co.zenturi.mandolin.macros.JNI.proxy())
@:keep
class JavascriptPromise {
    private var mPromise:#if java Promise #else Dynamic #end;

    public function new(promise){
        this.mPromise = promise;
    }

    public function resolveMap(map:MandolinObject<JavascriptMap>):Void{
        mPromise.resolve(MandolinReact.unwrap(map));
    }

    public function resolveArray(arr:MandolinObject<JavascriptArray>):Void{
        mPromise.resolve(MandolinReact.unwrap(arr));
    }

    public function resolveObject(obj:MandolinObject<JavascriptObject>):Void{
        mPromise.resolve(MandolinReact.unwrap(obj));
    }

    public function resolveDouble(v:Float):Void{
        mPromise.resolve(v);
    }

    public function resolveInt(v:Int):Void{
        mPromise.resolve(v);
    }

    public function resolveString(v:String):Void{
        mPromise.resolve(v);
    }

    public function resolveNull():Void{
        mPromise.resolve(null);
    }

    public function resolveBoolean(v:Bool):Void{
        mPromise.resolve(v);
    }

    public function reject(code:String, message:String):Void {
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

    public function resolveNull():Void;

    public function resolveBoolean(value:Bool):Void;

    public function resolveDouble(value:Float):Void;

    public function resolveInt(value:Int):Void;

    public function resolveString(value:String):Void;

    public function resolveArray(value:JavascriptArray):Void;

    public function resolveMap(value:JavascriptMap):Void;

    public function resolveObject(value:JavascriptObject):Void;

    public function reject(code:String, message:String):Void;
}
#end