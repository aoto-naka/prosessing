int count = 60;
int diff = 40;
int winSize = 400;

void setup() {
  size(1000,  1000);
  //frameRate(120);
}

void draw() {

  //ellipse(width/2, height/2, width, height);
  background(255);
  int i;
  for(i=0; i<2*count; i++){   
    //stroke(random(255), random(255), 255);
    if(i<=count){
      stroke(255*i/count/2, 255*i/count, 80);
      //stroke(random(255), random(255), 255);
    }
    else{
      stroke(255*(2*count-i)/count/2, 255*(2*count-i)/count, 80);
      //stroke(random(255), 255, 255);
    }
    //↑color change,  stroke(R,G,B)
 
    line(winSize*sin(PI*i/count)+(winSize+50), winSize*cos(PI*i/count)+(winSize+50),
         winSize*sin(PI*(i+diff)/count)+(winSize+50), winSize*cos(PI*(i+diff)/count)+(winSize+50));
         
    fill(0);
    textSize(12);
    
    pushMatrix();
    translate(winSize*1.02*sin(PI*i/count)+(winSize+50), winSize*1.02*cos(PI*i/count)+(winSize+50));
    rotate(PI/2 + -PI*i/count);
    text(i+1,0,0);
    popMatrix();
    
    //text(i, winSize*1.07*sin(PI*i/count)+(winSize+50), winSize*1.07*cos(PI*i/count)+(winSize+50));
    //translate(winSize*1.07*sin(PI*i/count)+(winSize+50), winSize*1.07*cos(PI*i/count)+(winSize+50));
    //rotate(-2*PI/i);
    //translate(-winSize*1.07*sin(PI*i/count)-(winSize+50), -winSize*1.07*cos(PI*i/count)-(winSize+50));
    
   
    textSize(20);
    text("diff(a↑s↓)  = " + diff, 10, 60); 
    text("count(q↑w↓) = " + count, 10, 100);
  }
  
}


void keyPressed(){
  if(key == 'a'){
    diff ++;
  }
  if(key == 's'){
    diff --;
  }
  if(key == 'q'){
    count ++;
  }
  if(key == 'w' && count > 1){
    count --;
  }
  if(keyCode == ENTER){
    save("LineCircle.png");
  }
  
}
