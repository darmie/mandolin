package co.zenturi.mandolin.xnative;

#if java 
import co.zenturi.mandolin.xnative.Job.IJob;
@:native('co.zenturi.mandolin.xnative.react.JobDispatcher')
extern class IJobDispatcher {
    @:native('start')
    public function start():Void;

    @:native('quit')
    public function quit():Void;
}

@:build(co.zenturi.mandolin.macros.JNI.bind())
@:keep
@:nativeGen
class JobDispatcher extends IJobDispatcher {
    private var mThread: sys.thread.Thread;
    private var mDestroyed:Bool;

    private var mQueue:JobQueue;

    private function isDestroyed():Bool {
        return mDestroyed;
    }

    private var mRunnable:Void->Void;

    public function new(queue:JobQueue) {
        mThread = null;
        mQueue = queue;

        mRunnable = function(){
            while(!isDestroyed()){
                var job:IJob = new Job();
                while ((job = mQueue.poll()) != null) {
                    job.run();
                }
            }
        };
    }

    override public function start():Void {
        sys.thread.Thread.create(mRunnable);
    }

    override public function quit():Void {
        mDestroyed = true;
        mQueue.interruptPoll();  
    }
}
#elseif cpp
@:headerCode('
class JobDispatcher {
    public:
        virtual ~JobDispatcher() {}
    
        virtual void start() = 0;
    
        virtual void quit() = 0;
    };
')
@:keep
@:nativeGen
interface IJobDispatcher {}

@:include('co/zenturi/mandolin/xnative/IJavascriptDispatcher.h')
@:native('std::shared_ptr<::JobDispatcher>')
extern class JobDispatcher {

    public static inline function init():JobDispatcher {
        return untyped __cpp__('std::make_shared<::JobDispatcher>()');
    }

    @:native('start')
    public function start():Void;

    @:native('quit')
    public function quit():Void;
}
#end