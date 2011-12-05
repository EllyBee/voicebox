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

boolean recording = false;

void setup() {

  size(200, 200);

  //create and open a serial port
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  
  
}


////// CREATE NEW FILE ////////

int countname; 
int name = 0;

void newFile() {

  //increament the naming of the sound file.
  countname = (name + 1); 
  println("just created new file " + countname + ".ogg");
}





