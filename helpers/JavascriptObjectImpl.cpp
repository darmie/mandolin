#include "JavascriptObjectImpl.hpp"

JavascriptObjectImpl::JavascriptObjectImpl(const JavascriptObjectImpl &other) : mType(other.mType)
{
    mQueue = JobQueueImpl::create();
    mDispatcher = mBridge->createJobDispatcher(mQueue);
    mDispatcher->start();

    switch (mType)
    {
    case JavascriptType::ARRAY:
        new (&mUnion.mArray) std::shared_ptr<JavascriptArray>(other.mUnion.mArray);
        break;
    case JavascriptType::MAP:
        new (&mUnion.mMap) std::shared_ptr<JavascriptMap>(other.mUnion.mMap);
        break;
    case JavascriptType::BOOLEAN:
        mUnion.mBool = other.mUnion.mBool;
        break;
    case JavascriptType::NUMBER:
        mUnion.mDouble = other.mUnion.mDouble;
        break;
    case JavascriptType::STRING:
        new (&mUnion.mString) std::string(other.mUnion.mString);
        break;
    case JavascriptType::NIL:
    default:
        break;
    }
}

JavascriptObjectImpl::JavascriptObjectImpl(std::nullptr_t) : mType(JavascriptType::NIL){};
JavascriptObjectImpl::JavascriptObjectImpl(bool value) : mType(JavascriptType::BOOLEAN)
{
    mUnion.mBool = value;
};
JavascriptObjectImpl::JavascriptObjectImpl(double value) : mType(JavascriptType::NUMBER)
{
    mUnion.mDouble = value;
};

JavascriptObjectImpl::JavascriptObjectImpl::JavascriptObjectImpl(int32_t value) : mType(JavascriptType::NUMBER)
{
    mUnion.mDouble = value;
};
JavascriptObjectImpl::JavascriptObjectImpl::JavascriptObjectImpl(int64_t value) : mType(JavascriptType::NUMBER)
{
    mUnion.mDouble = value;
};
JavascriptObjectImpl::JavascriptObjectImpl(const std::string &value) : mType(JavascriptType::STRING)
{
    new (&mUnion.mString) std::string(value);
};
JavascriptObjectImpl::JavascriptObjectImpl(const std::shared_ptr<JavascriptArray> &value) : mType(JavascriptType::ARRAY)
{
    new (&mUnion.mArray) std::shared_ptr<JavascriptArray>(value);
};
JavascriptObjectImpl::JavascriptObjectImpl(const std::shared_ptr<JavascriptMap> &value) : mType(JavascriptType::MAP)
{
    new (&mUnion.mMap) std::shared_ptr<JavascriptMap>(value);
};

JavascriptObjectImpl::JavascriptObjectImpl(::Dynamic value)
{
    if (value->__GetType() == vtNull)
    {
        mType = JavascriptType::NIL;
    }
    if (value.IsBool())
    {
        mType = JavascriptType::BOOLEAN;
        mUnion.mBool =  (bool) value;
    }

    if (value.IsNumeric())
    {
        mType = JavascriptType::NUMBER;
        mUnion.mDouble = (bool) value;
    }

    if (value.IsClass<::Dynamic>())
    {
        mType = JavascriptType::MAP;
        ::Array<::String> outFields;
        value->__GetFields(outFields);
        auto v =  mBridge->createMap();
        for (int i = 0; i < outFields->size(); i++)
        {
            auto ref = value->__FieldRef(outFields[i]);
            auto obj = Dynamic(ref.mObject->__Field(outFields[i], HX_PROP_DYNAMIC));
            v->putObject(outFields[i].c_str(), std::make_shared<::JavascriptObjectImpl>(obj));
        }
        new (&mUnion.mMap) std::shared_ptr<JavascriptMap>(v);
    }

    if (value->__GetType() == vtArray)
    {
        mType = JavascriptType::ARRAY;
        auto hxArr = ((::Array<::Dynamic>)value);
        auto length = hxArr->size();
        auto arr = mBridge->createArray();
        for (int i = 0; i < length; i++)
        {
            arr->pushObject(std::make_shared<::JavascriptObjectImpl>(hxArr->__get(i)));
        }

        new (&mUnion.mArray) std::shared_ptr<JavascriptArray>(arr);
    }
};

