/**
imageToImageDecrypt:  Outputs a hidden image from the provided image,
  using the given parameters for the hidden dimensions and bit threshold.
Programmer:  Noah Bumgardner
Last Modified By:  2016-05-08
Image Quality:  The 'hiddenBitCount' lowest bits from each pixel of the
  provided image become the highest 'hiddenBitCount' bits in each pixel of
  the hidden image output. In general, the higher the 'hiddenBitCount', the
  more noticeable the distortion in the provided image and the higher
  quality of the hidden image.
Inputs:  Hidden image's width and height are limited to be within the
  provided image's dimensions. 'hiddenBitCount' is set within [1, 7].
  Hidden image is assumed to begin from the top-left corner of the
  provided image.
*/
PImage imageToImageDecrypt(PImage img,
    int widthSecret, int heightSecret, int hiddenBitCount) {
  PImage output;
  color Pc,Ps,P; // TODO: Reduce
  int Rc,Gc,Bc,Rs,Gs,Bs,R,G,B; // TODO: Reduce

  // Constrain variables to valid ranges.
  hiddenBitCount = constrain(hiddenBitCount, 1, 7);
  widthSecret = constrain(widthSecret, 0, img.width);
  heightSecret = constrain(heightSecret, 0, img.height);

  // Prepare and load images.
  output = new PImage(widthSecret, heightSecret);
  img.loadPixels();
  output.loadPixels();

  for (int y = 0; y < heightSecret; y++) {
    for (int x = 0; x < widthSecret; x++) {
      // TODO: INSERT CODE HERE
      // Get pixel from img pixel
      // Get RGB values from pixel
      // Extract hidden R, G, and B values from original
      // Combine hidden RGB into hidden color
      // Set hidden pixel of output.
      ;
    }
  }

  return output;

  /*
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
  */
}


int promoteBits(int c, int bitsToKeep) {
  /*
  Left shift the 'bitsToKeep' bits on the right side
    into the leading bits followed by zeroes.
  Examples x3:
  >>> promoteBits(1, 2);
  01000000
  >>> promoteBits(255, 3);
  11100000
  >>> promoteBits(253, 7);
  11111010
  */
  return c << (8 - bitsToKeep);
}