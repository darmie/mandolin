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
@:headerCode("#include <functional>")
@:headerNamespaceCode('
namespace react {
enum class JavascriptType : int {
    NIL,
    BOOLEAN,
    NUMBER,
    STRING,
    ARRAY,
    MAP,
};

// namespace std {

// template <>
// struct ::std::hash<::co::zenturi::mandolin::xnative::react::JavascriptType> {
//     size_t operator()(::co::zenturi::mandolin::xnative::react::JavascriptType type) const {
//         return ::std::hash<int>()(static_cast<int>(type));
//     }
// };
}
')
@:keep
class JavascriptType{}
// enum JavascriptType {
//     NIL;
//     BOOLEAN;
//     NUMBER;
//     STRING;
//     ARRAY;
//     MAP;
// }
#end