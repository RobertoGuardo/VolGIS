class SliderComplex {
  float x;  // x coordinate
  float y;  // y coordinate
  float val; // current value
  float p_val; // previous value
  int val_int; // integer representation of value
  int w; // slider width
  String id; // slider name
  float x_knob; // x position for knob
  float y_knob; // y position for knob
  float min_val; // minimum value
  float max_val; // maximum value
  float knob_diam = 10; // knob diameter
  boolean knob_pressed = false; // mouse pressed on knob
  boolean is_int = false; // integer or float slider
  PFont font; // ui font
  //  PImage knob = loadImage("knob.png"); // legacy
  boolean change_flag = false; // raised when new value

  Textbox min;
  Textbox max;
  Textbox current;

  int textbox_w = 40;
  int textbox_h = 14;
  int textbox_y = 35;

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  SliderComplex(String id_) {
    id = id_;
    x = 0;
    y = 0;
    x_knob = 0;
    y_knob = 10;
    min_val = 0;
    max_val = 10;
    w = 200;

    initTextBoxes();
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  SliderComplex(String id_, float min_, float max_) {
    id = id_;
    x = 0;
    y = 0;
    x_knob = 0;
    y_knob = 10;
    min_val = min_;
    max_val = max_;
    w = 200;

    initTextBoxes();
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  SliderComplex(String id_, float min_, float max_, int w_) {
    w = w_;
    id = id_;
    x = 0;
    y = 0;
    x_knob = 0;
    y_knob = 10;
    min_val = min_;
    max_val = max_;

    initTextBoxes();
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void initTextBoxes() {
    min = new Textbox(0, textbox_y, textbox_w, textbox_h);
    min.setNumber();
    min.setText(str(min_val));
    max = new Textbox(w - textbox_w, textbox_y, textbox_w, textbox_h);
    max.setNumber();
    max.setText(str(max_val));
    current = new Textbox(w/2 - textbox_w/2, textbox_y, textbox_w, textbox_h);
    current.setNumber();
    current.setText(str(val));
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void update() {

    min_val = min.getValue();
    max_val = max.getValue();

    p_val = val;

    boolean aux = false;

    if (knob_pressed) {
      val = map(mouseX, x, x+w, min_val, max_val);
      val = constrain(val, min_val, max_val);
    } else if (current.change_flag || min.change_flag || max.change_flag) {
      val = current.getValue();
      current.lowerFlag();
      min.lowerFlag();
      max.lowerFlag();
      val = constrain(val, min_val, max_val);
      current.setText(str(val));
    }

    x_knob = map(val, min_val, max_val, x, x+w);

    if (p_val != val) {
      change_flag = true;
      current.setText(str(val));
    } else {
      change_flag = false;
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void render() {
    pushStyle();
    noStroke(); 

    min.render();
    max.render();
    current.render();

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

    /* if (is_int)
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
     text(aux, x+(w/2), y_knob+10); */

    popStyle();
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setPosition(float x_, float y_) {
    x = x_;
    y = y_;
    x_knob = x;
    y_knob = y+20;

    min.setPosition(x, y + textbox_y);
    current.setPosition(x + w/2 - textbox_w/2, y + textbox_y);
    max.setPosition(x + w -textbox_w, y + textbox_y);
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

    min.checkMouse();
    max.checkMouse();
    current.checkMouse();
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  boolean checkKeys() {

    boolean flag = false;
    if (min.checkKeys())
      flag = true;
    if (max.checkKeys())
      flag = true;
    if (current.checkKeys())
      flag = true;

    return flag;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void release() {
    knob_pressed = false;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setAsInt() {
    is_int = true;
    min.setAsInt();
    max.setAsInt();
    current.setAsInt();
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

  boolean getFlag() {
    return change_flag;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  float getFloatVal() {
    float ret = val;
    return ret;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setVal(float v) {

    v = constrain(v, min_val, max_val);
    if (is_int) {
      val = int(v);
    } else
      val = v;

    // x_knob = map(val, min_val, max_val, x, x+w);

    current.setText(str(val));
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setFont(PFont f) {
    font = f;
    min.setFont(f);
    max.setFont(f);
    current.setFont(f);
  }

  //*****************************************************************

  void move(int dx, int dy) {
    x += dx;
    y += dy;
    x_knob += dx;
    y_knob += dy;

    min.move(dx, dy);
    max.move(dx, dy);
    current.move(dx, dy);
  }
}