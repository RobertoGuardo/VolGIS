class Ruler {

  PVector first_point;

  PVector second_point;

  PVector half_point;

  boolean setting = false;

  float dist = 0;

  PFont font;

  boolean constrain = false;

  boolean active = false;

  boolean first_set = false;

  float offset_x = 300;

  float offset_y = 0;


  //**************************************************

  Ruler() {

    first_point = new PVector(0, 0);

    second_point = new PVector(0, 0);

    half_point = new PVector(0, 0);
  }

  //**************************************************

  void update() {

    if (active) {

      if (keyPressed && keyCode == SHIFT)
        constrain = true;
      else
        constrain = false;


      if (!first_set)
        setFirstPoint(mouseX, mouseY);

      if (setting) {
        if (!constrain)
          setSecondPoint(mouseX, mouseY);
        else
          setSecondPointConstrain(mouseX, mouseY);
      }

      dist = dist(first_point.x, first_point.y, second_point.x, second_point.y); //ori
      //dist = (dist(first_point.x, first_point.y, second_point.x, second_point.y))/(???);
      

      float mid_x = lerp(first_point.x, second_point.x, 0.5);
      float mid_y = lerp(first_point.y, second_point.y, 0.5);
      half_point.set(mid_x, mid_y);
    }
  }

  //**************************************************


  void render() {


    /* String aux = "x (long): " +  map(x, - cube_side/2,  cube_side/2, c.min_lon_deg, c.max_lon_deg) + "°";
     
     info_text = append(info_text, aux);
     
     aux = "y (prof): " +  map(y, - cube_side/2,  cube_side/2, c.min_prof_map, c.max_prof_map)+  " kms";
     
     info_text = append(info_text, aux);
     
     aux = "z (lat): " + map(z, - cube_side/2,  cube_side/2, c.max_lat_deg, c.min_lat_deg)  + "°" ;
     
     info_text = append(info_text, aux);
     
     aux = "width: " + map(w, 0, 400, 0, kms_per_side) +  " kms";
     
     info_text = append(info_text, aux);
     
     aux = "height: " + map(h, 0, 400, 0, kms_per_side) +  " kms";
     
     info_text = append(info_text, aux);
     
     aux = "depth: " + map(d, 0, 400, 0, kms_per_side) +  " kms";
     
     info_text = append(info_text, aux);
     
     aux = "points inside: " + points_contained;
     
     info_text = append(info_text, aux);
     
     */



    pushStyle();
    if (font!=null)
      textFont(font);
    stroke(0, 255, 193);
    renderMarker(first_point);
    if (!setting)
      renderMarker(second_point);
    strokeWeight(4);

    if (first_set) {
      stroke(0, 255, 193, 50);
      line(first_point.x, first_point.y, second_point.x, second_point.y);


      renderValues(second_point);
      renderHalfPoint(half_point, dist);
    }
    renderValues(first_point);
    popStyle();
  }

  //**************************************************

  void setFirstPoint(float x_, float y_) {

    first_point.set(x_, y_);
  }

  //**************************************************  

  void setSecondPoint(float x_, float y_) {

    second_point.set(x_, y_);

    //setting = true;
  }

  //**************************************************

  void setSecondPointConstrain(float x_, float y_) {

    float dir = abs(atan2(y_ - first_point.y, x_ - first_point.x));    

    if (dir > QUARTER_PI && dir < HALF_PI + QUARTER_PI)
      second_point.set(first_point.x, y_);
    else
      second_point.set(x_, first_point.y);
  }

  //**************************************************

  void mouse() {

    if (active && mouseX > offset_x && mouseY > offset_y) {

      if (!setting) {
        setting = true;
        setFirstPoint(mouseX, mouseY);
        first_set = true;
      } else {
        if (constrain)
          setSecondPointConstrain(mouseX, mouseY);
        else
          setSecondPoint(mouseX, mouseY);
        setting = false;
      }
    }
  }

  //**************************************************

  void renderMarker(PVector v) {

    pushMatrix();

    translate(v.x, v.y);

    line(-5, 0, 5, 0);

    line(0, -5, 0, 5);

    popMatrix();
  }

  //**************************************************

  void renderValues(PVector v) {

    pushStyle();

    textAlign(CENTER, CENTER);

    rectMode(CENTER);

    float x = map(v.x - offset_x - render.width/2, - cube_side/2, cube_side/2, c.min_lon_deg, c.max_lon_deg);

    float y = map(v.y -offset_y - render.height/2, - cube_side/2, cube_side/2, c.max_lat_deg, c.min_lat_deg);

    String text = nf(x, 0, 3) + ", " + nf(y, 0, 3);

    float h = textAscent() + textDescent();

    float w = textWidth(text);

    h += 10;
    w += 10;

    fill(50, 90);
    noStroke();

    pushMatrix();
    translate(v.x, v.y - h*1);
    rect(0, 0, w, h);
    fill(255);
    text(text, 0, 0);
    popMatrix();
    popStyle();
  }

  //**************************************************

  void renderHalfPoint(PVector v, float d) {


    d = map(d, 0, 400, 0, kms_per_side * 1000);

    pushStyle();

    textAlign(CENTER, CENTER);

    rectMode(CENTER);

    String text = nf(d, 0, 2) + " m";

    float h = textAscent() + textDescent();

    float w = textWidth(text);

    h += 10;
    w += 10;

    fill(50, 90);
    noStroke();

    pushMatrix();
    translate(v.x, v.y - h*2);



    rect(0, 0, w, h);
    fill(255);
    text(text, 0, 0);
    popMatrix();
    popStyle();
  }

  //**************************************************

  void setFont(PFont f) {

    font = f;
  }

  //**************************************************

  void activate() {

    active = true;
  }

  //**************************************************

  void deactivate() {

    active = false;
    setting = false;
    constrain = false;
    first_point = new PVector(0, 0);
    second_point = new PVector(0, 0);
    half_point = new PVector(0, 0);
    first_set = false;
  }

  //**************************************************
}