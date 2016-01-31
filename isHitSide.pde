PVector p[] = {};
PVector p1, p2; 

float x, y, r;
int debug = 0;
final int index = 2;

PVector createVector(PVector v1, PVector v2) {
  return new PVector(v2.x - v1.x, v2.y, v1.y);
  
}

float dotProduct(PVector a, PVector b) {
  return (a.x*b.x) + (a.y*b.y);
  
}

float crossProduct(PVector a, PVector b) {
  return (a.x*b.y) - (a.y*b.y);
  
}

float vectorLength(PVector v) {
  return dotProduct(v, v);
  
}

boolean isHitEndPoint(PVector p, float ex, float ey, float er) {
  float dx = ex - p.x;
  float dy = ey - p.y;

  return (dx*dx) + (dy*dy) < er*er;
}

boolean isHitLine(PVector p[], float ex, float ey, float er) {
  PVector p1, p2;
  float dot, k, pqd2, pmd2, phd2, d2;
  
  PVector point = new PVector(ex, ey);
  
  for(int i = 0; i < index; i++) {
    p1 = createVector(p[0], p[1]);
    p2 = createVector(p[0], point);
    
    dot = dotProduct(p1, p2);
    pqd2 = vectorLength(p1);
    pmd2 = vectorLength(p2);
    
    k = dot / pqd2;
    
    if(k < 0 || 1 < k) {
      continue;
    }
    
    phd2 = (dot*dot) / pqd2;
    d2 = pmd2 - phd2;
    
    if(d2 < er*er ) {
      return true;
      
    }
    
  }
  
  return false;
}

void setup() {
  size(500, 500);

  p1 = new PVector(height / 3, 20);
  p2 = new PVector(height / 3, width - 20);

  p = new PVector[] {
    p1, p2

  };
}

void draw() {
  background(255);
  x = mouseX;
  y = mouseY;
  r = 20;

  // 範囲
  ellipse(x, y, r*2, r*2);

  // 上の端点
  ellipse(p1.x, p1.y, 10, 10);
  // 下の端点
  ellipse(p2.x, p2.y, 10, 10);

  line(p1.x, p1.y, p2.x, p2.y);

  for (int i = 0; i < index; i++) {
    if (isHitEndPoint(p[i], x, y, r)) {
      println("vertices[" + i + "] hit");
    }
    
    if(isHitSide(p, x, y, r)) {
      debug += 1;
      println("Side line hit" + debug);
      
    }
  }
}