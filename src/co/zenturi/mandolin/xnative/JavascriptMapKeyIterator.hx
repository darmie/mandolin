package co.zenturi.mandolin.xnative;
#if (!macro || java)

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
@:headerNamespaceCode('
namespace react {
    #include <string>

    class JavascriptMapKeyIterator {
    public:
        virtual ~JavascriptMapKeyIterator() {}
    
        virtual bool hasNextKey() = 0;
    
        virtual std::string nextKey() = 0;
    };   
}
')
@:keep
interface JavascriptMapKeyIterator {
}
#end