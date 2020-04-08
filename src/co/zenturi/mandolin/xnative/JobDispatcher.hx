package co.zenturi.mandolin.xnative;

#if ((java || !macro ) && !cpp)
class JobDispatcher {
    private var mThread: sys.thread.Thread;
    private var mDestroyed:Bool;

    private var mQueue:MandolinObject<JobQueue>;

    private function isDestroyed():Bool {
        return mDestroyed;
    }

    private var mRunnable:Void->Void;

    public function new(queue:MandolinObject<JobQueue>) {
        mThread = null;
        mQueue = queue;

        mRunnable = function(){
            while(!isDestroyed()){
                var job = new Job();
                while ((job = mQueue.get().poll()) != null) {
                    job.run();
                }
            }
        };
    }

    public function start() {
        sys.thread.Thread.create(mRunnable);
    }

    public function quit() {
        mDestroyed = true;
        mQueue.get().interruptPoll();  
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