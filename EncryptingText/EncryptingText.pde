/*
The idea would be to have the first 
pixel of the image hold the size of
the message. Then based on picture 
size and message length, every nth pixel will have a 
change to the b value based on ascii 
value of text to input. will use lower 5 bits for 
storing message. 
*/

/*
This array holds all letter options for message. Each index corresponds to the bit
number which will modify the blue value.
*/
import java.util.*;
//Map letterkey=new HashMap();
////letterkey.put('1','a');
char[] letterkey={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q',
                    'r','s','t','u','v','w','x','y','z','.',',','?','!',' ','\''};
                   
String hiddenMsg="This is a hidden message."; //actually will get input from user

PImage img, currImg;

void setup(){
  size(600,600);
  surface.setResizable(true);
  img=loadImage("hot_air.jpg");
  currImg=img;
  surface.setSize(img.width,img.height);
}
void draw(){
  //hideMessage();
  image(currImg,0,0);
}
PImage hideMessage(PImage img){
  PImage currImg;
  currImg=img.get();
  currImg.loadPixels();
  //int c=img.pixels[0];
  int messageLength=hiddenMsg.length();
  //calculate the interval to use for storing pixels
  int interval=currImg.pixels.length/messageLength;
  int messageIndex=0;
  for(int i=0; i<currImg.pixels.length; i+=interval){
    //get the color from the picture;
    int c=currImg.pixels[i];
    println("color before: "+ c);
    int b=c & 0xFF; //get blue value from c
    //remove blue value from c
    c=c-b;
    //below is the same as bitwise & operation of 11111111 & 11100000,which keeps upper 3 bits
    b=b&224; //take blue value and keep upper 224 (upper 3 bits) but remove last five bits
    //get char
    char curChar=hiddenMsg.charAt(messageIndex);
    //switch char to lowercase
    curChar=Character.toLowerCase(curChar);

    //change from ascii value to indexed value
    int keyValue;
    if(curChar==46)//if it's a period
      keyValue=26;
    else if(curChar==44)
       keyValue=27;
    else if(curChar==63)//if it's a question mark
      keyValue=28;
    else if(curChar==33)//exclamation point
      keyValue=29;
    else if(curChar==32)//space
      keyValue=30;
    else if(curChar==34||curChar==39)//quotation ' or "
      keyValue=31;
    else
      keyValue=int(curChar)-97;

    //now add message to last bits
    b=b|keyValue;

    //add modified b value to c
    c=c+b;
    println("color after: "+c);
    //set pixel at interval location to altered color
    currImg.pixels[i]=c;
    messageIndex++;
  }
  return currImg;
}
void keyReleased(){
  if(key=='1'){
    currImg=img;
  }
  else if(key=='2'){
    currImg=hideMessage(img);
  }
}