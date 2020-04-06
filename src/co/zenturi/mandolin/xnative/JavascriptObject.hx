package co.zenturi.mandolin.xnative;

#if (!macro || java)
@:build(co.zenturi.mandolin.macros.JNI.bind())
@:keep
#if java
interface JavascriptObject {
    public  function getType():JavascriptType;
    public  function isNull():Bool;
    public  function asBoolean():Bool;
    public  function asDouble():Float;

    public  function asInt():Int;

    public  function asString():String;

    public  function asArray():JavascriptArray;
    public  function asMap():JavascriptMap;

    @native @static public function fromNull():JavascriptObject;
    @native @static public function fromBoolean(value:Bool):JavascriptObject;
    @native @static public function fromDouble(value:Float):JavascriptObject;

    @native @static public function fromInt(value:Int):JavascriptObject;
    @native @static public function fromString(value:String):JavascriptObject;
    @native @static public function fromArray(value:JavascriptArray):JavascriptObject;
    @native @static public function fromMap(value:JavascriptMap):JavascriptObject;

}
#else 
class JavascriptObject {
    public  function getType():MandolinObject<JavascriptType> {
        return null;
    }
    public  function isNull():Bool {
        return false;
    }
    public  function asBoolean():Bool { return false;}
    public  function asDouble():Float { return 0;}

    public  function asInt():Int { return 0;}

    public  function asString():String { return null;}

    public  function asArray():MandolinObject<JavascriptArray> { return null;}
    public  function asMap():MandolinObject<JavascriptMap> {return null;}

    @native @static public static function fromNull():MandolinObject<JavascriptObject> {return null;}
    @native @static public static function fromBoolean(value:Bool):MandolinObject<JavascriptObject> {return null;}
    @native @static public static function fromDouble(value:Float):MandolinObject<JavascriptObject> {return null;}

