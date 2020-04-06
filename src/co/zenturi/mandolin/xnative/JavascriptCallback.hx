package co.zenturi.mandolin.xnative;


#if (!macro || java)
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
@:headerNamespaceCode('
namespace react {
#include <memory>
#include <vector>

class JavascriptObject;

class JavascriptCallback {
public:
    virtual ~JavascriptCallback() {}

    virtual void invoke(const std::vector<std::shared_ptr<JavascriptObject>> & args) = 0;

    virtual void invokeSingleArg(const std::shared_ptr<JavascriptObject> & arg) = 0;
};
}
')
@:keep
interface JavascriptCallback {}
#end