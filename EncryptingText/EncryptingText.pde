/*
Size of message must be less than or equal to size of picture.
Then based on picture 
size and message length, every nth pixel will have a 
change to the b value based on ascii 
value of text to input. the first two pixels hold the
size of the message as well as a marker to make sure
there is a message.
a marker character is added to every message's end as well.
this provides double checking to make sure a message is actually present.
uses lower 5 bits for storing message.
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
                   

//int interval;
PImage img, currImg;
String fname="hot_air.jpg";

void setup(){
  size(600,600);
  surface.setResizable(true);
  img=loadImage(fname);
  currImg=img;
  surface.setSize(img.width,img.height);
  
}
void draw(){
  //hideMessage();
  image(currImg,0,0);
}
PImage hideMessage(PImage img, String hiddenMsg){
  PImage currImg;
  int interval;
  float check;
  currImg=img.get();
  currImg.loadPixels();
  int c=img.pixels[0];
  //add marker to end of message
  hiddenMsg+=".";

  //save message length
  int messageLength=hiddenMsg.length();
  //hide messageLength within first two pixels using g and b values
  //get r, g and b values from color
  int r=(c>>16)&0xFF;
  int g=(c>>8)& 0xFF;
  int b=c & 0xFF;
  //cut off last 5 bits (least significant ones)
  r=r&224;
  b=b&224;
  g=g&224;
  println(g);
  //place '.' marker in first pixel's r bits
  r=r|26;
  //take first 5 bits of value of messageLength and store in g value
  g=g|(messageLength & 0x1F);
  println(g);
  //take next 5 bits and store in b value
  b=b|((messageLength >>5)& 0x1F);
  //put back in c
  currImg.pixels[0]=color(r,g,b);
  //do again to hide most significant bits of messageLength in second pixel
  c=img.pixels[1];
  r=(c>>16)&0xFF;
  g=(c>>8)& 0xFF;
  b=c & 0xFF;
  //cut off last 5 bits (least significant ones)
  b=b&224;
  g=g&224;
  //take next 5 bits of value of messageLength and store in g value
  g=g|((messageLength>>10) & 0x1F);
  //take last 5 bits and store in b value
  b=b|((messageLength >>15)& 0x1F);
  //put back in c
  currImg.pixels[1]=color(r,g,b);
  
  
  //calculate the integer interval to use for storing characters in pixels
  interval=(currImg.pixels.length-2)/messageLength;
  //calculate the float value that corresponds to the interval
  check=(currImg.pixels.length-2.0)/float(messageLength);
  //if the decimal value of the number is less than .5 then take the ceiling
  if((check-interval)<.5){interval+=1;}
  println(interval);
  int messageIndex=0;
  int i=2;
  do{
  //for(int i=2; i<(currImg.pixels.length+interval+interval); i+=interval){
    //get the color from the picture;
    c=currImg.pixels[i];
    println("color before: "+ c);
    b=c & 0xFF; //get blue value from c
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
    check+=(currImg.pixels.length-2.0)/float(messageLength);
    i+=interval;
  }
  while(check<currImg.pixels.length && i<currImg.pixels.length);
  //update pixel array;
  currImg.updatePixels();
  return currImg;
}
String extractMessage(PImage currImg){
  String msg="";
  int messageLength;
  float check;
  int interval;
  int c, bits;
  int r,g,b;
  img.loadPixels();
  //extract message size from img
  
  //start with pixel holding most significant bits of messageLength
  c=currImg.pixels[1];
  //get last 5 bits of g and b values of c
  b=c&0x1F;
  g=(c>>8)&0x1F;
  println("most sig bits: g: "+g+", b: "+b);
  //add g and
  messageLength=b;
  //println(messageLength);
  messageLength=(messageLength<<5)+g;
  println(messageLength);
  //next do the same to add the least significant bits of messageLength
  c=currImg.pixels[0];
  b=c&0x1F;
  g=(c>>8)&0x1F;
  r=(c>>16)&0x1F;
  //check to make sure marker is in first pixel's r value. if not, return error message
  if(letterkey[r]!='.') return "Error: no message found.";
  else{
  println("least sig bits: g: "+g+", b: "+b);
  messageLength=(messageLength<<5)+b;
  messageLength=(messageLength<<5)+g;
  println(messageLength);
    //calculate the integer interval to use for storing characters in pixels
  interval=(currImg.pixels.length-2)/messageLength;
  //calculate the float value that corresponds to the interval
  check=(currImg.pixels.length-2.0)/float(messageLength);
  //if the decimal value of the number is less than .5 then take the ceiling
  println(check);
  if((check-interval)<.5){interval+=1;}
  println(interval);
  int i=2;
  do{
  //for(int i=2; i<img.pixels.length; i+=interval){
     c=currImg.pixels[i];
     bits=c&0x1F; //get last 5 bits of blue value from c (F corresponds to 4 bits and 1 to 1 bit
     //use bits to index letterkey and get character
    // print(letterkey[bits]);
     msg+=letterkey[bits];
     i+=interval;
     check+=(img.pixels.length-2.0)/float(messageLength);
  }
  while(check<img.pixels.length&&i<img.pixels.length);
  //if no period marker at end of message, return error message
  if(msg.charAt(msg.length()-1)!='.') return "Error: no message found";
  //otherwise return message
  return msg;
  }
}
  void keyReleased(){
    if(key=='1'){
      currImg=img;
    }
    else if(key=='2'){
      String hiddenMsg="This is a hidden"; //actually will get input from user
      currImg=hideMessage(img, hiddenMsg);
      //extractMessage(currImg);
    }
    else if(key=='3'){
      println(extractMessage(currImg));
    }
}
