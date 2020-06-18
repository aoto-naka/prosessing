float time = 20.0;
int score = 3;
boolean quizFlag = false;
boolean clickable = true;
int correctX = 0;
int correctY = 0;
float correctCapa = 100;
// 0:title, 1:game, 2:result
int state = 0;

void setup(){
  size(1600, 1000);
  noFill();
  textSize(90);
}

void draw(){
  fill(10,10,200);
  if(state == 0){
    background(255);
    text("move mouse!\nwhen two circle overlap,\nLeft click!", 20, 100);
    if(mousePressed && clickable){
      state = 1;
      score = 3;
      time = 20;
    }
  }
  
  if(state == 1){
    time -= 1/frameRate;
    if(!quizFlag){
      correctX = int(random(200,800));
      correctY = int(random(200,800));
      quizFlag = true;
    }
    background(255);
    
    // answer view
    //ellipse(correctX,correctY,10,10);
    noFill();
    ellipse(mouseX, mouseY, 100, 100);
    ellipse(2*correctX-mouseX, 2*correctY-mouseY, 100,100);
    line(1000,0,1000,1000);
    fill(255);
    // right side Initialization
    rect(1000,-10,600,1020);
    
    float diff;
    diff = sq(mouseX-correctX) + sq(mouseY-correctY);
    if(mousePressed && clickable){
      clickable = false;
      if(diff <= correctCapa){
        score ++;
        quizFlag = false;
      }
      else{
        fill(0,0,200);
        ellipse(mouseX,mouseY,10,10);
        score -= 3;
      }
    }
    fill(0);
    text("time : " + time + "sec", 1020, 200);
    text("score: " + score,1020,300);
    
    if(time < 0){
      state = 2;
    }
  }
  if(state == 2){
    background(255);
    text("score: " + score + "\n\nT key:Title\nR key:Retry", 20, 100);
  }
}

void mouseReleased(){
  clickable = true;
}
void keyPressed() {
  if(key == 't'){
    state = 0;
  }
  if(key == 'r'){
    state = 1;
    time = 20;
    score = 0;
  }
  if(key == ENTER){
    save("ellipseQuiz.png");
  }
}
