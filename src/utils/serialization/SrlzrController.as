/**
 * Created with IntelliJ IDEA.
 * User: filiperp
 * Date: 30/11/12
 * Time: 10:30
 * To change this template use File | Settings | File Templates.
 */
package utils.serialization {
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.describeType;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;
import flash.xml.XMLNode;

public class SrlzrController {

    private static var theInstancesList:Dictionary ;
    private static var indexCounter:int ;

    public static function convertToSerializableObject(obj:*):*{
        theInstancesList = new Dictionary();
        indexCounter=0;
        return convertToSrlzdObject(obj);

    }

    public static function convertToOriginalObject(obj:*):*{
        theInstancesList= new Dictionary();
        indexCounter=0;
        return convertToOrgnlObject(obj);

    }

    private static function convertToOrgnlObject(obj:*):Object{
        var theNameclass:String = getNameClass(obj);
        var result:Object= {};


        switch (theNameclass) {
            case ("int"):
            case ("Number"):
                result = Number(obj);
                break;
            case ("String"):
                result= String(obj);
                break;
            case ("Boolean"):
                result= Boolean(obj);
                break;
            case ("null"):
            case ("void"):
            case ("undefined"):
                result= null;
                break;
            case ("Date"):
                result = new Date();
                result.setTime(obj["___value"]);
                break;
            case ("Object"):
                var propertiesOrder= new Array();
                var id:String = "";
                var className:String = "";
                var value:Object = {};
                if(obj["___idRef"]){
                    result = theInstancesList[obj["___idRef"]];
                }else{
                    id =  obj["___id"];
                    className=  obj["___className"];
                    switch(className){
                        case("Array"):
                            value= obj["___value"];
                            result = new Array();
                            for each (var oArray:Object in value as Array) {
                                result.push(convertToOrgnlObject(oArray));
                            }
                            theInstancesList[id]= result;
                            break;
                        case ("flash.utils.Dictionary"):
                            value= obj["___value"];
                            result = new Dictionary();
                            for each (var itemDic  in value as Array) {
                                var indexDic:Object = convertToOrgnlObject(itemDic[0]);
                                result[indexDic]=convertToOrgnlObject(itemDic[1])
                            }
                            theInstancesList[id]= result;
                            break;
                        case ( "Object"):
                            propertiesOrder = obj["___propertiesOrder"] as Array;
                            result =  new Object();
                            for (var i:int = 0; i < propertiesOrder.length; i++) {
                                var propertyArray:String = propertiesOrder[i];
                                result[propertyArray]=convertToOrgnlObject( obj[propertyArray]);
                            }
                            // MonsterDebugger.trace("parseado", result,"","",0xff000,50)
                            theInstancesList[id]= result;
                            break;
                        case ("null"):
                        case ("void"):
                        case ("undefined"):
                            result= null;
                            break;
                        case "XMLList":
                            result = new XMLList(obj['___value']);
                            break;
                        case "XML":
                            result = new XML(obj['___value']);
                            break;
                        case "XMLNode":
                            result = new XMLNode(1,obj['___value']);
                            break;
                        case "XMLAttribute":
                            result = new XML(obj['___value']);
                            break;
                        case ("Date"):
                            result = new Date();
                            result.setTime(obj["___value"]);
                            break;
                        default:

                            var clssOrg:Class = getClassByName(className);
                            result =  new clssOrg();

                            if(className.substr(0,8)=="Vector.<") {
                                value= obj["___value"];
                                for each  (var dicObj:Object in value) {
                                    result.push(convertToOrgnlObject(dicObj))

                                }
                                theInstancesList[id]= result;
                            } else{
                                propertiesOrder = obj["___propertiesOrder"] as Array;
                                for each (var typedObjProperty:String in propertiesOrder) {
                                    result[typedObjProperty] =convertToOrgnlObject(obj[typedObjProperty]);
                                }
                                theInstancesList[id]= result;
                            }
                            break;
                    }

                }
                break;
        }

        return result;
    }

    private static function convertToSrlzdObject(obj:*):Object{
        var theNameclass:String = getNameClass(obj);
        var result:Object= {};

        switch (theNameclass) {
            case ("int"):
            case ("Number"):
                result = Number(obj);
                break;
            case ("String"):
                result= String(obj);
                break;
            case ("Boolean"):
                result= Boolean(obj);
                break;
            case ("null"):
            case ("void"):
            case ("undefined"):
                result= null;
                break;
            case ("Date"):
                result.___className=theNameclass;
                result.___value = obj.valueOf();
                break;
            case ("Array"):
                result.___className=theNameclass;
                if(theInstancesList[obj]){
                    result.___idRef =theInstancesList[obj];
                }else{
                    result.___id = generateIndex();
                    theInstancesList[obj]= result.___id;
                    result.___value = [];
                    for each (var itemArray : * in obj as Array) {
                        result.___value.push(convertToSrlzdObject(itemArray));
                    }
                }
                break;
            case ("flash.utils.Dictionary"):
                result.___className=theNameclass;
                if(theInstancesList[obj]){
                    result.___idRef =theInstancesList[obj];
                }else{
                    result.___id = generateIndex();
                    theInstancesList[obj]= result.___id;
                    result.___value = [];
                    for  (var itemDic  in obj as Dictionary) {
                        var elementCreated:Array = [convertToSrlzdObject(itemDic),convertToSrlzdObject(obj[itemDic])];
                        result.___value.push(elementCreated);
                    }
                }
                break;
            case "Object":
                result.___className=theNameclass;
                result.___propertiesOrder = [];
                if(theInstancesList[obj]){
                    result.___idRef =theInstancesList[obj];
                }else{
                    result.___id = generateIndex();
                    theInstancesList[obj]= result.___id;
                    for (var objKey:String in obj){
                        result.___propertiesOrder.push(objKey);
                        result[objKey]= convertToSrlzdObject(obj[objKey]);
                    }
                }
                break;
            case "XMLList":
            case "XML":
            case "XMLNode":
            case "XMLAttribute":
                result.___className=theNameclass;
                result.___value = (obj).toString();
                break;
            default:
                if(theNameclass.substr(0,8)=="Vector.<") {
                    result.___className=theNameclass;
                    if(theInstancesList[obj]){
                        result.___idRef =theInstancesList[obj];
                    }else{
                        result.___id = generateIndex();
                        theInstancesList[obj]= result.___id;
                        result.___value = [];
                        for each (var itemVec : * in obj ) {
                            result.___value.push(convertToSrlzdObject(itemVec));
                        }
                    }
                }else{
                    result.___propertiesOrder = new Array(0);
                    result.___className=theNameclass;
                    if(theInstancesList[obj]){
                        result.___idRef =theInstancesList[obj];
                    }else{
                        result.___id = generateIndex();
                        theInstancesList[obj]= result.___id;
                        var clss : Class = getClassByObject(obj);
                        var name:String = "";
                        var type:String = "";
                        var propertiesList : XMLList = describeType(clss)..factory..variable;
                        for(var i : int;i < propertiesList.length();i++) {
                            name= String(propertiesList[i].@name);
                            type= clearClassName(String(propertiesList[i].@type));
                            result.___propertiesOrder.push(name);
                            result[name]= convertToSrlzdObject(obj[name]);
                        }
                    }
                }
                break;
        }
        return result;
    }


    //base 64
    public static function base64EncodeObject(value:Object):String{
        if(value==null){
            throw new Error("null isn't a legal utils.serialization candidate");
        }
        var bytes:ByteArray = new ByteArray();
        bytes.writeObject(value);
        bytes.position = 0;
        var b64:String =_base64Encode(bytes);
        return b64;
    }

    public static function base64DecodeObject(value:String):Object{
        var bytes:ByteArray = _base64Decode(value);
        bytes.position=0;
        return bytes.readObject();
    }

    // base 64 for strings
    public static function base64EncodeString(string:String):String{
        var bytes:ByteArray = new ByteArray();
        bytes.writeUTFBytes(string);
        var b64:String =_base64Encode(bytes);
        return b64;
    }

    public static function base64DecodeString(string:String):String{
        var decode:String = _base64Decode(string).toString();
        return decode;
    }

    /* compress*/
    public static function compress(str : String) : String {
        var bytes : ByteArray = new ByteArray();
        bytes.writeUTFBytes(str);
        bytes.compress();
        return _base64Encode(bytes);

    }

    public static function decompress(str : String) : String {
        var decode : ByteArray = _base64Decode(str);
        decode.uncompress();
        return decode.toString();
    }
    /* Base 64*/
    private static  const encodeChars:Array =
            ['A','B','C','D','E','F','G','H',
                'I','J','K','L','M','N','O','P',
                'Q','R','S','T','U','V','W','X',
                'Y','Z','a','b','c','d','e','f',
                'g','h','i','j','k','l','m','n',
                'o','p','q','r','s','t','u','v',
                'w','x','y','z','0','1','2','3',
                '4','5','6','7','8','9','+','/'];
    private static  const decodeChars:Array =
            [-1, -1, -1, -1, -1, -1, -1, -1,
                -1, -1, -1, -1, -1, -1, -1, -1,
                -1, -1, -1, -1, -1, -1, -1, -1,
                -1, -1, -1, -1, -1, -1, -1, -1,
                -1, -1, -1, -1, -1, -1, -1, -1,
                -1, -1, -1, 62, -1, -1, -1, 63,
                52, 53, 54, 55, 56, 57, 58, 59,
                60, 61, -1, -1, -1, -1, -1, -1,
                -1,  0,  1,  2,  3,  4,  5,  6,
                7,  8,  9, 10, 11, 12, 13, 14,
                15, 16, 17, 18, 19, 20, 21, 22,
                23, 24, 25, -1, -1, -1, -1, -1,
                -1, 26, 27, 28, 29, 30, 31, 32,
                33, 34, 35, 36, 37, 38, 39, 40,
                41, 42, 43, 44, 45, 46, 47, 48,
                49, 50, 51, -1, -1, -1, -1, -1];
    private static function _base64Encode(data:ByteArray):String {
        var out:Array = [];
        var i:int = 0;
        var j:int = 0;
        var r:int = data.length % 3;
        var len:int = data.length- r;
        var c:int;
        while (i < len) {
            c = data[i++] << 16 | data[i++] << 8 | data[i++];
            out[j++] = encodeChars[c >> 18] + encodeChars[c >> 12 & 0x3f] + encodeChars[c >> 6 & 0x3f] + encodeChars[c & 0x3f];
        }
        if (r == 1) {
            c = data[i++];
            out[j++] = encodeChars[c >> 2] + encodeChars[(c & 0x03) << 4] + "==";
        }
        else if (r == 2) {
            c = data[i++] << 8 | data[i++];
            out[j++] = encodeChars[c >> 10] + encodeChars[c >> 4 & 0x3f] + encodeChars[(c & 0x0f) << 2] + "=";
        }
        return out.join('');
    }

    private static function _base64Decode(str:String):ByteArray {
        var c1:int;
        var c2:int;
        var c3:int;
        var c4:int;
        var i:int;
        var len:int;
        var out:ByteArray;
        len = str.length;
        i = 0;
        out = new ByteArray();
        while (i < len) {
            // c1
            do {
                c1 = decodeChars[str.charCodeAt(i++) & 0xff];
            } while (i < len && c1 == -1);
            if (c1 == -1) {
                break;
            }
            // c2
            do {
                c2 = decodeChars[str.charCodeAt(i++) & 0xff];
            } while (i < len && c2 == -1);
            if (c2 == -1) {
                break;
            }
            out.writeByte((c1 << 2) | ((c2 & 0x30) >> 4));
            // c3
            do {
                c3 = str.charCodeAt(i++) & 0xff;
                if (c3 == 61) {
                    return out;
                }
                c3 = decodeChars[c3];
            } while (i < len && c3 == -1);
            if (c3 == -1) {
                break;
            }
            out.writeByte(((c2 & 0x0f) << 4) | ((c3 & 0x3c) >> 2));
            // c4
            do {
                c4 = str.charCodeAt(i++) & 0xff;
                if (c4 == 61) {
                    return out;
                }
                c4 = decodeChars[c4];
            } while (i < len && c4 == -1);
            if (c4 == -1) {
                break;
            }
            out.writeByte(((c3 & 0x03) << 6) | c4);
        }
        return out;
    }


    /* utils*/
    private static function getClassByObject(o:*):Class{
        return  getClassByName(getQualifiedClassName(o));
    }

    private static function getClassByName(className : String) : Class {
        var c : Class;
        c = getDefinitionByName(clearClassName(className))as Class;
        return c;
    }

    private static function getNameClass(o:*):String{
        return clearClassName(getQualifiedClassName(o));
    }

    private static function clearClassName(name:String):String{
        if(name)
            return name..split("::").join(".").replace("__AS3__.vec.","")
        else{
            return "Object"
        }
    }

    private static function generateIndex():String{
        indexCounter++;
        return indexCounter.toString();
    }




}


}
