PImage img1, img2, currentImage, img3, img4;

void setup(){
  size(400,400);
  background(0);
  img1 = loadImage("img1.jpg");
  img2 = loadImage("img2.jpg");
  img3 = imageToImageEncrypt(img1,img2,4);
  img4 = imageToImageEncrypt(img2,img1,4);
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