package co.zenturi.mandolin.xnative;


#if (!macro || java)
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
')
@:headerNamespaceCode('
namespace react {
    class Job {
        public:
            ~Job();
            virtual void run() = 0;
    };

    class JobImpl : public ::co::zenturi::mandolin::xnative::react::Job {
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
}
')
#end