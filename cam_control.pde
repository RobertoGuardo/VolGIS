class CamControl {
  float x = 0;
  float y = 0;
  int travel = 40;

  float zoom_x = 0;
  float zoom_y = 0;
  float zoom_x_home = 0;
  float zoom_y_home = 0;
  boolean zoom_pressed = false;
  boolean zoom_returning = false;
  float zoom_y_aux = 0;
  float zoom_y_val = 0;
  int zoom_thresh = 10;
  int zoom_diam = 10;

  float pan_x = 0;
  float pan_y = 0;
  float pan_x_home = 0;
  float pan_y_home = 0;
  boolean pan_pressed = false;
  int pan_diam = 10;
  boolean pan_returning = false;
  float pan_x_aux = 0;
  float pan_y_aux = 0;
  float pan_x_val = 0;
  float pan_y_val = 0;
  boolean panning_x = false;
  boolean panning_y = false;
  int pan_thresh = 5;

  float EASING_TIME = 0;
  float EASING_TIME_INCREMENT = 0.02;

  int GRADIENT_BRI = 100;
  int GRADIENT_SAT = 100;
  int GRADIENT_ALFA = 45;

  PFont f;

  CamControl() {
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  CamControl(float x_, float y_) {
    x = x_;
    y = y_;
    pan_x_home = x + travel;
    pan_y_home = y + travel;
                               
    pan_x = pan_x_home;
    pan_y = pan_y_home;

    zoom_x_home = x + travel*2 + 40;
    zoom_y_home = y + travel;
    zoom_x = zoom_x_home;
    zoom_y = zoom_y_home;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void update() {

    //------ PAN PAN PAN -------

    if (pan_pressed) {

      float delta_x = abs(pan_x-pan_x_home);
      float delta_y = abs(pan_y-pan_y_home);
            
      if (delta_x < pan_thresh && delta_y < pan_thresh) {

        panning_x = false;
        panning_y = false;
      }


      if (!panning_x && !panning_y) {
        pan_x = mouseX;
        pan_x =constrain(pan_x, pan_x_home - travel, pan_x_home + travel); 
        pan_y = mouseY;
        pan_y =constrain(pan_y, pan_y_home - travel, pan_y_home + travel);

        if (delta_x > pan_thresh || delta_y > pan_thresh) {
          if (delta_x > delta_y) {
            panning_x = true;
          } else {
            panning_y = true;
          }
        }
      }

      if (panning_y) {
        pan_y = mouseY;
        pan_y =constrain(pan_y, pan_y_home - travel, pan_y_home + travel);
        pan_x = pan_x_home;
      } else if (panning_x) {
        pan_x = mouseX;
        pan_x =constrain(pan_x, pan_x_home - travel, pan_x_home + travel); 
        pan_y = pan_y_home;
      }
    }

    if (pan_returning) {

      pan_x = lerp(pan_x_aux, pan_x_home, quinticOut(EASING_TIME));
      pan_y = lerp(pan_y_aux, pan_y_home, quinticOut(EASING_TIME));

      if (EASING_TIME <1) {
        EASING_TIME += EASING_TIME_INCREMENT;
      } else {
        pan_returning = false;
        EASING_TIME = 0;
      }
    }

    pan_x_val = map(pan_x, pan_x_home - travel, pan_x_home + travel, -1, 1);
    pan_y_val = map(pan_y, pan_y_home - travel, pan_y_home + travel, -1, 1);

    //------ ZOOM ZOOM ZOOM -------

    if (zoom_pressed) {
      zoom_y = mouseY;
      zoom_y =constrain(zoom_y, zoom_y_home - travel, zoom_y_home + travel);
    }

    if (zoom_returning) {
      zoom_y = lerp(zoom_y_aux, zoom_y_home, quinticOut(EASING_TIME));

      if (EASING_TIME <1) {
        EASING_TIME += EASING_TIME_INCREMENT;
      } else {
        zoom_returning = false;
        EASING_TIME = 0;
      }
    }
    zoom_y_val = map(zoom_y, zoom_y_home - travel, zoom_y_home + travel, -1, 1);
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void render() {
    pushStyle();

    noFill();

    fill(200);
    if (f!=null)
      textFont(f);

    textAlign(CENTER, CENTER);

    text("rotación", pan_x_home, pan_y_home + travel+20);
    text("zoom", zoom_x_home, zoom_y_home + travel+20);
    //  stroke(255, 0, 0);
    // rect(x, y, 300, 200);

    //------ PAN PAN PAN -------

    noStroke();
    fill(120);
    rect(pan_x_home-5, pan_y_home-travel - 4, 10, travel*2+8, 15);
    rect(pan_x_home-travel-5, pan_y_home-4, travel*2+10, 10, 15);
    fill(70);
    rect(pan_x_home-5, pan_y_home-travel - 5, 10, travel*2+8, 15);
    rect(pan_x_home-travel-5, pan_y_home-5, travel*2+10, 10, 15);

    strokeWeight(2);
    stroke(60);
    line(pan_x_home - travel, pan_y_home+2, pan_x_home +travel, pan_y_home+2);
    line(pan_x_home, pan_y_home-travel + 2, pan_x_home, pan_y_home + travel + 2);

    stroke(150);
    line(pan_x_home - travel, pan_y_home, pan_x_home +travel, pan_y_home);
    line(pan_x_home, pan_y_home-travel, pan_x_home, pan_y_home + travel);

    pushStyle();
    strokeWeight(2);
    colorMode(HSB, 360, 100, 100, 100);
    pushMatrix();
    translate(pan_x_home, pan_y_home);
    for (int i = 0; i < abs(pan_x - pan_x_home); i++) {
      float h = map(i, 0, travel, 120, 0);
      stroke(h, GRADIENT_SAT, GRADIENT_BRI, GRADIENT_ALFA);
      if (pan_x - pan_x_home < 0)
        point(-i, 0);
      else
        point(i, 0);
    }    
    popMatrix();

    pushMatrix();
    translate(pan_x_home, pan_y_home);
    for (int i = 0; i < abs(pan_y - pan_y_home); i++) {
      float h = map(i, 0, travel, 120, 0);
      stroke(h, GRADIENT_SAT, GRADIENT_BRI, GRADIENT_ALFA);
      if (pan_y - pan_y_home < 0)
        point(0, -i);
      else
        point(0, i);
    }    
    popMatrix();

    popStyle();

    fill(40);
    noStroke();
    ellipse(pan_x_home, pan_y_home, pan_diam, pan_diam);

    noStroke();
    fill(40);
    ellipse(pan_x, pan_y + 2, pan_diam, pan_diam);
    fill(190);
    noStroke();
    strokeWeight(1);
    ellipse(pan_x, pan_y, pan_diam, pan_diam);

    //   fill(255, 100, 100);
    //    text(pan_x_val, pan_x_home, pan_y_home);
    //  text(pan_y_val, pan_x_home, pan_y_home+travel);

    //------ ZOOM ZOOM ZOOM -------

    noStroke();
    fill(120);
    rect(zoom_x_home-5, zoom_y_home-travel - 4, 10, travel*2+8, 15);

    fill(70);
    rect(zoom_x_home-5, zoom_y_home-travel - 5, 10, travel*2+8, 15);

    strokeWeight(2);
    stroke(60);
    line(zoom_x_home, zoom_y_home-travel + 2, zoom_x_home, zoom_y_home + travel + 2);

    stroke(150);
    line(zoom_x_home, zoom_y_home-travel, zoom_x_home, zoom_y_home + travel);

    pushStyle();
    strokeWeight(2);
    colorMode(HSB, 360, 100, 100, 100);

    pushMatrix();
    translate(zoom_x_home, zoom_y_home);
    for (int i = 0; i < abs(zoom_y - zoom_y_home); i++) {
      float h = map(i, 0, travel, 120, 0);
      stroke(h, GRADIENT_SAT, GRADIENT_BRI, GRADIENT_ALFA);
      if (zoom_y - zoom_y_home < 0)
        point(0, -i);
      else
        point(0, i);
    }    
    popMatrix();

    popStyle();


    fill(40);
    noStroke();
    ellipse(zoom_x_home, zoom_y_home, zoom_diam, zoom_diam);

    noStroke();
    fill(40);
    ellipse(zoom_x, zoom_y + 2, zoom_diam, zoom_diam);
    fill(190);
    noStroke();
    strokeWeight(1);
    ellipse(zoom_x, zoom_y, zoom_diam, zoom_diam);

    //   fill(255, 100, 100);
    //  text(zoom_y_val, zoom_x_home, zoom_y_home+travel);

    popStyle();
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setFont(PFont f_) {

    f = f_;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  float getZoom() {

    return zoom_y_val;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  float getPanX() {

    return pan_x_val;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  float getPanY() {

    return pan_y_val;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  PVector getPan() {

    PVector vec = new PVector(pan_x_val, pan_y_val);

    return vec;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void checkMouse() {
    if (dist(pan_x, pan_y, mouseX, mouseY) < pan_diam) {
      pan_pressed= true;
    }

    if (dist(zoom_x, zoom_y, mouseX, mouseY) < zoom_diam) {
      zoom_pressed= true;
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void release() {
    if (pan_pressed) {
      pan_pressed = false;
      pan_returning = true;
      pan_x_aux = pan_x;
      pan_y_aux = pan_y;
      panning_x = false;
      panning_y = false;
    }

    if (zoom_pressed) {
      zoom_pressed = false;
      zoom_returning = true;
      zoom_y_aux = zoom_y;
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void move(int dx, int dy) {
    x += dx;
    y += dy;
  }
}