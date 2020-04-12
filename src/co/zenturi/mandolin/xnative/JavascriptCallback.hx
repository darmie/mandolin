package co.zenturi.mandolin.xnative;

#if java 
import com.facebook.react.bridge.Callback;
import java.util.ArrayList;
import java.util.Arrays;

import co.zenturi.mandolin.xnative.JavascriptObject.IJavascriptObject;

@:native('co.zenturi.mandolin.xnative.react.JavascriptCallback')
extern class IJavascriptCallback {
    @:native('invoke')
    public function invoke(args: java.NativeArray<IJavascriptObject>):Void;

    @:native('invokeSingleArg')
    public function invokeSingleArg(o:IJavascriptObject):Void;

}

@:build(co.zenturi.mandolin.macros.JNI.bind())
@:build(co.zenturi.mandolin.macros.JNI.proxy())
@dep("com.facebook.react.bridge.*")
@:keep
@:nativeGen
class JavascriptCallback extends IJavascriptCallback {
    private var mCallback: Callback;


    public function new(callback:Callback) {
        mCallback = callback;
    }

    override public function invoke(args: java.NativeArray<IJavascriptObject>):Void {
        var javaArgs:java.util.List<IJavascriptObject> = new java.util.ArrayList<IJavascriptObject>();
        var i = 0;
        for(o in args){
            javaArgs.add(MandolinReact.unwrap(o));
            i++;
        }

        mCallback.invoke(javaArgs.toArray());
    }

    override public function invokeSingleArg(o:IJavascriptObject):Void {
        var args:java.NativeArray<IJavascriptObject> = java.NativeArray.make(o);

        invoke(args);
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
@:nativeGen
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