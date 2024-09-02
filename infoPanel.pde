class InfoPanel {

  int x;
  int y;
  float w = 298;
  float h = 50;


  float close_x ;
  float close_y ;

  String id;
  String [] info;

  PFont f;

  InfoPanel(String id_) {
    id = id_;

    close_x  = x + w - 10;
    close_y  = y + 7;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  InfoPanel(String id_, int x_, int y_) {
    id = id_;
    x = x_;
    y = y_;

    close_x  = x + w - 10;
    close_y  = y + 7;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void render() {
    pushStyle();
    fill(20);
    stroke(80);
    rect(x, y, w, h, 5);

    pushMatrix();

    translate(x, y );

    stroke(0);
    line(0, 15, w, 15);
    stroke(90);
    line(0, 15 + 1, w, 15 + 1);

    translate( 5, 5);

    textAlign(LEFT, TOP);
    noStroke();
    if (font!=null)
      textFont(font);
    fill(211, 97, 27);
    text(id, 0, 0);

    fill(200);


    for (int i = 0; i < info.length; i ++) {

      text(info[i], 5, 18 + i*15);

      if (i>0) {

        float w  = textWidth(info[i-1]);

        stroke(50);
        line(5, 18 + i*15 -3, 5 + w, 18 + i*15 -3);
      }
    }

    popMatrix();


    rectMode(CENTER);

    fill(150);

    rect(close_x, close_y + 1, 10, 7, 3);

    fill(255, 0, 107);

    rect(close_x, close_y, 10, 7, 3);


    popStyle();
  }


  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setFont(PFont f) {
    font = f;
  }


  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setPosition(int x_, int y_) {
    x = x_;
    y = y_;
    close_x  = x + w - 10;
    close_y  = y + 7;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setId(String s) {

    id = s;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setText(String [] s) {

    info = s;

    h = 25 + s.length * 15;
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
  //*****************************************************************

  boolean checkMouse() {
    boolean aux = false;

    if (mouseX > close_x - 5 && mouseX < close_x + 5 && mouseY > close_y - 5 && mouseY < close_y + 5)
      aux = true;
    return aux;
  }
}