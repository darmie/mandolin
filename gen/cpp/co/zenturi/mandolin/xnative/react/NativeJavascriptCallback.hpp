// AUTOGENERATED FILE - DO NOT MODIFY!
// This file is generated by Mandolin - (c) Zenturi.co

#pragma once

#include <co/zenturi/mandolin/xnative/react/IJavascriptCallback.h>

#include <mandolin_helpers.h>

namespace mandolin_generated {

class NativeJavascriptCallback final : ::mandolin::JniInterface<::JavascriptCallback, NativeJavascriptCallback> {
public:
	using CppType = std::shared_ptr<::JavascriptCallback>;
	using CppOptType = std::shared_ptr<::JavascriptCallback>;
	using JniType = jobject;
	using Boxed = NativeJavascriptCallback;

	~NativeJavascriptCallback(){};

	static CppType toCpp(JNIEnv* jniEnv, JniType j) { return ::mandolin::JniClass<NativeJavascriptCallback>::get()._fromJava(jniEnv, j); }
	static ::mandolin::LocalRef<JniType> fromCppOpt(JNIEnv* jniEnv, const CppOptType& c) { return {jniEnv, ::mandolin::JniClass<NativeJavascriptCallback>::get()._toJava(jniEnv, c)}; }
	static ::mandolin::LocalRef<JniType> fromCpp(JNIEnv* jniEnv, const CppType& c) { return fromCppOpt(jniEnv, c); }

private:
	NativeJavascriptCallback(){};
	friend ::mandolin::JniClass<NativeJavascriptCallback>;
	friend ::mandolin::JniInterface<::JavascriptCallback, NativeJavascriptCallback>;

	class JavaProxy final : ::mandolin::JavaProxyHandle<JavaProxy>, public ::JavascriptCallback {
		public:
			JavaProxy(JniType j);
			~JavaProxy();
			void invoke(const std::vector< std::shared_ptr<::JavascriptObject> > & args) override;
			void invokeSingleArg(const std::shared_ptr<::JavascriptObject> & o) override;
		private:
			friend ::mandolin::JniInterface<::JavascriptCallback, ::mandolin_generated::NativeJavascriptCallback>;
	};

	const ::mandolin::GlobalRef<jclass> clazz { ::mandolin::jniFindClass("co/zenturi/mandolin/xnative/react/JavascriptCallback") };
	const jmethodID method_invoke { ::mandolin::jniGetMethodID(clazz.get(), "invoke", "(Ljava/util/ArrayList;)V") };
	const jmethodID method_invokeSingleArg { ::mandolin::jniGetMethodID(clazz.get(), "invokeSingleArg", "()V") };
};

} // namespace mandolin_generated 
