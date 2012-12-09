# [AS3_Serializer]

## explain

This class helps the AS# developers to serialize complex typed objects and return the object  to the original structure.

## example:

Consider this class:
```
public class Person {
	public var eye:Eye;
	public var born :Date;
	public var extas:Object;
	public var relatives:Vector.<Person>;
	public var courses:Dictionary;
	public var color:uint;
}
```

with de JSON or Base64 encoding, you lose the typed objects and the Dictionary and Vector Content returns null after the deserialization:

```
var p:Person= new Person();
var jsonPerson = JSON.encode(p);
var p2:Person = JSON.decode(jsonPerson);//ERROR: can't convert Object in Person!!!!!

var p3:Person = new Person();
var b64:String= base64Encode(p);
var p4:Person = base64Decode(b64); ////ERROR: can't convert Object in Peron!!!!!
```
# see it running
this tool let you create your data objects, serialize and deserialize without problems.

Please get the code and read the explained source Main.as

thank you..


   