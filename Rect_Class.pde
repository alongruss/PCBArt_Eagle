
class Rect_Class {
  int x, y, w, h; 
  color c;
  Rect_Class(float _x, float _y, float _w, float _h, color _c) {
    x=floor(_x);
    y=floor(_y);
    w=ceil(_w);
    h=ceil(_h);
    c=_c;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    pushStyle();
    noStroke();
    strokeWeight(0.5);
    stroke(255,0,0,20);
    fill(c,100);
    rect(0, 0, w, h);
    popStyle();
    popMatrix();
  }
}