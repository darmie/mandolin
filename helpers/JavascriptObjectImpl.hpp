#include <cstdint>
#include <memory>
#include <string>
#include <co/zenturi/mandolin/xnative/IJavascriptType.h>
#include <co/zenturi/mandolin/xnative/IJavascriptObject.h>
#include <co/zenturi/mandolin/xnative/IJavascriptMap.h>
#include <co/zenturi/mandolin/xnative/IJavascriptMapKeyIterator.h>
#include <co/zenturi/mandolin/xnative/IJavascriptArray.h>
#include <co/zenturi/mandolin/xnative/IReactBridge.h>
#include <co/zenturi/mandolin/xnative/IJobQueue.h>
#include <co/zenturi/mandolin/xnative/IJobDispatcher.h>

class ReactBridge;
class JavascriptArray;
class JavascriptMap;
class JobQueueImpl;
class JobDispatcher;

enum class JavascriptType;

class JavascriptObjectImpl : public ::JavascriptObject {
public:
     JavascriptObjectImpl();
     JavascriptObjectImpl(const JavascriptObjectImpl &other);
     JavascriptObjectImpl(std::nullptr_t);
     JavascriptObjectImpl(bool value);
     JavascriptObjectImpl(double value);
     JavascriptObjectImpl(int32_t value);
     JavascriptObjectImpl(int64_t value);
     JavascriptObjectImpl(const std::string &value);
     JavascriptObjectImpl(const std::shared_ptr<JavascriptArray> &value);
     JavascriptObjectImpl(const std::shared_ptr<JavascriptMap> &value);
     JavascriptObjectImpl(::Dynamic value);
    ~JavascriptObjectImpl();

    JavascriptType getType();

    bool isNull();

    static std::shared_ptr<JavascriptObject> fromNull();

    bool asBoolean();

    static std::shared_ptr<JavascriptObject> fromBoolean(bool value);

    double asDouble();

    static std::shared_ptr<JavascriptObject> fromDouble(double value);

    int32_t asInt();

    static std::shared_ptr<JavascriptObject> fromInt(int32_t value);

    std::string asString();

    static std::shared_ptr<JavascriptObject> fromString(const std::string & value);

    std::shared_ptr<JavascriptArray> asArray();

    static std::shared_ptr<JavascriptObject> fromArray(const std::shared_ptr<JavascriptArray> & value);

    std::shared_ptr<JavascriptMap> asMap();

    ::Dynamic asHaxeObject();

    static std::shared_ptr<JavascriptObject> fromMap(const std::shared_ptr<JavascriptMap> & value);
    static std::shared_ptr<JavascriptObject> fromHaxe(::Dynamic value);

private:
    union U {
        U(){}
        ~U(){}
        bool mBool;
        double mDouble;
        std::string mString;
        std::shared_ptr<::JavascriptArray> mArray;
        std::shared_ptr<::JavascriptMap> mMap;
        ::Dynamic haxeDynamic;
    } mUnion;
    std::shared_ptr<ReactBridge> mBridge;
    std::shared_ptr<JobQueueImpl> mQueue;
    std::shared_ptr<JobDispatcher> mDispatcher;
    JavascriptType mType;
};
