class Info {

  float x;
  float y;
  String id= "";
  String text = "";
  PFont font;
  boolean flag = false;

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Info(float x_, float y_, String id_) {
    x = x_;
    y = y_;
    id = id_;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void render() {
    pushStyle();
    textAlign(LEFT, TOP);
    noStroke();
    if (font!=null)
      textFont(font);
    fill(200);
    text(id +  "  " + text, x, y);
    popStyle();
  }


  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setFont(PFont f) {
    font = f;
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
  
  void setText(String s) {

    text = s;
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