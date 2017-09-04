
int step = 10;
float lastx = -999;
float lasty = -999;
float y = 50;
int border = 20;

void setup(){
  size(500, 80);
}

void draw() {
  background(255);
   for (int x = border; x <= width - border; x += step) {
    y = border + random(height = 2* border);
    if (lastx > -999) {
      line(x, y, lastx, lasty); 
    }
    lastx = x;
    lasty = y; 
  }
  
  delay(30);
  lastx = -999;
  lasty = -999;
}