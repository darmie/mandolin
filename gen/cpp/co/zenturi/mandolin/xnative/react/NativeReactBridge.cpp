// AUTOGENERATED FILE - DO NOT MODIFY!
// This file is generated by Mandolin - (c) Zenturi.co

#include "NativeReactBridge.hpp"

namespace mandolin_generated {

NativeReactBridge::NativeReactBridge() : ::mandolin::JniInterface<::ReactBridge, NativeReactBridge> {}

NativeReactBridge::~NativeReactBridge() = default;

NativeReactBridge::JavaProxy::JavaProxy(JniType j) : Handle(::mandolin::jniGetThreadEnv(), j) { }

NativeReactBridge::::JavaProxy::~JavaProxy() = default;

std::shared_ptr<JavascriptMap> NativeReactBridge::JavaProxy::createMap() {
	auto jniEnv = ::mandolin::jniGetThreadEnv();
	::mandolin::JniLocalScope jscope(jniEnv, 10);
	const auto& data = ::mandolin::JniClass<::mandolin_generated::NativeReactBridge>::get();
	auto ret = jniEnv->CallObjectMethod(Handle::get().get(), data.method_createMap);
	::mandolin::jniExceptionCheck(jniEnv);
	return ::mandolin_generated::NativeJavascriptMap:toCpp(jniEnv, ret);
}
std::shared_ptr<JavascriptArray> NativeReactBridge::JavaProxy::createArray() {
	auto jniEnv = ::mandolin::jniGetThreadEnv();
	::mandolin::JniLocalScope jscope(jniEnv, 10);
	const auto& data = ::mandolin::JniClass<::mandolin_generated::NativeReactBridge>::get();
	auto ret = jniEnv->CallObjectMethod(Handle::get().get(), data.method_createArray);
	::mandolin::jniExceptionCheck(jniEnv);
	return ::mandolin_generated::NativeJavascriptArray:toCpp(jniEnv, ret);
}
std::shared_ptr<JavascriptMap> NativeReactBridge::JavaProxy::copyMap(const std::shared_ptr<JavascriptMap> & m) {
	auto jniEnv = ::mandolin::jniGetThreadEnv();
	::mandolin::JniLocalScope jscope(jniEnv, 10);
	const auto& data = ::mandolin::JniClass<::mandolin_generated::NativeReactBridge>::get();
	auto ret = jniEnv->CallObjectMethod(Handle::get().get(), data.method_copyMap, ::mandolin_generated::NativeJavascriptMap::fromCpp(jniEnv, m));
	::mandolin::jniExceptionCheck(jniEnv);
	return ::mandolin_generated::NativeJavascriptMap:toCpp(jniEnv, ret);
}
std::shared_ptr<JavascriptArray> NativeReactBridge::JavaProxy::copyArray(const std::shared_ptr<JavascriptArray> & a) {
	auto jniEnv = ::mandolin::jniGetThreadEnv();
	::mandolin::JniLocalScope jscope(jniEnv, 10);
	const auto& data = ::mandolin::JniClass<::mandolin_generated::NativeReactBridge>::get();
	auto ret = jniEnv->CallObjectMethod(Handle::get().get(), data.method_copyArray, ::mandolin_generated::NativeJavascriptArray::fromCpp(jniEnv, a));
	::mandolin::jniExceptionCheck(jniEnv);
	return ::mandolin_generated::NativeJavascriptArray:toCpp(jniEnv, ret);
}
void NativeReactBridge::JavaProxy::emitEventWithMap(const std::string & name, const std::shared_ptr<JavascriptMap> & params) {
	auto jniEnv = ::mandolin::jniGetThreadEnv();
	::mandolin::JniLocalScope jscope(jniEnv, 10);
	const auto& data = ::mandolin::JniClass<::mandolin_generated::NativeReactBridge>::get();
	jniEnv->CallVoidMethod(Handle::get().get(), data.method_emitEventWithMap, ::mandolin::String::fromCpp(jniEnv, name), , ::mandolin_generated::NativeJavascriptMap::fromCpp(jniEnv, params));
	::mandolin::jniExceptionCheck(jniEnv);
}
void NativeReactBridge::JavaProxy::emitEventWithArray(const std::string & name, const std::shared_ptr<JavascriptArray> & params) {
	auto jniEnv = ::mandolin::jniGetThreadEnv();
	::mandolin::JniLocalScope jscope(jniEnv, 10);
	const auto& data = ::mandolin::JniClass<::mandolin_generated::NativeReactBridge>::get();
	jniEnv->CallVoidMethod(Handle::get().get(), data.method_emitEventWithArray, ::mandolin::String::fromCpp(jniEnv, name), , ::mandolin_generated::NativeJavascriptArray::fromCpp(jniEnv, params));
	::mandolin::jniExceptionCheck(jniEnv);
}
std::shared_ptr<::JobDispatcher> NativeReactBridge::JavaProxy::createJobDispatcher(const std::shared_ptr<::JobQueue> & queue) {
	auto jniEnv = ::mandolin::jniGetThreadEnv();
	::mandolin::JniLocalScope jscope(jniEnv, 10);
	const auto& data = ::mandolin::JniClass<::mandolin_generated::NativeReactBridge>::get();
	auto ret = jniEnv->CallObjectMethod(Handle::get().get(), data.method_createJobDispatcher, ::mandolin_generated::NativeJobQueue::fromCpp(jniEnv, queue));
	::mandolin::jniExceptionCheck(jniEnv);
	return ::mandolin_generated::NativeJobDispatcher:toCpp(jniEnv, ret);
}
}
