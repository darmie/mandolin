package co.zenturi.mandolin.xnative;


#if ((java || !macro ) && !cpp)
@:build(co.zenturi.mandolin.macros.JNI.proxy())
class Job {
  public function new() {
      
  }
  
  public  function run():Void {
      
  }
}
#elseif cpp 
@:headerCode('
#include <memory>
#include <functional>

    class Job {
        public:
            ~Job();
            virtual void run() = 0;
    };

    class JobImpl : public Job {
        public:
            JobImpl(std::function<void()> xfunc) : mFunc(xfunc) {

            }
            static std::shared_ptr<Job> create(std::function<void()> xfunc) {
                return std::make_shared<JobImpl>(xfunc);
            }

            void run() override {
                mFunc();
            }
        private:
            const std::function<void()> mFunc;
    };

')
@:keep
interface IJob{}
@:include('co/zenturi/mandolin/xnative/IJob.h')
@:native('std::shared_ptr<::Job>')
extern class Job {
    public static inline function init():Job {
        return untyped __cpp__('std::make_shared<::Job>()');
    }
    @:native('run')
    public function run():Void;
}
#end