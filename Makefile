
JFLAGS = -g
JC = javac
.SUFFIXES: .java .class
.java.class:
			$(JC) $(JFLAGS) -sourcepath gen/jni  -cp ".:lib/react-native-0.61.5.jar:lib/javax-inject.jar:lib/android.jar:" /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/_Array/ArrayIterator.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/react/ReactBuild.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptArray.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptCallback.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptMap.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptMapKeyIterator.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptPromise.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptType.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/Job.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JobDispatcher.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JobDispatcher_new_33__Fun.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/MandolinReact.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/ReactBridge.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/Init.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/vm/Deque.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/vm/HaxeThread.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/vm/Thread.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Closure.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/DynamicObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/EmptyObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Enum.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Exceptions.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/FieldLookup.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Function.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/HaxeException.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/HxObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/IEquatable.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/IHxObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/ParamEnum.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Runtime.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/StringExt.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/StringRefl.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/VarArgsBase.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/VarArgsFunction.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Array.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Reflect.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Std.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/StringBuf.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Type.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/sys/thread/_Thread/Thread_Impl_.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/react/TestModule.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptArray.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptCallback.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptMap.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptMapKeyIterator.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptPromise.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/Job.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JobDispatcher.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JobQueue.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/MandolinReact.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/ReactBridge.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/react/TestModule.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptArray.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptCallback.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptMap.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptMapKeyIterator.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptPromise.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/Job.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JobDispatcher.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JobQueue.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/MandolinReact.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/ReactBridge.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/_Array/ArrayIterator.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/react/ReactBuild.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptArray.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptCallback.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptMap.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptMapKeyIterator.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptPromise.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptType.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/Job.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JobDispatcher.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JobDispatcher_new_33__Fun.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/MandolinReact.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/ReactBridge.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/Init.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/vm/Deque.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/vm/HaxeThread.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/vm/Thread.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Closure.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/DynamicObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/EmptyObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Enum.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Exceptions.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/FieldLookup.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Function.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/HaxeException.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/HxObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/IEquatable.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/IHxObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/ParamEnum.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Runtime.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/StringExt.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/StringRefl.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/VarArgsBase.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/VarArgsFunction.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Array.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Reflect.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Std.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/StringBuf.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Type.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/sys/thread/_Thread/Thread_Impl_.java

CLASSES = /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/_Array/ArrayIterator.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/react/ReactBuild.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptArray.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptCallback.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptMap.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptMapKeyIterator.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptPromise.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptType.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/Job.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JobDispatcher.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JobDispatcher_new_33__Fun.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/MandolinReact.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/ReactBridge.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/Init.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/vm/Deque.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/vm/HaxeThread.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/vm/Thread.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Closure.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/DynamicObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/EmptyObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Enum.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Exceptions.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/FieldLookup.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Function.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/HaxeException.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/HxObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/IEquatable.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/IHxObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/ParamEnum.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Runtime.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/StringExt.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/StringRefl.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/VarArgsBase.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/VarArgsFunction.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Array.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Reflect.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Std.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/StringBuf.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Type.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/sys/thread/_Thread/Thread_Impl_.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/react/TestModule.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptArray.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptCallback.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptMap.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptMapKeyIterator.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptPromise.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/Job.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JobDispatcher.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JobQueue.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/MandolinReact.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/ReactBridge.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/react/TestModule.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptArray.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptCallback.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptMap.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptMapKeyIterator.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptPromise.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/Job.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JobDispatcher.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JobQueue.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/MandolinReact.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/ReactBridge.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/_Array/ArrayIterator.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/react/ReactBuild.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptArray.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptCallback.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptMap.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptMapKeyIterator.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptPromise.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JavascriptType.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/Job.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JobDispatcher.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/JobDispatcher_new_33__Fun.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/MandolinReact.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/co/zenturi/mandolin/xnative/ReactBridge.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/Init.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/vm/Deque.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/vm/HaxeThread.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/java/vm/Thread.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Closure.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/DynamicObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/EmptyObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Enum.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Exceptions.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/FieldLookup.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Function.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/HaxeException.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/HxObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/IEquatable.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/IHxObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/ParamEnum.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/Runtime.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/StringExt.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/StringRefl.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/VarArgsBase.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/lang/VarArgsFunction.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Array.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Reflect.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Std.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/StringBuf.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/haxe/root/Type.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/bin/java/src/sys/thread/_Thread/Thread_Impl_.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/react/TestModule.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptArray.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptCallback.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptMap.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptMapKeyIterator.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptObject.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JavascriptPromise.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/Job.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JobDispatcher.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/JobQueue.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/MandolinReact.java /Volumes/Vibranium/Workspace/Zenturi/project/Mandolin/gen/jni/co/zenturi/mandolin/xnative/react/ReactBridge.java 
default: classes

classes: $(CLASSES:.java=.class)
clean:
		$(RM) *.class
		