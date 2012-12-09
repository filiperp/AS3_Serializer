/**
 * Created with IntelliJ IDEA.
 * User: filiperp
 * Date: 30/11/12
 * Time: 10:29
 * To change this template use File | Settings | File Templates.
 */
package {

import com.adobe.serialization.json.JSON;
import com.demonsters.debugger.MonsterDebugger;
import com.demonsters.debugger.MonsterDebugger;

import flash.display.MovieClip;
import flash.display.Shape;
import flash.utils.describeType;
import flash.utils.getTimer;
import flash.utils.setTimeout;
import flash.xml.XMLNode;

import sampleClasses.Piece;
import sampleClasses.Truck;

import utils.serialization.SrlzrController;

import utils.serialization.SrlzrController;

public class Main extends MovieClip {
    var t:Truck;
    var t2:Truck;


    public function Main() {
         MonsterDebugger.initialize(this);
        MonsterDebugger.clear();
        // Creating a sample object.
        // Please verify the Truck, car and Piece Properties.
        t =  new Truck();



        //now, you have some ways to serialize  the srlzblObj
        /*----------------------------------------------------------------------------*/
        //1 WAY
        //if you want extremely compression, but the object can't be converted in PHP.

        //GO TO SERIALIZED
        //creating de serializable Object
        var srlzblObj1:Object    = SrlzrController.convertToSerializableObject(t);

        // converting to Json
        var json1go:String    = JSON.encode(srlzblObj1);

        //the way1String is the object serializaded, you can send to the database =)
        var way1String:String = SrlzrController.compress(json1go);



        //GOING BACK TO THE ORIGINAL OBJECT
        //going back  the JSON
        var jsonWay1Back:String =  SrlzrController.decompress(way1String);

        //recreating the serializable Object
        var objWay1Back:Object = JSON.decode(jsonWay1Back);

        //recreating the Truck
        var truckWay1:Truck = SrlzrController.convertToOriginalObject(objWay1Back);



        /*-------------------------------------------------------------------------------*/

        //2 WAY
        //if you need convert the object in PHP for some tricks.
        //the size is not too optimized =(


        //GO TO SERIALIZED
        //creating de serializable Object
        var srlzblObj2:Object    = SrlzrController.convertToSerializableObject(t);

        // converting to Json
        var json2go:String    = JSON.encode(srlzblObj2);

        //the way2String is the object serializaded, you can send to the database =)
        //use de base64 PHP functions for create a object trough the way2String
        var way2String:String = SrlzrController.base64EncodeString(json2go);



        //GOING BACK TO THE ORIGINAL OBJECT
        //going back  the JSON
        var jsonWay2Back:String =  SrlzrController.base64DecodeString(way2String);

        //recreating the serializable Object
        var objWay2Back:Object = JSON.decode(jsonWay2Back);

        //recreating the Truck
        var truckWay2:Truck = SrlzrController.convertToOriginalObject(objWay2Back);


        /*-------------------------------------------------------------------------------*/

        //3 WAY
        //if you can't use the as3corelib/
       // the size is not too optimized
        // you can't convert the object in PHP


        //GO TO SERIALIZED
        //creating de serializable Object
        var srlzblObj3:Object    = SrlzrController.convertToSerializableObject(t);

        //the way3String is the object serializaded, you can send to the database =)
        var way3String:String = SrlzrController.base64EncodeObject(srlzblObj3);



        //GOING BACK TO THE ORIGINAL OBJECT
        //recreating the serializable Object
        var objWay3Back:Object = SrlzrController.base64DecodeObject(way3String);

        //recreating the Truck
        var truckWay3:Truck = SrlzrController.convertToOriginalObject(objWay3Back);




       MonsterDebugger.trace('truck  ', t) ;
       MonsterDebugger.trace('truck 1 ', truckWay1) ;
       MonsterDebugger.trace('truck 2 ', truckWay2) ;
       MonsterDebugger.trace('truck 3 ', truckWay3) ;



    }
}
}
