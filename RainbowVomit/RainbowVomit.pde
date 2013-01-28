//
// a template for receiving face tracking osc messages from
// Kyle McDonald's FaceOSC https://github.com/kylemcdonald/ofxFaceTracker
//
// 2012 Dan Wilcox danomatika.com
// for the IACD Spring 2012 class at the CMU School of Art
//
// adapted from from Greg Borenstein's 2011 example
// http://www.gregborenstein.com/
// https://gist.github.com/1603230
//
import codeanticode.syphon.*;
import oscP5.*;

SyphonClient client;
OscP5 oscP5;
float[] rawPoints = new float[131];
float cWidth; 
float cHeight; 
PImage img;

// num faces found
int found;

// pose
float poseScale;
PVector posePosition = new PVector();
PVector poseOrientation = new PVector();

// gesture
float mouthHeight;
float mouthWidth;
float eyeLeft;
float eyeRight;
float eyebrowLeft;
float eyebrowRight;
float jaw;
float nostrils;


public class Vomit
{
  PVector [] topEdge = new PVector[4];
  int length = 0;
}


void setup() {
  size(640, 480, P3D);
  background (random (256), random (256), 255, random (256));
  smooth();
  frameRate(30);

  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "rawDataReceived", "/raw");
  
  client = new SyphonClient(this, "FaceOSC");
}

void draw() {  
  if (client.available()) 
  {
    // The first time getImage() is called with 
    // a null argument, it will initialize the PImage
    // object with the correct size.
    //img = client.getImage(img); // load the pixels array with the updated image info (slow)
    img = client.getImage(img, false); // does not load the pixels array (faster)
    image(img,0,0);
    //background(255,0,0,0);
    if(found > 0) {
      float lastNum = 0; 
      int Idx = 0; 
    
      beginShape();
      noStroke();
      fill(255,255,255);
      //1
      vertex(rawPoints[96],rawPoints[97]);
      //4
      vertex(rawPoints[120],rawPoints[121]);
      //2
      vertex(rawPoints[122],rawPoints[123]);
      //3
      vertex(rawPoints[124],rawPoints[125]);
      //7
      vertex(rawPoints[108],rawPoints[109]); 
      //6
      vertex(rawPoints[126],rawPoints[127]);
      //5
      vertex(rawPoints[128],rawPoints[129]);
      //1
      vertex(rawPoints[118]+6,rawPoints[119]-4);
  
      endShape(CLOSE); 
  
      if (dist(rawPoints[122], rawPoints[123], rawPoints[128], rawPoints[129]) < 5)
      {
        println ("!!!!!");
      }
  
   // ellipse (rawPoints[130],rawPoints[131], 2,2);  
   
     
    }
    else
    {
      println ("not found");
    }
  }
}

void mousePressed() {
  background (random (256), random (256), 255, random (256));
}


// OSC CALLBACK FUNCTIONS

public void found(int i) {
  println("found: " + i);
  found = i;
}

public void rawDataReceived(float [] f){
    for (int i = 0; i < f.length; i++)
    {
      rawPoints[i] = f[i];
    }
}

// all other OSC messages end up here
void oscEvent(OscMessage m) {
  if (m.isPlugged() == false) {
    println("UNPLUGGED: " + m);
  }
}

