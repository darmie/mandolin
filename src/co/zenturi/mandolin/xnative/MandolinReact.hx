package co.zenturi.mandolin.xnative;

#if java  
import com.facebook.react.bridge.*;
import co.zenturi.mandolin.xnative.JavascriptMap.IJavascriptMap;
import co.zenturi.mandolin.xnative.JavascriptArray.IJavascriptArray;
import co.zenturi.mandolin.xnative.ReactBridge.IReactBridge;

@:native('co.zenturi.mandolin.xnative.react.MandolinReact')
extern class IMandolinReact {
    @:native('co.zenturi.mandolin.xnative.react.MandolinReact.createReactBridge')
    public static function createReactBridge(context:ReactApplicationContext):IReactBridge;

    @:native('co.zenturi.mandolin.xnative.react.MandolinReact.createMap')
    public static function createMap(map:IJavascriptMap):IJavascriptMap;

    @:native('co.zenturi.mandolin.xnative.react.MandolinReact.createArray')
    public static function createArray(map:IJavascriptArray):IJavascriptArray;

    @:native('co.zenturi.mandolin.xnative.react.MandolinReact.copyReactMap')
    public static function copyReactMap(source:ReadableMap  , dest:WritableMap):Void;

    @:native('co.zenturi.mandolin.xnative.react.MandolinReact.copyReactArray')
    public static function copyReactArray(source:ReadableArray , dest:WritableArray):Void;

    @:native('co.zenturi.mandolin.xnative.react.MandolinReact.wrap')
    public static function wrap(object:Dynamic):Dynamic;

    @:native('co.zenturi.mandolin.xnative.react.MandolinReact.unwrap')
    public static function unwrap(value:Dynamic):Dynamic;
}


@:build(co.zenturi.mandolin.macros.JNI.bind())
@dep("com.facebook.react.bridge.*")
@:keep
@:nativeGen
class MandolinReact extends IMandolinReact {
    
    override public static function createReactBridge(context:#if java ReactApplicationContext #else Dynamic #end):IReactBridge {
        return new co.zenturi.mandolin.xnative.ReactBridge(context);
    }


    override public static function createMap(?map:JavascriptMap):JavascriptMap {
        var ret = new JavascriptMap();

        if(map != null) ret.merge(map);

        return ret;
    }

    override public static function createArray(?arr:JavascriptArray):JavascriptArray {
        var ret = new JavascriptArray();

        if(arr != null) ret.append(arr);

        return ret;
    }

    override public static function wrap(object:Dynamic):Dynamic {

        if(object == null){
            return JavascriptObject.fromNull();
        }

        if(Std.is(object, JavascriptMap)){
            var _obj:JavascriptMap = object;
            return JavascriptObject.fromMap(_obj);
        }


        // if((untyped __java__('{0} instanceof java.util.Collection || {0} instanceof java.util.Map', object))){
        //     return JavascriptObject.fromMap(MandolinReact.wrap(object));
        // }
      

        if(Std.is(object, JavascriptArray)){
            return JavascriptObject.fromArray(object);
        }


        if(Std.is(object, Array)){
            return JavascriptObject.fromArray(object);
        }

    

        if(Std.is(object, JavascriptCallback)){
            return new JavascriptCallback(cast object);
        }

        if(Std.is(object, Bool)){
            return JavascriptObject.fromBoolean(object);
        }

        if(Std.is(object, Float)){
            return JavascriptObject.fromDouble(object);
        }



        
    
        if(Std.is(object, ReadableType)){
            if(object == ReadableType.Array){
                return JavascriptType.ARRAY;
            }
            if(object == ReadableType.Boolean){
                return JavascriptType.BOOLEAN;
            }
            if(object == ReadableType.Map){
                return JavascriptType.MAP;
            }
            if(object == ReadableType.Number){
                return JavascriptType.NUMBER;
            }
            if(object == ReadableType.String){
                return JavascriptType.STRING;
            }
            return JavascriptType.NIL;
        }
        

        if(Std.is(object, ReadableMapKeySetIterator)){
            return new JavascriptMapKeyIterator(object);
        }

    
        if(object.getType() == com.facebook.react.bridge.ReadableType.Array){
            return JavascriptObject.fromArray(MandolinReact.wrap(object.asArray()));
        }

        if(object.getType() == com.facebook.react.bridge.ReadableType.Map){
            return JavascriptObject.fromMap(MandolinReact.wrap(object.asMap()));
        }

        if(object.getType() == com.facebook.react.bridge.ReadableType.Number){
            return JavascriptObject.fromDouble(object.asDouble());
        }

        if(object.getType() == com.facebook.react.bridge.ReadableType.String){
            return JavascriptObject.fromString(object.asString());
        }

        if(object.getType() == com.facebook.react.bridge.ReadableType.Boolean){
            return JavascriptObject.fromBoolean(object.asBoolean());
        }

        if(object.getType() == com.facebook.react.bridge.ReadableType.Null){
            return return JavascriptObject.fromNull();
        }

    

        // var hxType =  Type.getClassName(Type.getClass(object));
        // switch hxType {
        //     case "haxe.ds.IntMap" | "haxe.ds.StringMap" | "haxe.ds.ObjectMap": return JavascriptObject.fromMap(JavascriptObject.fromMap(object));
        //     case _: return null;
        // }

        return null;

    }

    override public static function unwrap(value:Dynamic):Dynamic {
        if(Std.is(value, JavascriptMap)){
            return value.getWriteableMap();
        }

        if(Std.is(value, JavascriptArray)){
            return value.getWriteableArray();
        }

        var _type:JavascriptType = value.getType();
        switch (_type) {
            case ARRAY:
                return MandolinReact.unwrap(value.asArray());
            case BOOLEAN:
                return value.asBoolean();
            case MAP:
                return MandolinReact.unwrap(value.asMap());
            case NUMBER:
                return value.asDouble();
            case STRING:
                return value.asString();
            default: return null;
            case NIL:
                return null;
        }
    }

    override public static function copyReactArray(source:ReadableArray , dest:WritableArray):Void {
     
        for (i in 0...source.size()) {
            if(source.getType(i) == com.facebook.react.bridge.ReadableType.Null){
                dest.pushNull();
            } else if(source.getType(i) == com.facebook.react.bridge.ReadableType.Boolean){
                dest.pushBoolean(source.getBoolean(i));
            }
            else if(source.getType(i) == com.facebook.react.bridge.ReadableType.Number){
                dest.pushDouble(source.getDouble(i));
            }
            else if(source.getType(i) == com.facebook.react.bridge.ReadableType.String){
                dest.pushString(source.getString(i));
            }
            else if(source.getType(i) == com.facebook.react.bridge.ReadableType.Array){
                var arrayCopy:WritableArray = Arguments.createArray();
                copyReactArray(source.getArray(i), arrayCopy);
                dest.pushArray(arrayCopy);
            }
            else if(source.getType(i) == com.facebook.react.bridge.ReadableType.Map){
                var mapCopy:WritableMap = Arguments.createMap();
                copyReactMap(source.getMap(i), mapCopy);
                dest.pushMap(mapCopy);
            } else {
                dest.pushNull();
            }
        }
    }

    override public static function copyReactMap(source:ReadableMap  , dest:WritableMap):Void {
        dest.merge(source);
    }
}
#end