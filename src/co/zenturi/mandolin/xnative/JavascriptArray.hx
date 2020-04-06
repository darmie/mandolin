package co.zenturi.mandolin.xnative;

#if (java || !macro)
#if java
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.WritableArray;
#end
@:build(co.zenturi.mandolin.macros.JNI.bind())
@:keep
class JavascriptArray {
   
    private var mReadableArray: #if java ReadableArray #else Dynamic #end;
    private var mWritableArray: #if java WritableArray #else Dynamic #end;

    #if java
    public function new(?arr:ReadableArray) {
        mWritableArray = arr != null ? arr : Arguments.createArray();
        mReadableArray = arr != null ? null : mWritableArray;
    }
    #else 
    public function new() {

    }
    #end

    public function size():Int {
        return mReadableArray.size();
    }

    public function isNull(index:Int):Bool {
        return mReadableArray.isNull(index);
    }

    public function getBoolean(index:Int):Bool {
        return mReadableArray.getBoolean(index);
    }

    public function getDouble(index:Int):Float {
        return mReadableArray.getDouble(index);
    }

    public function getInt(index:Int):Int {
        return mReadableArray.getInt(index);
    }

    public function getArray(index:Int):MandolinObject<JavascriptArray> {
        return MandolinReact.wrap(mReadableArray.getArray(index));
    }

    public function getMap(index:Int):MandolinObject<JavascriptMap> {
        return MandolinReact.wrap(mReadableArray.getMap(index));
    }

    public function getObject(index:Int):JavascriptObject {
        return MandolinReact.wrap(mReadableArray.getDynamic(index));
    }

    public function getType(index:Int):MandolinObject<JavascriptType> {
        return MandolinReact.wrap(mReadableArray.getType(index));
    }


    public function pushNull() {
        mWritableArray.pushNull();
    }

    
    public function pushBoolean(value:Bool ) {
        mWritableArray.pushBoolean(value);
    }

    
    public function pushDouble(value:Float ) {
        mWritableArray.pushDouble(value);
    }

    
    public function pushInt(value:Int) {
        mWritableArray.pushInt(value);
    }

    
    public function pushString(value:String) {
        mWritableArray.pushString(value);
    }

    
    public function pushArray(array:MandolinObject<JavascriptArray>) {
        mWritableArray.pushArray(MandolinReact.unwrap(array));
    }

    
    public function pushMap( map:MandolinObject<JavascriptMap>) {
        mWritableArray.pushMap(MandolinReact.unwrap(map));
    }

    
    public function pushObject(value:MandolinObject<JavascriptObject> ) {
        var type:JavascriptType = value.get().getType();
        var _value:JavascriptObject = value;
        switch (type) {
            case JavascriptType.ARRAY:
                mWritableArray.pushArray(MandolinReact.unwrap(_value.asArray()));
            case JavascriptType.BOOLEAN:
                mWritableArray.pushBoolean(_value.asBoolean());
            case JavascriptType.MAP:
                mWritableArray.pushMap(MandolinReact.unwrap(_value.asMap()));
            case JavascriptType.NUMBER:
                mWritableArray.pushDouble(_value.asDouble());
            case JavascriptType.STRING:
                mWritableArray.pushString(_value.asString());
            default: mWritableArray.pushNull();
            case JavascriptType.NIL:
                mWritableArray.pushNull();
        }
    }

    
    public function append(source:MandolinObject<JavascriptArray> ) {
        var _source:JavascriptArray = source;
        if (mWritableArray != null) {
            MandolinReact.copyReactArray(_source.getReadableArray(), mWritableArray);
        }
    }

    public function getReadableArray(): #if  java ReadableArray #else Dynamic #end {
        return mReadableArray;
    }

    public function getWritableArray():#if  java ReadableArray #else Dynamic #end {
        return mWritableArray;
    }

}
#elseif cpp 
@:headerCode("
#include <co/zenturi/mandolin/xnative/JavascriptMap.h>
#include <co/zenturi/mandolin/xnative/JavascriptObject.h>
#include <co/zenturi/mandolin/xnative/JavascriptType.h>
")
@:headerNamespaceCode('
namespace react {
    class JavascriptArray {
        public:
            ~JavascriptArray(){};
            virtual int32_t size() = 0;
            virtual bool isNull() = 0;
            virtual double getDouble(const int32_t index) = 0;
            virtual int32_t getInt(const int32_t index) = 0;
            virtual std::shared_ptr<JavascriptArray> getArray(const int32_t index) = 0;
            virtual std::shared_ptr<JavascriptMap> getMap(const int32_t index) = 0;
            virtual std::shared_ptr<JavascriptObject> getObject(const int32_t index) = 0;
            virtual ::co::zenturi::mandolin::xnative::JavascriptType getType(const int32_t index) = 0;

            virtual void pushNull() = 0;
            virtual void pushBoolean(bool value) = 0;
            virtual void pushDouble(double value) = 0;
            virtual void pushInt(int32_t value) = 0;
            virtual void pushString(std::string value) = 0;
            virtual void pushArray(const std::shared_ptr<JavascriptArray> & value) = 0;
            virtual void pushMap(const std::shared_ptr<JavascriptMap> & value) = 0;
    };
}
')
@:keep
interface JavascriptArray {
   
}
#end