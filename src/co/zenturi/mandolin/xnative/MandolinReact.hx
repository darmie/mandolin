package co.zenturi.mandolin.xnative;

#if ((java || !macro ) && !cpp)
import com.facebook.react.bridge.*;

@keep
class MandolinReact {
    public function new() {
        
    }

    
    public static function createReactBridge(context:#if java ReactApplicationContext #else Dynamic #end) {
        return new ReactBridge(context);
    }


    public static function createMap(?map:MandolinObject<JavascriptMap>):MandolinObject<JavascriptMap> {
        var ret = new JavascriptMap();

        if(map != null) ret.merge(map);

        return ret;
    }

    public static function createArray(?arr:JavascriptArray):MandolinObject<JavascriptArray> {
        var ret = new JavascriptArray();

        if(arr != null) ret.append(arr);

        return ret;
    }

    public static function wrap(object:Dynamic):Dynamic {

        if(object == null){
            return JavascriptObject.fromNull();
        }

        if(Std.is(object, JavascriptMap)){
            var _obj:JavascriptMap = object;
            return JavascriptObject.fromMap(_obj);
        }

        #if java
        if((untyped __java__('{0} instanceof Collection || {0} instanceof Map', object))){
            return JavascriptObject.fromMap(MandolinReact.wrap(object));
        }
        #end

        if(Std.is(object, JavascriptArray)){
            return JavascriptObject.fromArray(object);
        }


        if(Std.is(object, Array) #if java || untyped __java__('{0}.getClass().isArray()', object) #end){
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



        
        #if java
        if(Std.is(object, ReadableType)){
            switch (object) {
                case Array:
                    return JavascriptType.ARRAY;
                case Boolean:
                    return JavascriptType.BOOLEAN;
                case Map:
                    return JavascriptType.MAP;
                case Number:
                    return JavascriptType.NUMBER;
                case String:
                    return JavascriptType.STRING;
                case Null: return JavascriptType.NIL;
                default:
                    return JavascriptType.NIL;
            }
        }
        

        if(Std.is(object, ReadableMapKeySetIterator)){
            return new JavascriptMapKeyIterator(object);
        }

    


        switch (object.getType()){
            case com.facebook.react.bridge.Array: return JavascriptObject.fromArray(MandolinReact.wrap(object.asArray()));
            case com.facebook.react.bridge.Map: return JavascriptObject.fromMap(MandolinReact.wrap(object.asMap()));
            case com.facebook.react.bridge.Number: return JavascriptObject.fromDouble(object.asDouble());
            case com.facebook.react.bridge.Null: return JavascriptObject.fromNull();
            case com.facebook.react.bridge.String: return JavascriptObject.fromString(object.asString());
            case com.facebook.react.bridge.Boolean: return JavascriptObject.fromBoolean(object.asBoolean());
            default: return JavascriptObject.fromNull();
        }

        #end 

        var hxType =  Type.getClassName(Type.getClass(object));
        switch hxType {
            case "haxe.ds.IntMap" | "haxe.ds.StringMap" | "haxe.ds.ObjectMap": return JavascriptObject.fromMap(JavascriptObject.fromMap(object));
            case _: return null;
        }

        return null;

    }

    public static function unwrap(value:Dynamic){
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

    public static function copyReactArray(source:#if java ReadableArray #else Dynamic #end , dest: #if java  WritableArray#else Dynamic #end) {
       #if java
        for (i in 0...source.size()) {
            switch (source.getType(i)) {
                case com.facebook.react.bridge.Null:
                    dest.pushNull();
                case com.facebook.react.bridge.Boolean:
                    dest.pushBoolean(source.getBoolean(i));
                case com.facebook.react.bridge.Number:
                    dest.pushDouble(source.getDouble(i));
                case com.facebook.react.bridge.String:
                    dest.pushString(source.getString(i));
                case com.facebook.react.bridge.Array:
                    var arrayCopy:WritableArray = Arguments.createArray();
                    copyReactArray(source.getArray(i), arrayCopy);
                    dest.pushArray(arrayCopy);
                case com.facebook.react.bridge.Map:
                    var mapCopy:WritableMap = Arguments.createMap();
                    copyReactMap(source.getMap(i), mapCopy);
                    dest.pushMap(mapCopy);
                default: dest.pushNull();
            }
        }
        #end
    }

    public static function copyReactMap(source:#if java ReadableMap #else Dynamic #end , dest:#if java  WritableMap #else Dynamic #end) {
        dest.merge(source);
    }
}
#end