int cycle = 100; // 1周期の時間(frame)
int mass = 1; // 直線の数
float tmp;
int countMax = 2; // そのmassでの繰り返し数上弦
int count = 0; //そのmassでの繰り返し数

float circleSize = 20; // 小さい動く円の大きさ
int timer = 0;

void setup(){
  size(900, 900);
  textSize(20);
  frameRate(50);
  
}

void draw(){
  background(180);
  int i;
  translate(0, 0);
  fill(0);
  text("line = " + mass, 10, 30);
  translate(width/2, height/2);
  fill(0);
  ellipse(0, 0, width*0.9, width*0.9);
  
  
  for(i=0; i<mass; i++){
    stroke(200);
    line(width*0.45*sin(i*PI/mass), width*0.45*cos(i*PI/mass),
         -width*0.45*sin(i*PI/mass), -width*0.45*cos(i*PI/mass)); 
  }
  
  fill(255, 0, 0);
  for(i=0; i<mass; i++){
    ellipse(cos(2*PI*timer/cycle + PI*i/mass)*width*0.45*sin(i*PI/mass) 
           ,-cos(2*PI*timer/cycle + PI*i/mass)*width*0.45*cos(i*PI/mass)
           , circleSize, circleSize);
      }
  
  timer ++;
  if(timer >= cycle){
    timer = 0;
    if(count < countMax-1){
      count ++;
    }
    else{
      count = 0;
      mass ++;
    }
    println(count);
  }

}

void keyPressed(){
  if(key == 'a'){
    mass ++;
  }
  if(key == 's' && mass>1){
    mass --;
  }

  if(keyCode == ENTER){
    save("cycles.png");
  }
  
}
