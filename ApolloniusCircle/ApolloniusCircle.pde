float dotSize = 1;
float aX = -200;
float aY = 0;
float bX = 200;
float bY = 0;

void setup(){
  size(1000, 1000);
  strokeWeight(dotSize);
  
}

void draw(){
  translate(0,height/2);
  RandomDotPut(1000);
  strokeWeight(1);
  stroke(0);
  line(0, -height, 0, height);
}

void RandomDotPut(int a){
  int i;
  float x, y;
  float aDistance, bDistance;

  for(i=0; i<a; i++){
    x = random(2*width) - width;
    y = random(2*height) - height;
    aDistance = ReturnDistance(x, y, aX, aY);
    bDistance = ReturnDistance(x, y, bX, bY);
    
    if(aDistance/bDistance >= 4){
        stroke(0, 0, 255);
    }
    else if(aDistance/bDistance >= 3){
        stroke(0, 255, 0);
    }
    else if(aDistance/bDistance >= 2){
        stroke(255, 0, 0);
    }
    else if(aDistance/bDistance >= 1.4){
        stroke(0, 0, 255);
    }
    
    else{
      stroke(0);
    }
    strokeWeight(dotSize);
    point(x, y);
    
  }
}
float ReturnDistance(float x1, float y1, float x2, float y2){
  float distance;
  distance = sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2));
  return distance;
  
}
