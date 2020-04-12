package co.zenturi.mandolin.xnative;

#if java 
import co.zenturi.mandolin.xnative.Job.IJob;
@:build(co.zenturi.mandolin.macros.JNI.bind(true))
@:build(co.zenturi.mandolin.macros.JNI.proxy())
@:native('co.zenturi.mandolin.xnative.react.JobQueue')
extern class JobQueue {
    @:native('poll')
    public function poll():IJob;

    @:native('interruptPoll')
    public function interruptPoll():Void;
}


// @:keep
// @:nativeGen
// interface JobQueue {
//     public function poll():MandolinObject<Job>;
//     public function interruptPoll():Void;
// }
#elseif cpp
@:headerCode('
#include <memory>
#include <functional>
#include <list>
#include <mutex>
#include "co/zenturi/mandolin/xnative/IJob.h"

class Job;

class JobQueue {
public:
    virtual ~JobQueue() {}

    virtual std::shared_ptr<Job> poll() = 0;

    virtual void interruptPoll() = 0;
};

class JobQueueImpl : public JobQueue {
    public:
        static std::shared_ptr<JobQueueImpl> create() {
            return std::make_shared<JobQueueImpl>();
        };
        JobQueueImpl(){};
        ~JobQueueImpl(){};
    
        std::shared_ptr<Job> poll() override {
            std::unique_lock<std::mutex> lock(mMutex);
            mCondition.wait(lock, [&]{ return !mQueue.empty(); });
            if (!mQueue.empty()) {
                auto func = mQueue.front();
                mQueue.pop_front();
                return JobImpl::create(func);
            } else {
                return nullptr;
            }
        };
        void interruptPoll() override {
            std::unique_lock<std::mutex> lock(mMutex);
            mCondition.notify_one();
        };
    
        void enqueue(std::function<void()> function) {
            std::unique_lock<std::mutex> lock(mMutex);
            mQueue.push_back(function);
            mCondition.notify_one();
        }
    
    private:
        std::list<std::function<void()>> mQueue;
        std::mutex mMutex;
        std::condition_variable mCondition;
};
')
@:keep
@:nativeGen
interface IJobQueue {

}
@:include('co/zenturi/mandolin/xnative/IJobQueue.h')
@:include('<co/zenturi/mandolin/xnative/IJob.h>')
@:native('std::shared_ptr<::JobQueue>')
extern class JobQueue {
    public static inline function init():JobQueue {
        return untyped __cpp__('std::make_shared<::JobQueue>()');
    }

    @:native('poll')
    public function poll():Job;

    @:native('interruptPoll')
    public function interruptPoll():Void;
}
#end