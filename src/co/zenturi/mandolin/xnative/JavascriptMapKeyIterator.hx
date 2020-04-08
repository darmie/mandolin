package co.zenturi.mandolin.xnative;
#if ((java || !macro ) && !cpp)

#if java
import com.facebook.react.bridge.ReadableMapKeySetIterator;
#end

@:build(co.zenturi.mandolin.macros.JNI.bind())
@:keep
class JavascriptMapKeyIterator {
   
    private var mReadableMapKeySetIterator: #if java ReadableMapKeySetIterator #else Dynamic #end;

    #if java
    public function new(readableMapKeySetIterator:ReadableMapKeySetIterator) {
        mReadableMapKeySetIterator = readableMapKeySetIterator;
    }
    #end

    public function hasNextKey():Bool {
        return mReadableMapKeySetIterator.hasNextKey();
    }

    public function nextKey():String {
        return mReadableMapKeySetIterator.nextKey();
    }
}
#elseif cpp
@:headerCode('
class JavascriptMapKeyIterator {
    public:
        virtual ~JavascriptMapKeyIterator() {}
    
        virtual bool hasNextKey() = 0;
    
        virtual std::string nextKey() = 0;
};
')
@:keep
interface IJavascriptMapKeyIterator {}
@:native('std::shared_ptr<::JavascriptMapKeyIterator>')
extern class JavascriptMapKeyIterator {
    @:native('hasNextKey')
    public function hasNextKey():Bool;

    @:native('nextKey')
    public function nextKey():Void;
}
#end