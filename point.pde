class Point {
  float x;
  float y;
  float z;
  float mag;
  float diam = 1;
  boolean selected = false;
  float hue = 0;

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Point() {
    x = 0;
    y = 0;
    z = 0;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Point(float x_, float y_, float z_, float mag_) {
    x = x_;
    y = y_;
    z = z_;
    mag = mag_;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void render() {
    pushMatrix();
    pushStyle();
    colorMode(HSB, 360, 100, 100);
    translate(x, y, z);
    fill(hue, 100, 100);
    box(diam);
    popStyle();
    popMatrix();
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void render(PGraphics g) {
    g.pushStyle();
    g.pushMatrix();
    g.colorMode(HSB, 360, 100, 100);
    g.translate(x, y, z);
    g.fill(hue, 100, 100);
  //g.fill(0, 100, 100);
    g.noStroke();
    
    g.box(diam);
    
   


 //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ White Star Marker
    if (selected) 
    {
      g.fill(255, 0, 100);
      g.stroke(255, 0, 100);
      //stroke(180);
      int aux = 20;
      //g.line(-aux, 0, 0, aux, 0, 0);
      //g.line(0, -aux, 0, 0, aux, 0);
      //g.line(0, 0, -aux, 0, 0, aux);
      
      // syntax line(x1, y1, z1, x2, y2, z2)   !!! z is the horizontal plan normal to x
     /* g.line(-80, 0, -80, -80, 50, -80);     // X
      g.line(-80, 25, -90, -80, 25, -70);    // y
      
      g.line(80, 0, -80, 80, 50, -80);   
      g.line(80, 25, -90, 80, 25, -70);  
      
      g.line(80, 0, 80, 80, 50, 80);     
      g.line(80, 25, 90, 80, 25, 70);    
      
      g.line(-80, 0, 80, -80, 50, 80);   
      g.line(-80, 25, 90, -80, 25, 70);*/  
    }
    
    
    g.popMatrix();
    g.popStyle();
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setPosition(float x_, float y_, float z_) {
    x = x_;
    y = y_;
    z = z_;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  PVector getPosition() {
    PVector pos = new PVector(x,y,z);
    return pos;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setDiam(float d) {
    diam = d;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setHue(float h) {
    hue = h;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void select() {
    selected = true;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void deselect() {
    selected = false;
  }
  
  
  
}