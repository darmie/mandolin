package co.zenturi.mandolin.xnative;

#if java 
@:keep
@:nativeGen
enum JavascriptType {
    NIL;
    BOOLEAN;
    NUMBER;
    STRING;
    ARRAY;
    MAP;
}
#elseif cpp 
@:headerCode('
#include <functional>

enum class JavascriptType : int {
    NIL,
    BOOLEAN,
    NUMBER,
    STRING,
    ARRAY,
    MAP,
    HAXE
};


namespace std {

template <>
struct hash<::JavascriptType> {
    size_t operator()(::JavascriptType type) const {
        return ::std::hash<int>()(static_cast<int>(type));
    }
};
} // namespace std
')
@:keep
@:nativeGen
interface IJavascriptType{}
@:include('co/zenturi/mandolin/xnative/IJavascriptType.h')
@:native('::JavascriptType')
extern enum abstract JavascriptType(Int) from Int to Int {
    @:native('::JavascriptType:NIL')
    public static var NIL:JavascriptType;
    @:native('::JavascriptType:BOOLEAN')
    public static var BOOLEAN:JavascriptType;
    @:native('::JavascriptType:NUMBER')
    public static var NUMBER:JavascriptType;
    @:native('::JavascriptType:STRING')
    public static var STRING:JavascriptType;
    @:native('::JavascriptType:ARRAY')
    public static var ARRAY:JavascriptType;
    @:native('::JavascriptType:MAP')
    public static var MAP:JavascriptType;
}
#end