int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  hint(ENABLE_STROKE_PERSPECTIVE);
  rectMode(CENTER);

  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  randomSeed(seed);
  noiseSeed(seed);
  background(255);

  float fov = PI/random(3, 5);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);

  translate(width*0.5, height*0.55, -500);
  rotateX(HALF_PI);
  rotateY(random(-0.1, 0.1));
  rotateZ(random(-0.1, 0.1));

  scale(0.6);

  //stroke(rcol(), 200);

  stroke(0, 20);
  strokeWeight(0.2);

  /*
  float ss = random(20, 120);
   for(int i = 0; i < 100000; i++){
   float xx = random(-width, width);
   float yy = random(-height, height);
   float zz = random(-height, height);
   
   xx -= xx%ss;
   yy -= yy%ss;
   zz -= zz%ss;
   noFill();
   pushMatrix();
   translate(xx, yy, zz);
   //box(40);
   modulo1(ss);
   popMatrix();
   } 
   */

  pushMatrix();
  ArrayList<Box> boxes = new ArrayList<Box>();
  boxes.add(new Box(0, 0, 0, width*3, height*3, width*1.5));

  int subs = int(random(400));
  for (int l = 0; l < subs; l++) {
    int ind = int(random(boxes.size()*random(1)));
    Box b = boxes.get(ind);
    float w1 = random(0.3, 0.7);
    float w2 = (1-w1);
    float h1 = random(0.3, 0.7); 
    float h2 = (1-h1);
    float d1 = random(0.3, 0.7); 
    float d2 = (1-d1);

    float w = b.w;
    float h = b.h;
    float d = b.d;

    w1 *= w;
    w2 *= w;
    h1 *= h;
    h2 *= h;
    d1 *= d;
    d2 *= d;

    boxes.add(new Box(b.x-w*0.5+w1*0.5, b.y-h*0.5+h1*0.5, b.z-d*0.5+d1*0.5, w1, h1, d1));
    boxes.add(new Box(b.x+w*0.5-w2*0.5, b.y-h*0.5+h1*0.5, b.z-d*0.5+d1*0.5, w2, h1, d1));
    boxes.add(new Box(b.x-w*0.5+w1*0.5, b.y+h*0.5-h2*0.5, b.z-d*0.5+d1*0.5, w1, h2, d1));
    boxes.add(new Box(b.x+w*0.5-w2*0.5, b.y+h*0.5-h2*0.5, b.z-d*0.5+d1*0.5, w2, h2, d1));

    boxes.add(new Box(b.x-w*0.5+w1*0.5, b.y-h*0.5+h1*0.5, b.z+d*0.5-d2*0.5, w1, h1, d2));
    boxes.add(new Box(b.x+w*0.5-w2*0.5, b.y-h*0.5+h1*0.5, b.z+d*0.5-d2*0.5, w2, h1, d2));
    boxes.add(new Box(b.x-w*0.5+w1*0.5, b.y+h*0.5-h2*0.5, b.z+d*0.5-d2*0.5, w1, h2, d2));
    boxes.add(new Box(b.x+w*0.5-w2*0.5, b.y+h*0.5-h2*0.5, b.z+d*0.5-d2*0.5, w2, h2, d2));

    boxes.remove(ind);
  }

  for (int l = 0; l < boxes.size(); l++) {
    Box o = boxes.get(l);
    pushMatrix();
    translate(o.x, o.y, o.z);
    //fill(rcol());
    //box(o.w, o.h, o.d);
    stroke(rcol(), random(100, 160));
    modulo1(o.w, o.h, o.d);
    stroke(rcol(), random(160));
    modulo1(o.w, o.h, o.d);
    stroke(rcol(), random(160));
    modulo1(o.w, o.h, o.d);
    popMatrix();
  }
}

void modulo1(float s) {
  modulo1(s, s, s);
}

void modulo1(float w, float h, float d) {
  float mw = w*0.5;
  float mh = h*0.5;
  float md = d*0.5;
  int cc = 100;
  for (int i = 0; i < cc; i++) {
    float v = map(i, 0, cc-1, -1, 1);
    if (random(1) < 0.5) line(mw*v, -mh, -md, mw*v, +mh, +md);
    if (random(1) < 0.5) line(mw*v, +mh, -md, mw*v, -mh, +md);
    if (random(1) < 0.5) line(mw*v, +mh, +md, mw*v, +mh, -md);
    if (random(1) < 0.5) line(mw*v, -mh, +md, mw*v, -mh, -md);
    if (random(1) < 0.5) line(mw*v, -mh, -md, mw*v, +mh, +md);
    if (random(1) < 0.5) line(mw*v, +mh, -md, mw*v, -mh, +md);
    if (random(1) < 0.5) line(mw, +mh*v, +md, mw, +mh*v, -md);
    if (random(1) < 0.5) line(mw, -mh*v, +md, mw, -mh*v, -md);


    if (random(1) < 0.5) line(-mw, +mh*v, -md, mw, +mh*v, -md);
    if (random(1) < 0.5) line(-mw, -mh*v, +md, mw, -mh*v, +md);
  }
  //line(-mw, -mh, -md, -mw, +mh, -md);
  //line(-mw, -mh, +md, -mw, +mh, +md);
}

class Box {
  float x, y, z, w, h, d;
  Box(float x, float y, float z, float w, float h, float d) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w; 
    this.h = h;
    this.d = d;
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#677E6C, #B75925, #DD8C31, #F7EAD9, #FDCCC7};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}