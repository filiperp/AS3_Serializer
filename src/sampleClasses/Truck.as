/**
 * Created with IntelliJ IDEA.
 * User: filiperp
 * Date: 30/11/12
 * Time: 10:36
 * To change this template use File | Settings | File Templates.
 */
package sampleClasses {
import flash.utils.Dictionary;

public class Truck extends Car{
    public var numberTyres:int;
    public static var TEST1:String;
    public static var TEST2:String;
    public static var TEST3:String;
    public var size:Number;
    public var carReference:Car;
    public var extras:Object;
    public var dataTeste:Date;
    public var pieces:Vector.<Piece>;
    public var theDic:Dictionary= new Dictionary();
    public var theArray:Array= new Array();
    public function Truck() {
        //dumb data....
        carReference= new Car();
        pieces= new Vector.<Piece>();
        this.numberTyres= Math.random()*10000;
        this.size= Math.random()*45.37;
        this.extras =  {};
        extras.colors =  { 1992:"asdasd",1993:"adfadfadf", objects:{ theNome:"adfadfadf"} };
        extras.bona= "blah balhblaha";
        for (var i:int = 0; i < 10; i++) {
            var o:Piece = new Piece();
            pieces.push(o);

        }
        //this part is for tests with the same reference vars
        pieces.push(o);
        pieces.push(o);
        pieces.push(o);
        pieces.push(o);
        pieces.push(o);

        theDic[1]= new Piece();
        theDic["dracula"]= new Car();

        theArray.push( "iabadabadooo");
        theArray.push( "134");
        theArray.push( 1234);
        dataTeste= new Date();
    }
}
}
