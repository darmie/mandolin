package co.zenturi.mandolin.xnative;

#if (!macro || java)
@:build(co.zenturi.mandolin.macros.JNI.bind())
@:keep
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
};

namespace std {

template <>
struct hash<JavascriptType> {
    size_t operator()(JavascriptType type) const {
        return ::std::hash<int>()(static_cast<int>(type));
    }
}
} // namespace std
')
@:keep
interface JavascriptType{}
#end