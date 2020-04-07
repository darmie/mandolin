package co.zenturi.mandolin.xnative;

#if (!macro || java)
@:build(co.zenturi.mandolin.macros.JNI.proxy())
interface JobQueue {
    public function poll():MandolinObject<Job>;
    public function interruptPoll():Void;
}
#end