long sum;
long inDot;
float dotSize = 10;

void setup(){
  rotate(PI / 2);
  size(1600, 1000);
  translate(0,-1600);
  background(255);
  sum = 0;
  fill(0);
  textSize(100);
  text("sum    = " + sum, 10, 1100);
  text("inDot  = " + inDot, 10, 1200);
  text("Pi        = ?", 10, 1300);
  strokeWeight(2);
  stroke(0);
  line(0,1000,1000,1000);
  line(0,0,0,1600);

}

void keyPressed() {
  // scape key(Reset)
  if(key == ' '){
    pushMatrix();
    
    rotate(PI / 2);
    translate(0,-1600);
    background(255);
    sum = 0;
    stroke(0);
    strokeWeight(2);
    line(0,1000,1000,1000);
    line(0,0,0,1600);
    textSize(100);
    text("sum   = " + sum, 10, 1100);
    text("inDot = " + inDot, 10, 1200);
    text("Pi       = ?", 10, 1300);
    
    popMatrix();
  }
  if(key == 'a'){
    RandomDotPut(1);
  }
  if(key == 's'){
    RandomDotPut(10);
  }
  if(key == 'd'){
    RandomDotPut(100);
  }
  if(key == 'f'){
    RandomDotPut(1000);
  }
  if(key == 'g'){
    RandomDotPut(10000);
  }
  if(key == ENTER){
    save("Monte-Carlo_dotPoint("+ sum + ").png");
  }
}

void draw(){
}

void RandomDotPut(int a){
  pushMatrix();
  
  rotate(PI / 2);
  translate(0,-1600);
  int i;
  float x, y;

  for(i=0; i<a; i++){
    x = random(1000);
    y = random(1000);
    strokeWeight(dotSize);
    
    if(sq(x) + sq(y) <= 1000000){
      stroke(255, 0, 0);
      inDot ++;
    }
    else{
      stroke(0);
    }
    point(x, y);
  }
  fill(255);
  stroke(0);
  strokeWeight(2);
  rect(0,1000,1000,600);
  sum += a;
  fill(0);
  textSize(100);
  text("sum   = " + sum, 10, 1100);
  text("inDot = " + inDot, 10, 1200);
  text("Pi       = " + 4.0 * inDot / sum, 10, 1300);
  textSize(70);
  text("(dotSize = " + dotSize + ")", 10, 1500);
  
  popMatrix();
}
