package co.zenturi.mandolin.xnative;

#if java
import com.facebook.react.bridge.Promise;

@:build(co.zenturi.mandolin.macros.JNI.forward())
@:keep
class JavascriptPromise {
    private var mPromise:Promise;

    public function new(promise){
        this.mPromise = promise;
    }

    public function resolveMap(map:JavascriptMap){
        mPromise.resolve(ReactBridge.unwrap(map));
    }

    public function resolveArray(arr:JavascriptMap){
        mPromise.resolve(ReactBridge.unwrap(arr));
    }

    public function resolveObject(obj:JavascriptObject){
        mPromise.resolve(ReactBridge.unwrap(obj));
    }

    public function resolveDouble(v:Float){
        mPromise.resolve(v);
    }

    public function resolveInt(v:Int){
        mPromise.resolve(v);
    }

    public function resolveString(v:String){
        mPromise.resolve(v);
    }

    public function resolveNull(){
        mPromise.resolve(null);
    }

    public function resolveBoolean(v:Bool){
        mPromise.resolve(v);
    }

    public function reject(code:String, message:String) {
        mPromise.reject(code, message);
    }
}

#elseif cpp 
@:headerCode('
#include <cstdint>
#include <memory>
#include <string>
')
@:headerNamespaceCode('
namespace react{
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
}
')
@:keep
interface JavascriptPromise{}
#end
