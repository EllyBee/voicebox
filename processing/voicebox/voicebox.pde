//import libraries for serial communication with arduino and recording sound input.
import processing.serial.*;
import ddf.minim.*;
//--

//sound record stuff
Minim minim;
AudioInput in;
AudioRecorder recorder;
boolean inputReceived = false;
//-

//Timer stuff
boolean timer = false;
int starttime; 
int delaytime = 5000; // delay in milliseconds 
//--

//serial communication between arduino stuff
Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port



void setup()
{
  size(512, 200, P2D);
  
  //create and open a serial port
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  
  //create new sound instance 
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 2048);
  //recorder = minim.createRecorder(in, "myrecording.wav", true);
  
  newFile();
  textFont(createFont("SanSerif", 12));
}


////// CREATE NEW FILE ////////

int countname; 
int name = 0;

void newFile(){
  
 countname = (name + 1); 
 recorder = minim.createRecorder(in, "testing" + countname + ".wav", true); 
 println("just created new file " + countname + ".wav"); 
}





void draw()
{
  background(0); 
  stroke(255);
  
 // Visualising microphone input
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }
  
//----------
  
  
//GET SERIAL INPUT FROM ARDUINO
  
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();         // read it and store it in val
  }
  
  
///-----------
 
  
//IF ARDUINO INPUT IS RECIEVED
if (val == 0) {            
    
          if(inputReceived == false){
                
                //set input received as true.
                inputReceived = true;
                
                print("input received");
                
                //start recording
                record();
    }
  } 
  
//--------------
  
/////////// TIMER STUFF TO STOP RECORD   ///////////

if(inputReceived == true && timer == false){
   
    starttime = millis();
    timer = true;
}
  
// check the timer and start if recording
if (inputReceived == true && millis() - starttime >= delaytime ) { 
   
          println("time's up");
          
          inputReceived = false;
          timer = false;
          
          stopRecord();
          saveFile();
 }  
 else { 
  
 } 
  
//// SET TEXT FIELD TO SHOW WHAT IS HAPPENING ////
  
  if ( recorder.isRecording() )
  {
    text("Currently recording...", 5, 15);
  }
  
  else
  {
    text("Not recording.", 5, 15);
  }
  
}


//////////////////////////////////// FUNCTIONS ///////////////////////////////////////


void record()
{
            
      newFile();
      
      recorder.beginRecord();
      
      println("started recording");
      println();

}

void stopRecord(){
  
  
      println("stopping recording");
      println();
      recorder.endRecord();
}

void saveFile(){
  
    recorder.save();
    println("Done saving.");
    name++;
  
}

void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();
  
  super.stop();
}

