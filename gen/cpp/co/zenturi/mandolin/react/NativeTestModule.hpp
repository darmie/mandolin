// AUTOGENERATED FILE - DO NOT MODIFY!
// This file is generated by Mandolin - (c) Zenturi.co

#pragma once

#include "TestModule.hpp"

#include <mandolin_helpers.h>

#include <NativeReactBridge.hpp>

#include <NativeJavascriptPromise.hpp>
#include "NativeJavascriptCallback.hpp"
#include "NativeJavascriptArray.hpp"
#include "NativeJavascriptMap.hpp"
namespace mandolin_generated {

class NativeTestModule final : ::mandolin::JniInterface<::TestModule, NativeTestModule> {
public:
	using CppType = std::shared_ptr<::TestModule>;
	using CppOptType = std::shared_ptr<::TestModule>;
	using JniType = jobject;
	using Boxed = NativeTestModule;

	~NativeTestModule();

	static CppType toCpp(JNIEnv* jniEnv, JniType j) { return ::mandolin::JniClass<NativeTestModule>::get()._fromJava(jniEnv, j); }
	static ::mandolin::LocalRef<JniType> fromCppOpt(JNIEnv* jniEnv, const CppOptType& c) { return {jniEnv, ::mandolin::JniClass<NativeTestModule>::get()._toJava(jniEnv, c)}; }
	static ::mandolin::LocalRef<JniType> fromCpp(JNIEnv* jniEnv, const CppType& c) { return fromCppOpt(jniEnv, c); }

private:
	NativeTestModule();
	friend ::mandolin::JniClass<NativeTestModule>;
	friend ::mandolin::JniInterface<::TestModule, NativeTestModule>;

};

} // namespace mandolin_generated 
