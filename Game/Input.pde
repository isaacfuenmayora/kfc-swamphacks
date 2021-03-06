byte input = 0;
byte previousInput = 0;
byte lastOne = 0;
byte lastTwo = 0;

public byte getInput(int rotation){
  if(rotation < 0 || rotation > 3)
    throw new ArithmeticException("getInput() requires a number in the range [0,3]. Given: " + rotation);
  switch(rotation){
    case 0:
      return input;
    case 1: //rotate  90 deg
      return (byte)(( ((input<<1)|((input>>3)&1))&15)|(input&240));
    case 2: //rotate 180 deg
      return (byte)((((input<<2)|((input>>2)&3))&15)|(input&240));
    case 3: //rotate 270 deg
      return (byte)((((input<<3)|((input>>1)&7))&15)|(input&240));
  }
  return input;
}

void keyPressed() {
  if (key=='w' || (key == CODED && keyCode == UP)){
    input=(byte)(input|1);
    push();
  }
  if (key=='s' || (key == CODED && keyCode == DOWN)){
    input=(byte)(input|2);
    push();
  }
  if (key=='a' || (key == CODED && keyCode == LEFT)){
    input=(byte)(input|4);
    push();
  }
  if (key=='d' || (key == CODED && keyCode == RIGHT)){
    input=(byte)(input|8);
    push();
  }
  if (key==' '){
    input=(byte)(input|16);
  }
  if (key=='m'){
    input=(byte)(input|32);
  }
  if (key=='p'){
    input=(byte)(input|64);
  }
}

void keyReleased() {
  if (key=='w' || (key == CODED && keyCode == UP))
    input = (byte)(input&254);
  if (key=='s' || (key == CODED && keyCode == DOWN))
    input = (byte)(input&253);
  if (key=='a' || (key == CODED && keyCode == LEFT))
    input = (byte)(input&251);
  if (key=='d' || (key == CODED && keyCode == RIGHT))
    input = (byte)(input&247);
  if (key==' ')
    input = (byte)(input&239);
  if (key=='m')
    input = (byte)(input&223);
  if (key=='p')
    input = (byte)(input&191);
}

public void push(){
  if(lastOne == 0){
    lastOne = (byte)(input&15);
  } else if(lastTwo == 0 && (input&15)!=lastOne){
    lastTwo = (byte)(input&15);
  }
}

public byte poll(){
  byte temp = lastOne;
  lastOne = lastTwo;
  lastTwo = 0;
  return temp;
}

/*
        W     P            1     64
      A S D              2 4 8
      <SPACE> M             16   32
*/
