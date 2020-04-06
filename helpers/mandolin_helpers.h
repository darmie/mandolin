#pragma once

#include "djinni_support.hpp"
#include <Marshal.hpp>

/**
 * 
 *  Mandolin Helpers, thanks to Dropbox's Djinni
 */

namespace mandolin
{

typedef ::djinni::Bool Bool;
typedef ::djinni::I8 I8;
typedef ::djinni::I16 I16;
typedef ::djinni::I32 I32;
typedef ::djinni::I64 I64;
typedef ::djinni::F32 F32;
typedef ::djinni::F64 F64;
typedef ::djinni::String String;
typedef ::djinni::WString WString;
typedef ::djinni::Binary Binary;
typedef ::djinni::Date Date;

typedef ::djinni::ListJniInfo ListJniInfo;

template <class T>
class List : public ::djinni::List<T>
{
    using ECppType = typename T::CppType;
    using EJniType = typename T::Boxed::JniType;

public:
    using CppType = std::vector<ECppType>;
    using JniType = jobject;

    using Boxed = List;
    static CppType toCpp(JNIEnv *jniEnv, JniType j)
    {
        return ::djinni::List<T>::toCpp(env, j);
    }

    static LocalRef<JniType> fromCpp(JNIEnv *jniEnv, CppType &c)
    {
        return ::djinni::List<T>::fromCpp(env, c);
    }
};

typedef ::djinni::IteratorJniInfo IteratorJniInfo;
typedef ::djinni::SetJniInfo SetJniInfo;

template <class T>
class Set : public ::djinni::Set<T>
{
    using ECppType = typename T::CppType;
    using EJniType = typename T::Boxed::JniType;

public:
    using CppType = std::unordered_set<ECppType>;
    using JniType = jobject;

    using Boxed = Set;

    static CppType toCpp(JNIEnv *jniEnv, JniType j)
    {
        return ::djinni::Set<T>::toCpp(jniEnv, j);
    }

    static LocalRef<JniType> fromCpp(JNIEnv *jniEnv, const CppType &c)
    {
        return ::djinni::Set<T>::fromCpp(jniEnv, c);
    }
};

typedef ::djinni::MapJniInfo MapJniInfo;
typedef ::djinni::EntrySetJniInfo EntrySetJniInfo;
typedef ::djinni::EntryJniInfo EntryJniInfo;

template <class Key, class Value>
class Map : public ::djinni::Map<Key, Value>
{
    using CppKeyType = typename Key::CppType;
    using CppValueType = typename Value::CppType;
    using JniKeyType = typename Key::Boxed::JniType;
    using JniValueType = typename Value::Boxed::JniType;

public:
    using CppType = std::unordered_map<CppKeyType, CppValueType>;
    using JniType = jobject;

    using Boxed = Map;

    static CppType toCpp(JNIEnv* jniEnv, JniType j){
        return ::djinni::Map<Key, Value>::toCpp(jniEnv, j);
    }

