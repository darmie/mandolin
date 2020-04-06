package co.zenturi.mandolin.xnative;

#if (!macro || java)
@:build(co.zenturi.mandolin.macros.JNI.proxy())
interface JobQueue {
    public function poll():MandolinObject<Job>;
    public function interruptPoll():Void;
}
#elseif cpp
@:headerCode('
#include <functional>
#include <list>
#include <memory>
#include <mutex>
#include <co/zenturi/mandolin/xnative/Job.h>
')
@:headerNamespaceCode('
namespace react {
    class Job;
    class JobQueue {
        public:
            ~JobQueue();
            virtual std::shared_ptr<Job> poll() = 0;
            virtual void interruptPoll() = 0;
    };
    class JobImpl;
    class JobQueueImpl : public JobQueue {
        public:
            static std::shared_ptr<JobQueueImpl> create() {
                return std::make_shared<JobQueueImpl>();
            }
            JobQueueImpl() {

            }
            ~JobQueueImpl() {

            }
        
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
            }
            void interruptPoll() override {
                std::unique_lock<std::mutex> lock(mMutex);
                mCondition.notify_one();
            }
        
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
}
')
#end