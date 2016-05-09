/*
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
PImage imageToImageDecrypt(PImage img, int widthSecret, int heightSecret,
                           int hiddenBitCount) {
  PImage output;
  color c;
  int indexImg, indexOutput;

  // Constrain variables to valid ranges.
  hiddenBitCount = constrain(hiddenBitCount, 1, 7);
  widthSecret = constrain(widthSecret, 0, img.width);
  heightSecret = constrain(heightSecret, 0, img.height);

  // Prepare and load images. Initialize
  output = new PImage(widthSecret, heightSecret);
  img.loadPixels();
  output.loadPixels();

  // Hold current indexes for pixels arrays.
  indexImg = 0;
  indexOutput = 0;

  // Decrypt hidden image from 'img' into 'output'.
  for (int y = 0; y < heightSecret; y++) {
    indexImg = y * img.width;
    for (int x = 0; x < widthSecret; x++, indexImg++, indexOutput++) {
      // Get pixel from img, decrypt pixel, then set pixel of 'output'.
      c = img.pixels[indexImg];
      c = decryptPixel(c, hiddenBitCount);
      output.pixels[indexOutput] = c;
    }
  }
  output.updatePixels();

  return output;
}

color decryptPixel(color c, int bitsToKeep) {
  int r, g, b;
  // Get RGB components.
  r = int(red(c));
  g = int(green(c));
  b = int(blue(c));
  // Shift 'bitsToKeep' right bits to the left side.
  r = promoteBits(r, bitsToKeep);
  g = promoteBits(g, bitsToKeep);
  b = promoteBits(b, bitsToKeep);
  // Output combined RGB values
  return color(r, g, b);
}

int promoteBits(int c, int bitsToKeep) {
  /*
  Inputs:   'c' is used as an 8-digit binary number.
            'bitsToKeep' is expected to be a positive integer.
  Output:   8-digit binary number.
  Process:  Using 'c' as an 8-digit binary number, it shifts the
              'bitsToKeep' rightmost bits into the leftmost bits
              of an eight-digit binary number. Followed by
              trailing zeroes.
  Examples x3:
  >>> promoteBits(1, 2);
  64
  (01000000 in binary)

  >>> promoteBits(255, 3);
  224
  (11100000 in binary)

  >>> promoteBits(253, 7);
  250
  (11111010 in binary)
  */
  return 255 & (c << (8 - bitsToKeep));
}