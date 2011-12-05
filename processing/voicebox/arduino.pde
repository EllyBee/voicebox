void draw() {
  
  //text("Not recording.", 5, 15);

  //GET SERIAL INPUT FROM ARDUINO

  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();         // read it and store it in val
  }


  ///-----------


  //IF ARDUINO INPUT IS RECIEVED
  if (val == 0) {         

      //ignore for first two times - let hardware settle.
     if (counter>2) {

      if (inputReceived == false) {

        //set input received as true.
        inputReceived = true;

        println("input received");

        //start recording
        executeCmd();
      }
    }
    
     counter++;
  }
  
 //--------------
  
/////////// TIMER STUFF TO RESET LISTENERS TO DETECT INPUT FROM ARDUINO   ///////////

if(inputReceived == true && timer == false){
   
    starttime = millis();
    timer = true;
}
  
// check the timer and reset values if 5 seconds have passed
if (inputReceived == true && millis() - starttime >= delaytime ) { 
   
         
          println("time's up");
          
          inputReceived = false;
          timer = false;
          
          
 }  
 else { 
  
 } 
   
   
  
}

