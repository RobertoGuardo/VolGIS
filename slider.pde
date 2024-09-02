class Slider {
  float x;
  float y;
  float val;
  float p_val;
  int val_int;
  int w;
  String id;
  float x_knob;
  float y_knob;
  float min_val;
  float max_val;
  float knob_diam = 10;
  boolean knob_pressed = false;
  boolean is_int = false;
  PFont font;
  PImage knob = loadImage("knob.png");
  boolean change_flag = false;

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Slider(String id_) {
    id = id_;
    x = 0;
    y = 0;
    x_knob = 0;
    y_knob = 10;
    min_val = 0;
    max_val = 10;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Slider(String id_, float min, float max) {
    id = id_;
    x = 0;
    y = 0;
    x_knob = 0;
    y_knob = 10;
    min_val = min;
    max_val = max;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Slider(String id_, float min, float max, int w_) {
    w = w_;
    id = id_;
    x = 0;
    y = 0;
    x_knob = 0;
    y_knob = 10;
    min_val = min;
    max_val = max;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void update() {
    p_val = val;
    if (knob_pressed) {
      x_knob = mouseX;
      x_knob = constrain(x_knob, x, x+w);
    }
    val = map(x_knob, x, x+w, min_val, max_val);

    if (p_val != val) {

      change_flag = true;
    } else {
      change_flag = false;
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void render() {
    pushStyle();
    noStroke(); 

    textAlign(CENTER, TOP);
    if (font!=null)
      textFont(font);
    fill(80);
    text(id, x+(w/2)+1, y+1);
    fill(200);
    text(id, x+(w/2), y);

    fill(85);
    rect(x-5, y_knob-4, w+10, 10, 15);
    fill(70);
    rect(x-5, y_knob-5, w+10, 10, 15);
    noFill();
    strokeWeight(2);
    stroke(60);
    line(x, y_knob+2, x+w+2, y_knob+2 );
    line(x+w+2, y_knob+3, x+w+2, y_knob );
    stroke(150);
    line(x, y_knob, x+w, y_knob );
    pushStyle();
    strokeWeight(2);
    colorMode(HSB, 360, 100, 100, 100);
    for (int i = int(x); i < x_knob; i++) {
      float h = map(i, x, x+w, 120, 0);
      stroke(h, 100, 80);
      point(i, y_knob);
    }    
    popStyle();
    noStroke();
    fill(40);
    ellipse(x_knob, y_knob+2, knob_diam, knob_diam);
    fill(190);
    noStroke();
    strokeWeight(1);
    ellipse(x_knob, y_knob, knob_diam, knob_diam);

    // imageMode(CENTER);
    // image(knob,x_knob, y_knob);


    if (knob_pressed)
      fill(255, 0, 0, 120);
    else
      noFill();
    fill(200);
    String aux = "";

    if (is_int)
      aux = str(int(min_val));
    else
      aux = nf(min_val, 2, 1);

    fill(80);
    text(aux, x+1, y_knob+11);
    fill(200);
    text(aux, x, y_knob+10);

    if (is_int)
      aux = str(int(max_val));
    else
      aux = nf(max_val, 2, 1);

    fill(80);
    text(aux, x+w+1, y_knob+11);
    fill(200);
    text(aux, x+w, y_knob+10);

    if (is_int)
      aux = str(int(val));
    else
      aux = nf(val, 2, 1);

    fill(80);
    text(aux, x+(w/2), y_knob+11);
    fill(200);
    text(aux, x+(w/2), y_knob+10);

    popStyle();
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setPosition(float x_, float y_) {
    x = x_;
    y = y_;
    x_knob = x;
    y_knob = y+20;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void checkMouse() {
    if (dist(mouseX, mouseY, x_knob, y_knob) < knob_diam) {
      knob_pressed = true;
    } else if (mouseX > x -5 && mouseX < x+w + 5 && mouseY < y_knob+7  && mouseY > y_knob-7) {
      x_knob = mouseX;
      x_knob = constrain(x_knob, x, x+w);
      knob_pressed = true;
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void release() {
    knob_pressed = false;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setAsInt() {
    is_int = true;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setAsFloat() {
    is_int = false;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  String getId() {

    return id;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  float getVal() {
    float ret = val;
    if (is_int) {
      ret = int(val);
    }

    return ret;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  int getIntVal() {
    int ret = int(val);
    return ret;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  float getFloatVal() {
    float ret = val;
    return ret;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  boolean getFlag() {
    return change_flag;
  }


  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setVal(float v) {

    v = constrain(v, min_val, max_val);

    if (is_int) {
      val = int(v);
    } else
      val = v;

    x_knob = map(val, min_val, max_val, x, x+w);
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setFont(PFont f) {
    font = f;
  }

  //*****************************************************************

  void move(int dx, int dy) {
    x += dx;
    y += dy;
    x_knob += dx;
    y_knob += dy;
  }
}