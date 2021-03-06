// AUTOGENERATED FILE - DO NOT MODIFY!
// This file is generated by Mandolin - (c) Zenturi.co

#pragma once

#include <co/zenturi/mandolin/xnative/react/IReactBridge.h>

#include <mandolin_helpers.h>

namespace mandolin_generated {

class NativeReactBridge final : ::mandolin::JniInterface<::ReactBridge, NativeReactBridge> {
public:
	using CppType = std::shared_ptr<::ReactBridge>;
	using CppOptType = std::shared_ptr<::ReactBridge>;
	using JniType = jobject;
	using Boxed = NativeReactBridge;

	~NativeReactBridge(){};

	static CppType toCpp(JNIEnv* jniEnv, JniType j) { return ::mandolin::JniClass<NativeReactBridge>::get()._fromJava(jniEnv, j); }
	static ::mandolin::LocalRef<JniType> fromCppOpt(JNIEnv* jniEnv, const CppOptType& c) { return {jniEnv, ::mandolin::JniClass<NativeReactBridge>::get()._toJava(jniEnv, c)}; }
	static ::mandolin::LocalRef<JniType> fromCpp(JNIEnv* jniEnv, const CppType& c) { return fromCppOpt(jniEnv, c); }

private:
	NativeReactBridge(){};
	friend ::mandolin::JniClass<NativeReactBridge>;
	friend ::mandolin::JniInterface<::ReactBridge, NativeReactBridge>;

	class JavaProxy final : ::mandolin::JavaProxyHandle<JavaProxy>, public ::ReactBridge {
		public:
			JavaProxy(JniType j);
			~JavaProxy();
			std::shared_ptr<::JavascriptMap> createMap() override;
			std::shared_ptr<::JavascriptArray> createArray() override;
			std::shared_ptr<::JavascriptMap> copyMap(const std::shared_ptr<::JavascriptMap> & m) override;
			std::shared_ptr<::JavascriptArray> copyArray(const std::shared_ptr<::JavascriptArray> & a) override;
			void emitEventWithMap(const std::string & name, const std::shared_ptr<::JavascriptMap> & params) override;
			void emitEventWithArray(const std::string & name, const std::shared_ptr<::JavascriptArray> & params) override;
			std::shared_ptr<::JobDispatcher> createJobDispatcher(const std::shared_ptr<::JobQueue> & queue) override;
		private:
			friend ::mandolin::JniInterface<::ReactBridge, ::mandolin_generated::NativeReactBridge>;
	};

	const ::mandolin::GlobalRef<jclass> clazz { ::mandolin::jniFindClass("co/zenturi/mandolin/xnative/react/ReactBridge") };
	const jmethodID method_createMap { ::mandolin::jniGetMethodID(clazz.get(), "createMap", "()") };
	const jmethodID method_createArray { ::mandolin::jniGetMethodID(clazz.get(), "createArray", "()") };
	const jmethodID method_copyMap { ::mandolin::jniGetMethodID(clazz.get(), "copyMap", "()") };
	const jmethodID method_copyArray { ::mandolin::jniGetMethodID(clazz.get(), "copyArray", "()") };
	const jmethodID method_emitEventWithMap { ::mandolin::jniGetMethodID(clazz.get(), "emitEventWithMap", "(Ljava/lang/String; )V") };
	const jmethodID method_emitEventWithArray { ::mandolin::jniGetMethodID(clazz.get(), "emitEventWithArray", "(Ljava/lang/String; )V") };
	const jmethodID method_createJobDispatcher { ::mandolin::jniGetMethodID(clazz.get(), "createJobDispatcher", "()") };
};

} // namespace mandolin_generated 
