PImage imageToImageEncrypt(PImage imgSecret, PImage imgCover, int hiddenBitCount){
  int w,h;
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
  for(int i=0;i<output.width;i++){
    for(int j=0;j<output.height;j++){
      Pc = imgCover.get(j,i);
      Rc = round(red(Pc));
      Gc = round(green(Pc));
      Bc = round(blue(Pc));
      
      Ps = imgSecret.get(j,i);
      Rs = round(red(Ps));
      Gs = round(green(Ps));
      Bs = round(blue(Ps));
      
      R = bitEncrypt(Rs,Rc,hiddenBitCount);
      G = bitEncrypt(Gs,Gc,hiddenBitCount);
      B = bitEncrypt(Bs,Bc,hiddenBitCount);
      
      P = color(R,G,B);
      
      output.set(j,i,P);
    }
  }
  return output;
}

int bitEncrypt(int s, int c, int secretBitCount){
  int sShift,cShift,sMask,cMask,coverBitCount;
  coverBitCount = 8 - secretBitCount;
  sMask = 255 >> coverBitCount;
  cMask = 255 << secretBitCount;
  
  cShift = c & cMask;
  sShift = (s >> secretBitCount) & sMask;
  
  return cShift+sShift;
}