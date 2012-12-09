/**
 * Created with IntelliJ IDEA.
 * User: filiperp
 * Date: 30/11/12
 * Time: 11:36
 * To change this template use File | Settings | File Templates.
 */
package sampleClasses {
public class Piece {
    public var theName:String;
    public var price:Number;
    public function Piece() {
        theName =  (Math.random()*300).toString();
        price = Math.random()*200;
    }
}
}