    static LocalRef<JniType> fromCpp(JNIEnv* jniEnv, const CppType& c){
        return ::djinni::Map<Key, Value>::fromCpp(jniEnv, c);
    }
}

/*
 * Base class for Java <-> C++ interface adapters.
 *
 * I is the C++ base class (interface) being adapted; Self is the interface adapter class
 * derived from JniInterface (using CRTP). For example:
 *
 *     class NativeToken final : madolin::JniInterface<Token, NativeToken> { ... }
 */
template <class I, class Self>
class JniInterface : public ::djinni::JniInterface<I, Self>
{
public:
    JniInterface(const char *cppProxyClassName) : ::djinni::JniInterface<I, Self>(cppProxyClassName) {}
    JniInterface() : ::djinni::JniInterface<I, Self>(){};
};

/*
 * Global initialization and shutdown. Call these from JNI_OnLoad and JNI_OnUnload.
 */
void jniInit(JavaVM *jvm);
void jniShutdown();

/*
 * Get the JNIEnv for the invoking thread. Should only be called on Java-created threads.
 */
JNIEnv *jniGetThreadEnv();

/*
 * Global and local reference guard objects.
 *
 * A GlobalRef<T> is constructed with a local reference; the constructor upgrades the local
 * reference to a global reference, and the destructor deletes the local ref.
 *
 * A LocalRef<T> should be constructed with a new local reference. The local reference will
 * be deleted when the LocalRef is deleted.
 */
typedef ::djinni::GlobalRefDeleter GlobalRefDeleter;

template <typename PointerType>
class GlobalRef : public ::djinni::GlobalRef<PointerType>
{
public:
    GlobalRef() : ::djinni::GlobalRef<PointerType>(){};
    GlobalRef(GlobalRef &&obj) : ::djinni::GlobalRef<PointerType>(obj){};
    GlobalRef(JNIEnv *env, PointerType localRef) : ::djinni::GlobalRef<PointerType>(env, localRef){};
}

typedef ::djinni::LocalRefDeleter LocalRefDeleter;

template <typename PointerType>
class LocalRef : public ::djinni::LocalRef<PointerType>
{
public:
    LocalRef() : ::djinni::LocalRef<PointerType>(){};
    LocalRef(JNIEnv * /*env*/, PointerType localRef) : : std::unique_ptr<typename std::remove_pointer<PointerType>::type, ::djinni::LocalRefDeleter>(
                                                             localRef){};
    explicit LocalRef(PointerType localRef) : ::djinni::LocalRef(localRef){};
    // Allow implicit conversion to PointerType so it can be passed
    // as argument to JNI functions expecting PointerType.
    // All functions creating new local references should return LocalRef instead of PointerType
    operator PointerType() const & { return static_cast<::djinni::LocalRef<PointerType>>(this)->get(); }
    operator PointerType() && = delete;
};

template <class T>
const T &get(const T &x) noexcept { return x; }
template <class T>
typename LocalRef<T>::pointer get(const LocalRef<T> &x) noexcept { return x.get(); }

template <class T>
const T &release(const T &x) noexcept { return x; }
template <class T>
typename LocalRef<T>::pointer release(LocalRef<T> &x) noexcept { return x.release(); }
template <class T>
typename LocalRef<T>::pointer release(LocalRef<T> &&x) noexcept { return x.release(); }

/*
 * Exception to indicate that a Java exception is pending in the JVM.
 */
typedef ::djinni::jni_exception jni_exception;

/*
 * Throw if any Java exception is pending in the JVM.
 *
 * If an exception is pending, this function will clear the
 * pending state, and pass the exception to
 * jniThrowCppFromJavaException().
 */
void jniExceptionCheck(JNIEnv *env);

/*
 * Throws a C++ exception based on the given Java exception.
 *
 * java_exception is a local reference to a Java throwable, which
 * must not be null, and should no longer set as "pending" in the JVM.
 * This is called to handle errors in other JNI processing, including
 * by jniExceptionCheck().
 *
 * The default implementation is defined with __attribute__((weak)) so you
 * can replace it by defining your own version.  The default implementation
 * will throw a jni_exception containing the given jthrowable.
 */
DJINNI_NORETURN_DEFINITION
void jniThrowCppFromJavaException(JNIEnv *env, jthrowable java_exception);

/*
 * Set an AssertionError in env with message message, and then throw via jniExceptionCheck.
 */
DJINNI_NORETURN_DEFINITION
void jniThrowAssertionError(JNIEnv *env, const char *file, int line, const char *check);

#define MANDOLIN_ASSERT_MSG(check, env, message)                                  \
    do                                                                            \
    {                                                                             \
        ::mandolin::jniExceptionCheck(env);                                       \
        const bool check__res = bool(check);                                      \
        ::mandolin::jniExceptionCheck(env);                                       \
        if (!check__res)                                                          \
        {                                                                         \
            ::mandolin::jniThrowAssertionError(env, __FILE__, __LINE__, message); \
        }                                                                         \
    } while (false)
#define MANDOLIN_ASSERT(check, env) MANDOLIN_ASSERT_MSG(check, env, #check)

/*
 * Helper for JniClass. (This can't be a subclass because it needs to not be templatized.)
 */
typedef ::djinni::JniClassInitializer JniClassInitializer;

/*
 * Each instantiation of this template produces a singleton object of type C which
 * will be initialized by mandolin::jniInit(). For example:
 *
 * struct JavaFooInfo {
 *     jmethodID foo;
 *     JavaFooInfo() // initialize clazz and foo from jniGetThreadEnv
 * }
 *
 * To use this in a JNI function or callback, invoke:
 *
 *     CallVoidMethod(object, JniClass<JavaFooInfo>::get().foo, ...);
 *
 * This uses C++'s template instantiation behavior to guarantee that any T for which
 * JniClass<T>::get() is *used* anywhere in the program will be *initialized* by init_all().
 * Therefore, it's always safe to compile in wrappers for all known Java types - the library
 * will only depend on the presence of those actually needed.
 */
template <class C>
class JniClass : public ::djinni::JniClass<C>
{
public:
    static const C &get()
    {
        return ::djinni::JniClass<C>::get();
    }

private:
    static void allocate()
    {
        ::djinni::JniClass<C>::allocate();
    }
};

template <class C>
const JniClassInitializer JniClass<C>::s_initializer(allocate);

template <class C>
std::unique_ptr<C> JniClass<C>::s_singleton;

/*
 * Exception-checking helpers. These will throw if an exception is pending.
 */
GlobalRef<jclass> jniFindClass(const char *name);
jmethodID jniGetStaticMethodID(jclass clazz, const char *name, const char *sig);
jmethodID jniGetMethodID(jclass clazz, const char *name, const char *sig);
jfieldID jniGetFieldID(jclass clazz, const char *name, const char *sig);

/*
 * Helper for maintaining shared_ptrs to wrapped Java objects.
 *
 * This is used for automatically wrapping a Java object that exposes some interface
 * with a C++ object that calls back into the JVM, such as a listener. Calling
 * get_java_proxy<T>(obj) the first time will construct a T and return a shared_ptr to it, and
 * also save a weak_ptr to the new object internally. The constructed T contains a strong
 * GlobalRef to jobj. As long as something in C++ maintains a strong reference to the wrapper,
 * future calls to get(jobj) will return the *same* wrapper object.
 *
 *        Java            |           C++
 *                        |        ________________________                ___________
 *   _____________        |       |                        |              |           |
 *  |             |       |       |   JniImplFooListener   | <=========== |    Foo    |
 *  | FooListener | <============ |  : public FooListener, |  shared_ptr  |___________|
 *  |_____________|   GlobalRef   |    JavaProxyCacheEntry |
 *                        |       |________________________|
 *                        |                 ^             ______________________
 *                        |                 \            |                      |
 *                        |                  - - - - - - |    JavaProxyCache    |
 *                        |                   weak_ptr   |______________________|
 *
 * As long as the C++ FooListener has references, the Java FooListener is kept alive.
 *
 * We use a custom unordered_map with Java objects (jobject) as keys, and JNI object
 * identity and hashing functions. This means that as long as a key is in the map,
 * we must have some other GlobalRef keeping it alive. To ensure safety, the Entry
 * destructor removes *itself* from the map - destruction order guarantees that this
 * will happen before the contained global reference becomes invalid (by destruction of
 * the GlobalRef).
 */
typedef ::djinni::JavaIdentityHash JavaIdentityHash;
typedef ::djinni::JavaIdentityEquals JavaIdentityEquals;
typedef ::djinni::JavaProxyCacheTraits JavaProxyCacheTraits;
extern template class ProxyCache<JavaProxyCacheTraits>;
using JavaProxyCache = ProxyCache<JavaProxyCacheTraits>;
template <typename T>
using JavaProxyHandle = JavaProxyCache::Handle<GlobalRef<jobject>, T>;

/*
 * Cache for CppProxy objects. This is the inverse of the JavaProxyCache mechanism above,
 * ensuring that each time we pass an interface from Java to C++, we get the *same* CppProxy
 * object on the Java side:
 *
 *      Java               |            C++
 *                         |
 *    ______________       |         ________________                  ___________
 *   |              |      |        |                |                |           |
 *   | Foo.CppProxy | ------------> | CppProxyHandle | =============> |    Foo    |
 *   |______________|   (jlong)     |      <Foo>     |  (shared_ptr)  |___________|
 *           ^             |        |________________|
 *            \            |
 *        _________        |                     __________________
 *       |         |       |                    |                  |
 *       | WeakRef | <------------------------- | jniCppProxyCache |
 *       |_________|  (GlobalRef)               |__________________|
 *                         |
 *
 * We don't use JNI WeakGlobalRef objects, because they last longer than is safe - a
 * WeakGlobalRef can still be upgraded to a strong reference even during finalization, which
 * leads to use-after-free. Java WeakRefs provide the right lifetime guarantee.
 */
typedef ::djinni::JavaWeakRef JavaWeakRef;
typedef ::djinni::JniCppProxyCacheTraits JniCppProxyCacheTraits;
extern template class ProxyCache<JniCppProxyCacheTraits>;
using JniCppProxyCache = ProxyCache<JniCppProxyCacheTraits>;
template <class T>
using CppProxyHandle = JniCppProxyCache::Handle<std::shared_ptr<T>>;

template <class T>
static const std::shared_ptr<T> & objectFromHandleAddress(jlong handle) {
    return ::djinni::objectFromHandleAddress<T>(handle);
}

/*
 * Information needed to use a CppProxy class.
 *
 * In an ideal world, this object would be properly always-valid RAII, and we'd use an
 * optional<CppProxyClassInfo> where needed. Unfortunately we don't want to depend on optional
 * here, so this object has an invalid state and default constructor.
 */
typedef ::djinni::CppProxyClassInfo CppProxyClassInfo;


/*
 * Guard object which automatically begins and ends a JNI local frame when
 * it is created and destroyed, using PushLocalFrame and PopLocalFrame.
 *
 * Local frame creation can fail. The throwOnError parameter specifies how
 * errors are reported:
 * - true (default): throws on failure
 * - false: queues a JNI exception on failure; the user must call checkSuccess()
 *
 * The JNIEnv given at construction is expected to still be valid at
 * destruction, so this class isn't suitable for use across threads.
 * It is intended for use on the stack.
 *
 * All JNI local references created within the defined scope will be
 * released at the end of the scope.  This class doesn't support
 * the jobject return value supported by PopLocalFrame(), because
 * the destructor cannot return the new reference value for the parent
 * frame.
 */
class JniLocalScope : public ::djinni::JniLocalScope {
    public:
        JniLocalScope(JNIEnv* p_env, jint capacity, bool throwOnError = true) : ::djinni::JniLocalScope(p_env, capacity, throwOnError){};
        ~JniLocalScope(): ~::djinni::JniLocalScope(){};
    private:
        JniLocalScope(const JniLocalScope& other) : ::djinni::JniLocalScope(other);
};


jstring jniStringFromUTF8(JNIEnv * env, const std::string & str);
std::string jniUTF8FromString(JNIEnv * env, const jstring jstr);

jstring jniStringFromWString(JNIEnv * env, const std::wstring & str);
std::wstring jniWStringFromString(JNIEnv * env, const jstring jstr);


class JniEnum : public ::djinni::JniEnum {
    protected:
        JniEnum(const std::string & name): ::djinni::JniEnum(name){}; 

};

typedef ::djinni::JniFlags JniFlags;


#define MANDOLIN_FUNCTION_PROLOGUE0(env_)
#define MANDOLIN_FUNCTION_PROLOGUE1(env_, arg1_)


/*
 * Helper for JNI_TRANSLATE_EXCEPTIONS_RETURN.
 *
 * Must be called in a catch block.  Responsible for setting the pending
 * exception in JNI based on the current C++ exception.
 *
 * The default implementation is defined with __attribute__((weak)) so you
 * can replace it by defining your own version.  The default implementation
 * will call jniDefaultSetPendingFromCurrent(), which will propagate a
 * jni_exception directly into Java, or throw a RuntimeException for any
 * other std::exception.
 */
void jniSetPendingFromCurrent(JNIEnv * env, const char * ctx) noexcept;

/*
 * Helper for JNI_TRANSLATE_EXCEPTIONS_RETURN.
 *
 * Must be called in a catch block.  Responsible for setting the pending
 * exception in JNI based on the current C++ exception.
 *
 * This will call jniSetPendingFrom(env, jni_exception) if the current exception
 * is a jni_exception, or otherwise will set a RuntimeException from any
 * other std::exception.  Any non-std::exception will result in a call
 * to terminate().
 *
 * This is called by the default implementation of jniSetPendingFromCurrent.
 */
void jniDefaultSetPendingFromCurrent(JNIEnv * env, const char * ctx) noexcept;

/* Catch C++ exceptions and translate them to Java exceptions.
 *
 * All functions called by Java must be fully wrapped by an outer try...catch block like so:
 *
 * try {
 *     ...
 * } JNI_TRANSLATE_EXCEPTIONS_RETURN(env, 0)
 * ... or JNI_TRANSLATE_EXCEPTIONS_RETURN(env, ) for functions returning void
 *
 * The second parameter is a default return value to be used if an exception is caught and
 * converted. (For JNI outer-layer calls, this result will always be ignored by JNI, so
 * it can safely be 0 for any function with a non-void return value.)
 */
#define JNI_TRANSLATE_EXCEPTIONS_RETURN(env, ret) \
    catch (const std::exception &) { \
        ::mandolin::jniSetPendingFromCurrent(env, __func__); \
        return ret; \
    }

/* Catch jni_exception and translate it back to a Java exception, without catching
 * any other C++ exceptions.  Can be used to wrap code which might cause JNI
 * exceptions like so:
 *
 * try {
 *     ...
 * } JNI_TRANSLATE_JAVA_EXCEPTIONS_RETURN(env, 0)
 * ... or JNI_TRANSLATE_JAVA_EXCEPTIONS_RETURN(env, ) for functions returning void
 *
 * The second parameter is a default return value to be used if an exception is caught and
 * converted. (For JNI outer-layer calls, this result will always be ignored by JNI, so
 * it can safely be 0 for any function with a non-void return value.)
 */
#define JNI_TRANSLATE_JNI_EXCEPTIONS_RETURN(env, ret) \
    catch (const ::mandolin::jni_exception & e) { \
        e.set_as_pending(env); \
        return ret; \
    }

} // namespace mandolin
