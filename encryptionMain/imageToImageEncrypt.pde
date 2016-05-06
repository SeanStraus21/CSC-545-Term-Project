/**
Image to Image Encryption
  Takes a cover image, a secret image, and a bit threshold as parameters
returns an image in which the X lower bits of the cover image are replaced 
with the higher order bits of the secret image, where X is the bit threshold.
  In general, the higher the bit threshold, the more noticeable the distortion in
the output will be, but the less compressed the secret image will be
  If the dimensions of the two input images are not identical, the output will 
use the smaller dimensions of both images
  The bit threshold will be cropped to the range [1,7] if it falls outside of it. 
*/
PImage imageToImageEncrypt(PImage imgSecret, PImage imgCover, int hiddenBitCount){
  int w,h;
  //ensure hiddenBitCount is in range [1,7]
  if (hiddenBitCount < 1){
    hiddenBitCount = 1;
  }else if(hiddenBitCount > 7){
    hiddenBitCount = 7;
  }
  //ensure output dimensions do not exceed those of either input image
  if(imgSecret.width < imgCover.width){
    w = imgSecret.width;
  }else{
    w = imgCover.width;
  }
  if(imgSecret.height < imgCover.height){
    h = imgSecret.height;
  }else{
    h = imgCover.height;
  }
  
  PImage output = new PImage(w,h);
  int Rc,Gc,Bc,Rs,Gs,Bs,R,G,B;
  color Pc,Ps,P;
  
  for(int i=0;i<output.height;i++){
    for(int j=0;j<output.width;j++){
      //get colors from cover image pixel
      Pc = imgCover.get(j,i);
      Rc = round(red(Pc));
      Gc = round(green(Pc));
      Bc = round(blue(Pc));
      
      //get colors from secret image pixel
      Ps = imgSecret.get(j,i);
      Rs = round(red(Ps));
      Gs = round(green(Ps));
      Bs = round(blue(Ps));
      
      //imbed the secret image pixel in the cover image pixel
      R = bitEncrypt(Rs,Rc,hiddenBitCount);
      G = bitEncrypt(Gs,Gc,hiddenBitCount);
      B = bitEncrypt(Bs,Bc,hiddenBitCount);
      
      P = color(R,G,B);
      
      output.set(j,i,P);
    }
  }
  
  return output;
}

/**
Shift the bits of two 8bit color values and return an 8bit color value
in which the lower order bits of the cover value are replaced with the 
higher order bits of the secret value
*/
int bitEncrypt(int s, int c, int secretBitCount){
  int sShift,cShift,sMask,cMask,coverBitCount;
  coverBitCount = 8 - secretBitCount;
  sMask = 255 >> coverBitCount;
  cMask = 255 << secretBitCount;
  
  cShift = c & cMask;
  sShift = (s >> secretBitCount) & sMask;
  
  return cShift+sShift;
}