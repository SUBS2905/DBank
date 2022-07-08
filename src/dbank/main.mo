import Debug "mo:base/Debug"; //module that contains the print statement
import Time "mo:base/Time";
import Float "mo:base/Float";


actor DBank{
  stable var currentValue: Float = 400;
  // currentValue := 400; //Change variable value
  Debug.print(debug_show(currentValue));
  
  //Time in nanoseconds since 01/01/1970
  stable var startTime = Time.now();
  // startTime := Time.now();
  Debug.print(debug_show(startTime));

  // let id = 123456789; //it is a constant

  //print only takes text as input
  // Debug.print(debug_show(id)); 

  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float) {
    let tempValue: Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Amount too large, currentValue less than zero.")
    }
  };

  public query func checkBalance(): async Float{
    return currentValue;
  };

  public func compound(){
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS/1000000000;
    //compounding with 1% for each second
    currentValue := currentValue*(1.01**Float.fromInt(timeElapsedS));

    startTime := currentTime;
  };

}
