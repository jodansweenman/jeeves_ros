// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 19-2: Simple therapy client

// Import the net libraries
import processing.net.*;
// Import the serial library
import processing.serial.*;
// Declare a client
Client client;

// Declare a serial port
Serial myPort;

// Used to indicate a new message
float newMessageColor = 0;
// A String to hold whatever the server says
String messageFromServer = "";
// A String to hold what the user types
String typing ="";

PFont f;

void setup() {
  size(400,200);
  // Create the Client, connect to server at 127.0.0.1 (localhost), port 5204
  client = new Client(this,"127.0.0.1", 80);
  f = createFont("Arial",16,true);
  client.write("iam:body");
  // Instantiate a serial port
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(255);
  
  // Display message from server
  fill(newMessageColor);
  textFont(f);
  textAlign(CENTER);
  text(messageFromServer,width/2,140);
  
  // Fade message from server to white
  newMessageColor = constrain(newMessageColor+1,0,255); 
  
  // Display Instructions
  fill(0);
  text(" Type text and hit return to send to server. ",width/2,60);
  // Display text typed by user
  fill(0);
  text(typing,width/2,80);
  
  // If there is information available to read
  // (we know there is a message from the Server when there are greater than zero bytes available.)
  if (client.available() > 0) { 
    // Read it as a String
    messageFromServer = client.readString();
    // Set brightness to 0
    newMessageColor = 0;
    
    parseMessage(messageFromServer);
  }
}

void parseMessage(String msg) {
  String [] message = split(msg,':');
  String sender, target, command;
  if (message.length == 3 && message[1].equals("body")) {
    
    sender = trim(message[0]);
    target = trim(message[1]);
    command = trim(message[2]);
    
    String client_msg = "msg:OK. I received a command " +command.toUpperCase() + " from " + message[0].toUpperCase();
    //client.write(client_msg);
    println(client_msg);
    
    // DEBUGGING STUFF
    /*
    //println(message.length);
    //println(target);
    //println(command);
    for (int i = 0; i<message.length; i++) {
      println(message[i]);      
    }
    */
    // END OF DEBUGGING STUFF 
    print("Command to execute: ");
    if (command.equals("left")) {
      myPort.write('K');
      println("LEFT");
    } else if (command.equals("right")) {
      myPort.write('J');
      println("RIGHT");
    } else if (command.equals("down")) {
      //myPort.write('L');
      println("DOWN");
    } else if (command.equals("wave")) {
      //myPort.write('W');
      println("WAVE");
    } else if (command.equals("dance")) {
      //myPort.write('W');
      println("DANCE");
      delay(3000);
      client.write("msg:I'm dancing...");      
      dance();
    } else { // Default position
      myPort.write('H');
      println("UPRIGHT");
    }
  } else {
    println("Message length is: " + message.length);
    println(msg);
    //target = trim(message[0]);
    //command = trim(message[1]);
  }
  
}

void dance() {
  myPort.write('B');
  delay(1500);
  myPort.write('J');
  delay(1500);
  myPort.write('F');
  delay(1500);
  myPort.write('K');
   
  delay(3000);
  client.write("msg:OK. I'm done dancing.");
}

// Simple user keyboard input
void keyPressed() {  
  // If the return key is pressed, save the String and clear it
  if (key == '\n') {
    // When the user hits enter, write the sentence out to the Server
    client.write(typing); // When the user hits enter, the String typed is sent to the Server.
    typing ="";
  } else {
    typing = typing + key;
  }
}