    @native @static public static function fromInt(value:Int):MandolinObject<JavascriptObject> {return null;}
    @native @static public static function fromString(value:String):MandolinObject<JavascriptObject> {return null;}
    @native @static public static function fromArray(value:MandolinObject<JavascriptArray>):MandolinObject<JavascriptObject> {return null;}
    @native @static public static function fromMap(value:MandolinObject<JavascriptMap>):MandolinObject<JavascriptObject> {return null;}

}
#end
#elseif cpp 
import haxe.io.FPHelper;
@:headerCode("
#include <co/zenturi/mandolin/xnative/JavascriptArray.h>
#include <co/zenturi/mandolin/xnative/JavascriptType.h>
#include <co/zenturi/mandolin/xnative/JavascriptMap.h>
#include <cstdint>
#include <memory>
#include <string>
")
@:headerNamespaceCode('
namespace react {

class JavascriptArray;
class JavascriptMap;
// enum class JavascriptType;

class JavascriptObject {
public:
    virtual ~JavascriptObject() {}

    virtual ::co::zenturi::mandolin::xnative::react::JavascriptType getType() = 0;

    virtual bool isNull() = 0;

    static std::shared_ptr<JavascriptObject> fromNull();

    virtual bool asBoolean() = 0;

    static std::shared_ptr<JavascriptObject> fromBoolean(bool value);

    virtual double asDouble() = 0;

    static std::shared_ptr<JavascriptObject> fromDouble(double value);

    virtual int32_t asInt() = 0;

    static std::shared_ptr<JavascriptObject> fromInt(int32_t value);

    virtual std::string asString() = 0;

    static std::shared_ptr<JavascriptObject> fromString(const std::string & value);

    virtual std::shared_ptr<JavascriptArray> asArray() = 0;

    static std::shared_ptr<JavascriptObject> fromArray(const std::shared_ptr<JavascriptArray> & value);

    virtual std::shared_ptr<JavascriptMap> asMap() = 0;

    static std::shared_ptr<JavascriptObject> fromMap(const std::shared_ptr<JavascriptMap> & value);
};

class JavascriptObjectImpl : public ::co::zenturi::mandolin::xnative::react::JavascriptObject {
    public:
        JavascriptObjectImpl(const JavascriptObjectImpl& other) : mType(other.mType){
            switch (mType) {
                case ::co::zenturi::mandolin::xnative::react::JavascriptType::ARRAY:
                    new (&mUnion.mArray) std::shared_ptr<JavascriptArray>(other.mUnion.mArray);
                    break;
                case ::co::zenturi::mandolin::xnative::react::JavascriptType::MAP:
                    new (&mUnion.mMap) std::shared_ptr<JavascriptMap>(other.mUnion.mMap);
                    break;
                case ::co::zenturi::mandolin::xnative::react::JavascriptType::BOOLEAN:
                    mUnion.mBool = other.mUnion.mBool;
                    break;
                case ::co::zenturi::mandolin::xnative::react::JavascriptType::NUMBER:
                    mUnion.mDouble = other.mUnion.mDouble;
                    break;
                case ::co::zenturi::mandolin::xnative::react::JavascriptType::STRING:
                    new (&mUnion.mString) std::string(other.mUnion.mString);
                    break;
                case ::co::zenturi::mandolin::xnative::react::JavascriptType::NIL:
                default:
                    break;
            }
        }
    
        JavascriptObjectImpl(std::nullptr_t): mType(::co::zenturi::mandolin::xnative::react::JavascriptType::NIL) {};
        JavascriptObjectImpl(bool value) :  mType(::co::zenturi::mandolin::xnative::react::JavascriptType::BOOLEAN) {
            mUnion.mBool = value;
        };
        JavascriptObjectImpl(double value) : mType(::co::zenturi::mandolin::xnative::react::JavascriptType::NUMBER) {
            mUnion.mDouble = value;
        }
        
        JavascriptObjectImpl(int32_t value): mType(::co::zenturi::mandolin::xnative::react::JavascriptType::NUMBER) {
            mUnion.mDouble = value;
        }
        JavascriptObjectImpl(const std::string& value) : mType(::co::zenturi::mandolin::xnative::react::JavascriptType::STRING) {
            new (&mUnion.mString) std::string(value);
        }
        JavascriptObjectImpl(const std::shared_ptr<JavascriptArray>& value) : mType(::co::zenturi::mandolin::xnative::react::JavascriptType::ARRAY) {
            new (&mUnion.mArray) std::shared_ptr<JavascriptArray>(value);
        }
        JavascriptObjectImpl(const std::shared_ptr<JavascriptMap>& value): mType(::co::zenturi::mandolin::xnative::react::JavascriptType::MAP) {
            new (&mUnion.mMap) std::shared_ptr<JavascriptMap>(value);
        }
        
    
        ~JavascriptObjectImpl() {
            switch (mType) {
                case ::co::zenturi::mandolin::xnative::react::JavascriptType::ARRAY:
                    mUnion.mArray.reset();
                    break;
                case ::co::zenturi::mandolin::xnative::react::JavascriptType::MAP:
                    mUnion.mMap.reset();
                    break;
                case ::co::zenturi::mandolin::xnative::react::JavascriptType::STRING:
                    mUnion.mString.~basic_string();
                    break;
                default:
                    break;
            }
        }
    
        ::co::zenturi::mandolin::xnative::react::JavascriptType getType() override {
            return mType;
        }
    
        bool isNull() override {
            return mType == ::co::zenturi::mandolin::xnative::react::JavascriptType::NIL;
        }
    
        bool asBoolean() override {
            if (mType == ::co::zenturi::mandolin::xnative::react::JavascriptType::BOOLEAN) {
                return mUnion.mBool;
            }
            return false;
        }
    
        double asDouble() override {
            if (mType == ::co::zenturi::mandolin::xnative::react::JavascriptType::NUMBER) {
                return mUnion.mDouble;
            }
            return 0;
        }
    
        int32_t asInt() override {
            if (mType == ::co::zenturi::mandolin::xnative::react::JavascriptType::NUMBER) {
                return (int32_t) mUnion.mDouble;
            }
            return 0;
        }
    
        std::string asString() override {
            if (mType == ::co::zenturi::mandolin::xnative::react::JavascriptType::STRING) {
                return mUnion.mString;
            }
            return nullptr;
        }
    
        std::shared_ptr<JavascriptArray> asArray() override {
            if (mType == ::co::zenturi::mandolin::xnative::react::JavascriptType::ARRAY) {
                return mUnion.mArray;
            }
            return nullptr;
        }
    
        std::shared_ptr<JavascriptMap> asMap() override {
            if (mType == ::co::zenturi::mandolin::xnative::react::JavascriptType::MAP) {
                return mUnion.mMap;
            }
            return nullptr;
        }
    
    private:
        union U {
            U() {}
            ~U() {}
            bool mBool;
            double mDouble;
            std::string mString;
            std::shared_ptr<JavascriptArray> mArray;
            std::shared_ptr<JavascriptMap> mMap;
        } mUnion;
        ::co::zenturi::mandolin::xnative::react::JavascriptType mType;
    };
}
')
@:keep
interface JavascriptObject {
}
#end