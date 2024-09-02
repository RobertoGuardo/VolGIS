class Toggle {

  float x;
  float y;
  float w = 10;
  boolean pressed = false;
  String id= "";
  PFont font;
  boolean flag = false;

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Toggle(float x_, float y_, String id_) {
    x = x_;
    y = y_;
    id = id_;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Toggle(float x_, float y_, float w_, String id_) {
    x = x_;
    y = y_;
    w = w_;
    id = id_;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void render() {
    pushStyle();
    textAlign(LEFT, TOP);
    noStroke();
    fill(85);
    rect(x, y+1, w, w, 4);
    fill(70);
    rect(x, y, w, w, 4);


    if (pressed)
      renderCheck();
    if(font!=null)
    textFont(font);
    fill(200);
    text(id, x+20, y);
    popStyle();
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void renderCheck() {
    fill(2, 162, 161);
    rect(x+2, y+2, 6, 6, 2);
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setFont(PFont f) {
    font = f;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void checkMouse() {
    if (mouseX > x && mouseX < x+ w && mouseY >y && mouseY < y + w) {
      pressed = !pressed;
      if (pressed)
        flag = true;
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  boolean isPressed() {
    return pressed;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void check() {
    pressed = true;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void uncheck() {
    pressed = false;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void unflag() {
    flag = false;
  }
  
  
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  boolean getFlag() {
    return flag;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setPosition(int x_, int y_) {
    x = x_;
    y = y_;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setId(String s) {

    id = s;
  }


  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  String getId() {

    return id;
  }
  
  //*****************************************************************

  void move(int dx, int dy) {
    x += dx;
    y += dy;
  }
}