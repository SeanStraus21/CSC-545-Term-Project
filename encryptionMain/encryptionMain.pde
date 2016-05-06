/**
Test framework for the imageToImageEncrypt function

Set bitThreshold to modify the compression level of the hidden image
A higher bitThreshold will lead to noticeable distortions in the output
A lower bitThreshold will result in a heavily compressed version of the secret image
A bitThreshold outside the range [1,7] will be cropped by the encryption function

Use the number keys 0-3 to toggle the display
  0 = img1
  1 = img2
  2 = img1 hidden inside img2
  3 = img2 hidden inside img1
*/

PImage img1, img2, currentImage, img3, img4;
int bitThreshold = 4;

void setup(){
  size(400,400);
  background(0);
  img1 = loadImage("img1.jpg");
  img2 = loadImage("img2.jpg");
  img3 = imageToImageEncrypt(img1,img2,bitThreshold);
  img4 = imageToImageEncrypt(img2,img1,bitThreshold);
  currentImage = img1;
}

void draw(){
  image(currentImage,0,0);
}


void keyPressed() {
  if (key == '0') currentImage = img1;
  if (key == '1') currentImage = img2;
  if (key == '2') currentImage = img3;
  if (key == '3') currentImage = img4;
}