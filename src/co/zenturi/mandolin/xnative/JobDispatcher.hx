package co.zenturi.mandolin.xnative;

#if (!macro || java)
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
#end