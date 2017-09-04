float lastx = 20;
float lasty = 100;
float y = 100;

float xstep = 10;
float ystep = 10;


void setup(){
  size(500, 200);
}

void draw() {
  background(255);
   for (int x = 20; x <= 480; x += xstep) {
    ystep = random(20) - 10;
    y += ystep;
    line(x, y, lastx, lasty); 
    lastx = x;
    lasty = y; 
  }
  
  delay(50);
  lastx = 20;
  lasty = 100;
  ystep = 10;
  y = 100;

}