package co.zenturi.mandolin.xnative;

#if ((java || !macro ) && !cpp)
#if java
import com.facebook.react.bridge.Callback;

import java.util.ArrayList;
import java.util.Arrays;
#end

@:build(co.zenturi.mandolin.macros.JNI.proxy())
@:keep
class JavascriptCallback {
    private var mCallback: #if java Callback #else Dynamic #end;
    public function new(callback:#if java Callback #else Dynamic #end) {
        mCallback = callback;
    }

    public function invoke(args: #if java ArrayList<JavascriptObject> #else Array<JavascriptObject> #end):Void {
        #if java
        var javaArgs = new ArrayList<JavascriptObject>(args.length);
        var i = 0;
        for(o in args){
            javaArgs[i] = MandolinReact.unwrap(o);
            i++;
        }

        mCallback.invoke(javaArgs);
        #end
    }

    public function invokeSingleArg(o:MandolinObject<JavascriptObject>):Void {
        #if java
        var args:ArrayList<JavascriptObject> = new ArrayList<JavascriptObject>();
        args.add(0, o);
        invoke(args);
        #end
    }
}
#elseif cpp
@:headerCode('
#include <memory>
#include <vector>

class JavascriptObject;

class JavascriptCallback {
public:
    virtual ~JavascriptCallback() {}

    virtual void invoke(const std::vector<std::shared_ptr<JavascriptObject>> & args) = 0;

    virtual void invokeSingleArg(const std::shared_ptr<JavascriptObject> & arg) = 0;
};
')
@:keep
interface IJavascriptCallback {

}
@:include('co/zenturi/mandolin/xnative/IJavascriptCallback.h')
@:include('co/zenturi/mandolin/xnative/IJavascriptObject.h')
@:native('std::shared_ptr<::JavascriptCallback>')
extern class JavascriptCallback {
    public static inline function init():JavascriptCallback{
        return untyped __cpp__('std::make_shared<::JavascriptCallback>()');
    }

    @:native('invoke')
    public function invoke(args: Array<JavascriptObject>):Void;

    @:native('invokeSingleArg')
    public function invokeSingleArg(o:JavascriptObject):Void;

}
#end