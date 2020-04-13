package co.zenturi.mandolin.xnative.react;

#if java

import com.facebook.react.bridge.ReadableMapKeySetIterator;

@:native('co.zenturi.mandolin.xnative.react.JavascriptMapKeyIterator')
extern class IJavascriptMapKeyIterator {
    @:native('hasNextKey')
    public function hasNextKey():Bool;

    @:native('nextKey')
    public function nextKey():String;
}

@:build(co.zenturi.mandolin.macros.JNI.bind())
@:build(co.zenturi.mandolin.macros.JNI.proxy())
@dep("com.facebook.react.bridge.ReadableMapKeySetIterator")
@:keep
@:nativeGen
@:native('co.zenturi.mandolin.xnative.JavascriptMapKeyIterator')
class JavascriptMapKeyIterator extends IJavascriptMapKeyIterator {
   
    private var mReadableMapKeySetIterator: ReadableMapKeySetIterator;


    public function new(readableMapKeySetIterator:ReadableMapKeySetIterator) {
        mReadableMapKeySetIterator = readableMapKeySetIterator;
    }


    override public function hasNextKey():Bool {
        return mReadableMapKeySetIterator.hasNextKey();
    }

    override public function nextKey():String {
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
@:nativeGen
interface IJavascriptMapKeyIterator {}
@:native('std::shared_ptr<::JavascriptMapKeyIterator>')
extern class JavascriptMapKeyIterator {
    @:native('hasNextKey')
    public function hasNextKey():Bool;

    @:native('nextKey')
    public function nextKey():String;
}
#end