JavascriptObjectImpl::~JavascriptObjectImpl()
{
    switch (mType)
    {
    case JavascriptType::ARRAY:
        mUnion.mArray.reset();
        break;
    case JavascriptType::MAP:
        mUnion.mMap.reset();
        break;
    case JavascriptType::STRING:
        mUnion.mString.~basic_string();
        break;
    default:
        break;
    }
};

JavascriptType JavascriptObjectImpl::getType()
{
    return mType;
};

bool JavascriptObjectImpl::isNull()
{
    return mType == JavascriptType::NIL;
};

bool JavascriptObjectImpl::asBoolean()
{
    if (mType == JavascriptType::BOOLEAN)
    {
        return mUnion.mBool;
    }
    return false;
};

double JavascriptObjectImpl::asDouble()
{
    if (mType == JavascriptType::NUMBER)
    {
        return mUnion.mDouble;
    }
    return 0;
};

int32_t JavascriptObjectImpl::asInt()
{
    if (mType == JavascriptType::NUMBER)
    {
        return (int32_t)mUnion.mDouble;
    }
    return 0;
};

std::string JavascriptObjectImpl::asString()
{
    if (mType == JavascriptType::STRING)
    {
        return mUnion.mString;
    }
    return nullptr;
};

std::shared_ptr<JavascriptArray> JavascriptObjectImpl::asArray()
{
    if (mType == JavascriptType::ARRAY)
    {
        return mUnion.mArray;
    }
    return nullptr;
};

std::shared_ptr<JavascriptMap> JavascriptObjectImpl::asMap()
{
    if (mType == JavascriptType::MAP)
    {
        return mUnion.mMap;
    }
    return nullptr;
};

::Dynamic JavascriptObjectImpl::asHaxeObject()
{
    if (mType == JavascriptType::ARRAY)
    {
        auto hxArr = &mUnion.mArray;
        auto xarr = new ::Array<::Dynamic>();
        int size = hxArr->get()->size();
        for (int i = 0; i < size; i++)
        {
            auto obj = hxArr->get()->getObject(i);
            xarr[i] = obj->asHaxeObject();
        }

        return ::Dynamic(xarr);
    }

    if (mType == JavascriptType::MAP)
    {
        auto map = &mUnion.mMap;
        ::hx::Object xcls;

        while (map->get()->keySetIterator()->hasNextKey())
        {
            auto key = map->get()->keySetIterator()->nextKey();
            auto obj = map->get()->getObject(key);
            ::Dynamic field = obj->asHaxeObject();
            xcls.__SetField(key.c_str(), hx::Val(field), HX_PROP_DYNAMIC);
        }

        return ::Dynamic(&xcls);
    }

    if (mType == JavascriptType::BOOLEAN)
    {
        return ::Dynamic(mUnion.mBool);
    }

    if (mType == JavascriptType::NUMBER)
    {
        return ::Dynamic(mUnion.mDouble);
    }

    if (mType == JavascriptType::STRING)
    {
        return ::Dynamic(mUnion.mString.c_str());
    }

    return nullptr;
};

std::shared_ptr<::JavascriptObject> JavascriptObjectImpl::fromMap(const std::shared_ptr<JavascriptMap> &value)
{
    return std::make_shared<::JavascriptObjectImpl>(value);
};

std::shared_ptr<::JavascriptObject> JavascriptObjectImpl::fromArray(const std::shared_ptr<JavascriptArray> &value)
{
    return std::make_shared<::JavascriptObjectImpl>(value);
};

std::shared_ptr<::JavascriptObject> JavascriptObjectImpl::fromInt(int32_t value)
{
    return std::make_shared<::JavascriptObjectImpl>(value);
};

std::shared_ptr<JavascriptObject> JavascriptObjectImpl::fromString(const std::string &value)
{
    return std::make_shared<::JavascriptObjectImpl>(value);
};

std::shared_ptr<JavascriptObject> JavascriptObjectImpl::fromDouble(double value)
{
    return std::make_shared<::JavascriptObjectImpl>(value);
};

std::shared_ptr<JavascriptObject> JavascriptObjectImpl::fromBoolean(bool value)
{
    return std::make_shared<::JavascriptObjectImpl>(value);
};

std::shared_ptr<JavascriptObject> JavascriptObjectImpl::fromNull()
{
    return std::make_shared<::JavascriptObjectImpl>(nullptr);
};

std::shared_ptr<::JavascriptObject> JavascriptObjectImpl::fromHaxe(::Dynamic value)
{
    return std::make_shared<::JavascriptObjectImpl>(value);
};
