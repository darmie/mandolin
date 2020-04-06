#include <mandolin_helpers.h>

namespace mandolin
{


JniClassInitializer::registration_vec &JniClassInitializer::get_vec()
{
    return ::djinni::JniClassInitializer::get_vec();
}


std::mutex & JniClassInitializer::get_mutex() {
   return ::djinni::JniClassInitializer::get_mutex();
}

JniClassInitializer::registration_vec JniClassInitializer::get_all() {
    return ::djinni::JniClassInitializer::get_all();
}

JniClassInitializer::JniClassInitializer(std::function<void()> init) {
    return ::djinni::JniClassInitializer(init);
}

void jniInit(JavaVM * jvm){
    ::djinni::jniInit(jvm);
}

void jniShutdown() {
    ::djinni::jniShutdown();
}

JNIEnv * jniGetThreadEnv() {
    return ::djinni::jniGetThreadEnv();
}

// static JNIEnv * getOptThreadEnv() {
//     return ::djinni::getOptThreadEnv();
// }

void GlobalRefDeleter::operator() (jobject globalRef) noexcept {
    ::djinni::GlobalRefDeleter::operator()(globalRef);
}

void LocalRefDeleter::operator() (jobject localRef) noexcept {
    ::djinni::LocalRefDeleter::operator()(localRef);
}

void jni_exception::set_as_pending(JNIEnv * env) const noexcept {
    ::djinni::jni_exception::set_as_pending(env);
}

void jniExceptionCheck(JNIEnv * env) {
    ::djinni::jniExceptionCheck(env);
}

DJINNI_WEAK_DEFINITION
DJINNI_NORETURN_DEFINITION
void jniThrowCppFromJavaException(JNIEnv * env, jthrowable java_exception) {
    ::djinni::jniThrowCppFromJavaException(env, java_exception);
}

void jniThrowAssertionError(JNIEnv * env, const char * file, int line, const char * check) {
    ::djinni::jniThrowAssertionError(env, file, line, check);
}

GlobalRef<jclass> jniFindClass(const char * name) {
    return ::djinni::jniFindClass(name);
}

jmethodID jniGetStaticMethodID(jclass clazz, const char * name, const char * sig) {
    return ::djinni::jniGetStaticMethodID(clazz, name, sig);
}


jmethodID jniGetMethodID(jclass clazz, const char * name, const char * sig) {
    return ::djinni::jniGetMethodID(clazz, name, sig);
}

jfieldID jniGetFieldID(jclass clazz, const char * name, const char * sig){
    return ::djinni::jniGetFieldID(clazz, name, sig);
}

LocalRef<jobject> JniEnum::create(JNIEnv * env, jint value) const {
    return ::djinni::JniEnum::create(env, value);
}

jstring jniStringFromUTF8(JNIEnv * env, const std::string & str) {
    return ::djinni::jniStringFromUTF8(env, str);
}

jstring jniStringFromWString(JNIEnv * env, const std::wstring & str) {
    return ::djinni::jniStringFromWString(env, str);
}

std::string jniUTF8FromString(JNIEnv * env, const jstring jstr) {
    return ::djinni::jniUTF8FromString(env, jstr);
}

std::wstring jniWStringFromString(JNIEnv * env, const jstring jstr) {
    return ::djinni::jniWStringFromString(env, jstr);
}


void jniSetPendingFromCurrent(JNIEnv * env, const char * ctx) noexcept {
    ::djinni::jniSetPendingFromCurrent(env, ctx);
}

void jniDefaultSetPendingFromCurrent(JNIEnv * env, const char * ctx) noexcept {
    ::djinni::jniDefaultSetPendingFromCurrent(env, ctx);
}

template class ProxyCache<JniCppProxyCacheTraits>;
} // namespace mandolin
