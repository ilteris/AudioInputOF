#include "testApp.h"
ofImage myImage;
float volume;
float * inputBufferCopy;


//--------------------------------------------------------------
void testApp::setup(){

	ofRegisterTouchEvents(this);
	
    myImage.loadImage("Compact-Fluorescent-Bulb.png");
    
	
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
void testApp::update(){

}

//--------------------------------------------------------------
void testApp::draw(){
	//ofTranslate(0, 0, 0);
    ofBackground(0, 0, 0);
    ofEnableAlphaBlending();
    
   // NSLog(@"volume is %f", volume*100);
    
    
    ofSetColor(255, 255, 255, volume*1000);
    myImage.draw(0,0);

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

