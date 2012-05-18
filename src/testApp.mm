#include "testApp.h"
ofImage myImage1;
ofImage myImage2;
ofImage myImage3;
ofImage myImage4;
ofImage myImage5;
ofImage myImage6;
ofImage myImage7;
ofImage myImage8;
ofImage myImage9;
ofImage myImage10;
ofImage myImage11;
ofImage myImage12;
ofImage myImage13;
ofImage myImage14;


float volume;
float * inputBufferCopy;

float frameRateForCapture;  
float lastTime;  
float timerDuration;

int stepper;

int noOfElements;


int brightnessMultiplier;


//--------------------------------------------------------------
void testApp::setup(){

	ofRegisterTouchEvents(this);
    
    
	
    myImage1.loadImage("Compact-Fluorescent-Bulb layered1.png");
    myImage2.loadImage("Compact-Fluorescent-Bulb layered2.png");
    
    myImage3.loadImage("M-neon-layered0.png");
    myImage4.loadImage("M-neon-layered1.png");
    
    myImage5.loadImage("LED-spotlight-layered1.png");
    myImage6.loadImage("LED-spotlight-layered2.png");
    
    myImage7.loadImage("Solar-eclipse-layered0.png");
    myImage8.loadImage("Solar-eclipse-layered1.png");
    
    
    myImage9.loadImage("Old-Incandescend-bulb-layered1.png");
    myImage10.loadImage("Old-Incandescend-bulb-layered2.png");
    
    myImage11.loadImage("Cat-eye-layered0.png");
    myImage12.loadImage("Cat-eye-layered1.png");
    
    myImage13.loadImage("Earth-night-layered0.png");
    myImage14.loadImage("Earth-night-layered1.png");
    
    
    lastTime = ofGetElapsedTimef();  
    frameRateForCapture = 60; // 30 fps 
    timerDuration = 10.0;  
    noOfElements = 7;
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];  
    
    
    stepper = 2 * (arc4random_uniform (noOfElements) );  //stepper can be either 0, 2, 4, 6
    //a = (2 * rand ()) %6;  //random numbers from set of 2, 4, 6, 8, 10
    
     NSLog(@"stepper is %i", stepper);
    
    
    brightnessMultiplier = 1200;
    
    
    allImages = new ofImage[14];
    allImages[0] = myImage1;
    allImages[1] = myImage2;
    allImages[2] = myImage3;
    allImages[3] = myImage4;
    allImages[4] = myImage5;
    allImages[5] = myImage6;
    allImages[6] = myImage7;
    allImages[7] = myImage8;
    allImages[8] = myImage9;
    allImages[9] = myImage10;
    allImages[10] = myImage11;
    allImages[11] = myImage12;
    allImages[12] = myImage13;
    allImages[13] = myImage14;
    
    
    
    
    images = new ofImage[2];

    images[0] =  allImages[stepper];
    stepper++;
    images[1] =  allImages[stepper];
    
     NSLog(@"stepper is %i", stepper);
    

    
    
	ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_PORTRAIT);
    
	ofBackground(255,255,255);
    
	initialBufferSize	= 512;
	sampleRate 			= 44100;
	drawCounter			= 0;
	bufferCounter		= 0;
	
	buffer				= new float[initialBufferSize];
	memset(buffer, 0, initialBufferSize * sizeof(float));
    
	// 0 output channels,
	// 1 input channels
	// 44100 samples per second
	// 512 samples per buffer
	// 4 num buffers (latency)
	ofSoundStreamSetup(0, 1, this, sampleRate, initialBufferSize, 4);
	ofSetFrameRate(60);
}

//--------------------------------------------------------------
void testApp::update()
{
    
    float currentTime = ofGetElapsedTimef();  
    if (currentTime - lastTime > timerDuration){  
        // DO SOMETHING HERE  
        NSLog(@"10 seconds now");
        NSLog(@"stepper is %i", stepper);
        
        stepper = 2 * (arc4random_uniform (noOfElements) ); //stepper can be either 0, 2, 4, 6
        NSLog(@"stepper is %i", stepper);

        images[0] =  allImages[stepper];
        stepper++;
         NSLog(@"stepper is %i", stepper);
        images[1] =  allImages[stepper];
      
        lastTime = currentTime;  
    }  

}

//--------------------------------------------------------------
void testApp::draw(){
	//ofTranslate(0, 0, 0);
    ofBackground(0, 0, 0);
    ofEnableAlphaBlending();
    
  // NSLog(@"volume is %f", volume*100);
    
      
    ofSetColor(255, 255, 255, volume*brightnessMultiplier);
    images[0].draw(0,0);
    
    if(volume*100 > 15)
    {
        //NSLog(@"here");
        ofSetColor(255, 255, 255, 255);
       images[1].draw(0,0);
    }
}






void testApp::audioIn(float * input, int bufferSize, int nChannels){
    
    
    
    
	if( initialBufferSize != bufferSize ){
		ofLog(OF_LOG_ERROR, "your buffer size was set to %i - but the stream needs a buffer size of %i", initialBufferSize, bufferSize);
		return;
	}	
	
    // memcpy(inputBufferCopy, input, bufferSize * nChannels * sizeof(float));
    volume = 0; // set the volume to zero
    
	// samples are "interleaved"
	for (int i = 0; i < bufferSize*nChannels; i++){
        volume += input[i]*input[i]; // add the squared value to eliminate any negative values
	}
    volume /= bufferSize*nChannels; // get the average of all the squared values added up
    volume = sqrt(volume); // finally take the square root of that value
    
}




//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
	
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs& args){

}

