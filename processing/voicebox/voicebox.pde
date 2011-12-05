import processing.serial.*;

//serial communication between arduino stuff
Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port
boolean inputReceived = false;
int counter = 0;
//-


//Timer stuff
boolean timer = false;
int starttime; 
int delaytime = 5000; // delay in milliseconds 
//--


//variables unique to each box
String boxName = "sdldn_";
String currentDate;
//-

boolean recording = false;

void setup() {

  size(200, 200);

  //create and open a serial port
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  
    
}


////// CREATE NEW FILE ////////

void newFile() {
  
  String y = String.valueOf(year());
  String m = String.valueOf(month());
  String d = String.valueOf(day());
  String h = String.valueOf(hour());
  String mi = String.valueOf(minute());
  String s = String.valueOf(second());
  String mil = String.valueOf(millis());
 
 currentDate = y + m + d + h + mi + s + mil; 
 print(currentDate);

//filename made up of current date and time and box location. - This means filename is always unique.
  println("just created new file "+ boxName + currentDate +".ogg");
}





