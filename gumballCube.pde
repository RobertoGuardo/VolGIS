class GumballCube {
  float w;
  float h;
  float d;
  float x;
  float y;
  float z;
  color co;
  color hover;
  color pressed;

  boolean cube_hover = false;

  boolean translate_x_hover = false;
  boolean translate_y_hover = false;
  boolean translate_z_hover = false;

  boolean scale_x_hover = false;
  boolean scale_y_hover = false;
  boolean scale_z_hover = false;

  boolean info_hover = false;

  boolean translate_x_pressed = false;
  boolean translate_y_pressed = false;
  boolean translate_z_pressed = false;

  boolean scale_x_pressed = false;
  boolean scale_y_pressed = false;
  boolean scale_z_pressed = false;

  boolean x_pressed = false;
  boolean y_pressed = false;
  boolean z_pressed = false;
  boolean active = false;

  boolean something_pressed = false;

  color cube_color;
  color translate_x_color;
  color translate_y_color;
  color translate_z_color;
  color scale_x_color;
  color scale_y_color;
  color scale_z_color;
  color info_color;

  float aux_dist = 0;

  float spacer = 10;

  // PARA CALCULO 2D

  PVector x_arrow_tip;
  PVector y_arrow_tip;
  PVector z_arrow_tip;
  PVector x_arrow_2d;
  PVector y_arrow_2d;
  PVector z_arrow_2d;
  PVector cube_2d;
  float angle_x;
  float angle_y;
  float angle_z;
  int offset_x= 0;
  int offset_y = 0;

  int arrow_width = 6;
  int arrow_length = 40;

  boolean display_info;

  InfoPanel info;

  int points_contained = 0;

  //•••••••••••••••••••••••••••••••••••••

  GumballCube() {

    reset();
    co = color(247, 112, 214, 40);
    hover = color(255, 50);
    pressed = color(2, 190, 198);

    info = new InfoPanel("infopanel", width-300, 50);
    countPointsContained();
  }

  //•••••••••••••••••••••••••••••••••••••

  GumballCube(float x_, float y_, float z_) {

    w = 50;
    h = 50;
    d = 50;
    x = x_;
    y = y_;
    z = z_;
    co = color(247, 112, 214, 40);
    hover = color(255, 50);
    pressed = color(2, 190, 198);
    info = new InfoPanel("infopanel", width-300, 50);
    info.setFont(ui_font);
    countPointsContained();
  }

  //•••••••••••••••••••••••••••••••••••••

  void calculate2DArrows(PGraphics g) {


    x_arrow_tip = new PVector(x + w/2 + spacer + arrow_length, y, z);
    y_arrow_tip = new PVector(x, y - h/2 - spacer - arrow_length, z);
    z_arrow_tip = new PVector(x, y, z + d/2 + spacer + arrow_length);


    x_arrow_2d = new PVector(g.screenX(x_arrow_tip.x, x_arrow_tip.y, x_arrow_tip.z), g.screenY(x_arrow_tip.x, x_arrow_tip.y, x_arrow_tip.z));
    y_arrow_2d = new PVector(g.screenX(y_arrow_tip.x, y_arrow_tip.y, y_arrow_tip.z), g.screenY(y_arrow_tip.x, y_arrow_tip.y, y_arrow_tip.z));
    z_arrow_2d = new PVector(g.screenX(z_arrow_tip.x, z_arrow_tip.y, z_arrow_tip.z), g.screenY(z_arrow_tip.x, z_arrow_tip.y, z_arrow_tip.z));

    cube_2d = new PVector(g.screenX(x, y, z), g.screenY(x, y, z));

    angle_x =  atan2( x_arrow_2d.y - cube_2d.y, x_arrow_2d.x - cube_2d.x);
    angle_y =  atan2( y_arrow_2d.y - cube_2d.y, y_arrow_2d.x - cube_2d.x);
    angle_z =  atan2( z_arrow_2d.y - cube_2d.y, z_arrow_2d.x - cube_2d.x);
  }

  //•••••••••••••••••••••••••••••••••••••

  void update(PGraphics g) {

    calculate2DArrows(g);

    if (something_pressed) {

      countPointsContained();

      float dy = mouseY-pmouseY;

      float dx = mouseX-pmouseX;

      // *************** X AXIS ***************

      if (x_pressed) {

        float val = 0;

        if (abs(angle_x) < QUARTER_PI) {
          val = dx;
        } else if (abs(angle_x) > HALF_PI + QUARTER_PI) {
          val = -dx;
        } else if (angle_x < -QUARTER_PI  && angle_x > -(QUARTER_PI + HALF_PI)  ) {
          val = -dy;
        } else if (angle_x > QUARTER_PI  && angle_x < (QUARTER_PI + HALF_PI)  ) {
          val = +dy;
        }

        if (translate_x_pressed) {

          x += val;
        }

        if (scale_x_pressed) {
          w += val;
          w = constrain(w, 1, 1000);
        }
      }

      // *************** Y AXIS ***************

      if (y_pressed) {

        float val = angle_y * dy;

        if (translate_y_pressed) {
          y -=val;
        }

        if (scale_y_pressed) {
          h += val;
          h = constrain(h, 1, 1000);
        }
      }

      // *************** Z AXIS ***************


      if (z_pressed) {

        float val = 0;

        if (abs(angle_z) < QUARTER_PI) {
          val = dx;
        } else if (abs(angle_z) > HALF_PI + QUARTER_PI) {
          val = -dx;
        } else if (angle_z < -QUARTER_PI  && angle_z > -(QUARTER_PI + HALF_PI)  ) {
          val = -dy;
        } else if (angle_z > QUARTER_PI  && angle_z < (QUARTER_PI + HALF_PI)  ) {
          val = +dy;
        }

        if (translate_z_pressed) {

          z += val;
        }

        if (scale_z_pressed) {
          d += val;
          d = constrain(d, 1, 1000);
        }
      }
    }


    preparePanelText();
  }

  //•••••••••••••••••••••••••••••••••••••

  void asignColors() {

    cube_color = picker.getNewColor();
    translate_x_color = picker.getNewColor();
    translate_y_color = picker.getNewColor();
    translate_z_color = picker.getNewColor();
    scale_x_color = picker.getNewColor();
    scale_y_color = picker.getNewColor();
    scale_z_color = picker.getNewColor();
    info_color = picker.getNewColor();
  }

  //•••••••••••••••••••••••••••••••••••••

  void checkHovers() {

    color aux = picker.readColor(mouseX + offset_x, mouseY + offset_y);

    if (aux == cube_color)
      cube_hover = true;
    else cube_hover = false;

    if (aux == translate_x_color)
      translate_x_hover = true;
    else
      translate_x_hover = false;
    if (aux == translate_y_color)
      translate_y_hover = true;
    else
      translate_y_hover = false;
    if (aux == translate_z_color)
      translate_z_hover = true;
    else
      translate_z_hover = false;
    if (aux == scale_x_color)
      scale_x_hover = true;
    else
      scale_x_hover = false;
    if (aux == scale_y_color)
      scale_y_hover = true;
    else
      scale_y_hover = false;
    if (aux == scale_z_color)
      scale_z_hover = true;
    else
      scale_z_hover = false;

    if (aux == info_color)
      info_hover = true;
    else
      info_hover = false;
  }


  //•••••••••••••••••••••••••••••••••••••

  boolean checkMouse() {

    boolean aux = false;


    if (translate_x_hover)
      translate_x_pressed = aux = true;

    else
      translate_x_pressed = false;
    if (translate_y_hover)
      translate_y_pressed  = aux = true;
    else
      translate_y_pressed = false;
    if (translate_z_hover)
      translate_z_pressed = aux = true;
    else
      translate_z_pressed = false;
    if (scale_x_hover) 
      scale_x_pressed  = aux = true;
    else
      scale_x_pressed = false;
    if (scale_y_hover)
      scale_y_pressed  = aux = true;
    else
      scale_y_pressed = false;
    if (scale_z_hover)
      scale_z_pressed  = aux = true;
    else
      scale_z_pressed = false;


    if (info_hover)
      display_info  = ! display_info;


    something_pressed = aux;


    if (cube_hover && !active)
      active = true;
    else if (cube_hover && active)
      active = false;


    if (scale_x_pressed || translate_x_pressed) {

      x_pressed = true;
    }
    if (scale_y_pressed || translate_y_pressed) {

      y_pressed = true;
    }
    if (scale_z_pressed || translate_z_pressed) {

      z_pressed = true;
    }


    if (info.checkMouse()) {

      display_info = false;
    }

    return aux;
  }

  //•••••••••••••••••••••••••••••••••••••

  void release() {
    translate_x_pressed = false;
    translate_y_pressed = false;
    translate_z_pressed = false;

    scale_x_pressed = false;
    scale_y_pressed = false;
    scale_z_pressed = false;

    x_pressed = false;
    y_pressed = false;
    z_pressed = false;

    aux_dist = 0;
    something_pressed = false;
  }

  //•••••••••••••••••••••••••••••••••••••


  void render2dArrows(PGraphics g) {

    pushMatrix();
    translate(500, 500);

    pushStyle();
    fill(255, 188, 3);
    noStroke();
    ellipse(cube_2d.x, cube_2d.y, 10, 10);

    fill(0, 255, 0);
    ellipse(x_arrow_2d.x, x_arrow_2d.y, 10, 10);
    fill(0, 0, 255);
    ellipse(y_arrow_2d.x, y_arrow_2d.y, 10, 10);
    fill(255, 0, 0);
    ellipse(z_arrow_2d.x, z_arrow_2d.y, 10, 10);

    stroke(0, 255, 0);
    line(cube_2d.x, cube_2d.y, x_arrow_2d.x, x_arrow_2d.y );
    stroke(0, 0, 255);
    line(cube_2d.x, cube_2d.y, y_arrow_2d.x, y_arrow_2d.y ); 
    stroke(255, 0, 0);
    line(cube_2d.x, cube_2d.y, z_arrow_2d.x, z_arrow_2d.y );


    noStroke();
    fill(0, 128);
    String ang = str(int(degrees(angle_x)));
    rect(x_arrow_2d.x-3, x_arrow_2d.y + 3, textWidth(ang)+6, -20);
    fill(255);
    text(ang, x_arrow_2d.x, x_arrow_2d.y);

    fill(0, 128);
    ang = str(int(degrees(angle_y)));
    rect(y_arrow_2d.x-3, y_arrow_2d.y + 3, textWidth(ang)+6, -20);
    fill(255);
    text(ang, y_arrow_2d.x, y_arrow_2d.y);

    fill(0, 128);
    ang = str(int(degrees(angle_z)));
    rect(z_arrow_2d.x-3, z_arrow_2d.y + 3, textWidth(ang)+6, -20);
    fill(255);
    text(ang, z_arrow_2d.x, z_arrow_2d.y);

    popMatrix();

    popStyle();
  }


  //•••••••••••••••••••••••••••••••••••••

  void render(PGraphics g) {

    g.pushStyle();

    // g.background(20);

    // g.lights();

    // g.translate(render.width/2, render.height/2, 0);

    //  g.rotateX(radians(rot_x));

    // g.rotateY(radians(rot_y));

    g.pushMatrix();

    g.translate(x, y, z);


    if (active)
      g.fill(co);
    else
      g.noFill();

    g.stroke(128, 128, 0);

    g.strokeWeight(2);

    g.box(w, h, d);

    if (active) {

      //g.fill(2, 190, 198, 128);

      g.stroke(2, 190, 198, 128);

      g.strokeWeight(1);

      if (translate_x_pressed)

        g.fill(pressed);

      else if (translate_x_hover)

        g.fill(hover);

      else 

      g.fill(0, 255, 0, 50);

      g.pushMatrix();

      g.rotateZ(HALF_PI);

      g.translate(0, - w/2 - spacer, 0);


      renderArrow(g);

      g.pushMatrix();

      g.rotateY(HALF_PI);

      renderArrow(g);

      g.popMatrix();



      if (scale_x_pressed)

        g.fill(pressed);

      else if (scale_x_hover)

        g.fill(hover);

      else

        g.fill(0, 255, 0, 50);

      renderScaleHandle(g);
      g.pushMatrix();

      g.rotateY(HALF_PI);

      renderScaleHandle(g);

      g.popMatrix();

      g.popMatrix();


      if (translate_y_pressed)

        g.fill(pressed);

      else if (translate_y_hover)

        g.fill(hover);

      else 

      g.fill(0, 0, 255, 50);

      g.pushMatrix();

      g.translate(0, - h/2 - spacer, 0);

      renderArrow(g);

      g.pushMatrix();

      g.rotateY(HALF_PI);

      renderArrow(g);

      g.popMatrix();

      if (scale_y_pressed)

        g.fill(pressed);
      else if (scale_y_hover)

        g.fill(hover);
      else

        g.fill(0, 0, 255, 50);

      renderScaleHandle(g);
      g.pushMatrix();

      g.rotateY(HALF_PI);

      renderScaleHandle(g);

      g.popMatrix();

      g.popMatrix();

      if (translate_z_pressed)

        g.fill(pressed); 

      else if (translate_z_hover)

        g.fill(hover);

      else 

      g.fill(255, 0, 0, 50);


      g.pushMatrix();

      g.rotateX(- HALF_PI);

      g.translate(0, - d/2 - spacer, 0);

      renderArrow(g);

      g.pushMatrix();

      g.rotateY(HALF_PI);

      renderArrow(g);

      g.popMatrix();

      if (scale_z_pressed)

        g.fill(pressed);

      else if (scale_z_hover)

        g.fill(hover);

      else

        g.fill(255, 0, 0, 50);

      renderScaleHandle(g);

      g.pushMatrix();

      g.rotateY(HALF_PI);

      renderScaleHandle(g);

      g.popMatrix();

      g.popMatrix();

      g.pushMatrix();

      g.translate(20, -h/2 - 20, 0);

      g.rotateY(radians(-rot_x));

      g.fill(32, 229, 211, 128);

      //  g.ellipse(0, 0, 10, 10);

      g.noStroke();



      g.shape(info_svg);



      g.popMatrix();
    }
    g.popMatrix();

    g.popStyle();
  }



  //•••••••••••••••••••••••••••••••••••••

  void renderBuffer(PGraphics g) {

    g.pushMatrix();

    g.translate(render.width/2, render.height/2, 0);

    g.rotateX(radians(rot_y));
    g.rotateY(radians(rot_x));

    g.translate(x, y, z);


    g.fill(cube_color);

    g.box(w, h, d);

    if (active) {

      g.fill(translate_y_color);

      g.pushMatrix();

      g.translate(0, - h/2 - spacer, 0);

      renderArrow(g);

      g.pushMatrix();

      g.rotateY(HALF_PI);

      renderArrow(g);

      g.popMatrix();


      g.fill(scale_y_color);

      renderScaleHandle(g);

      g.pushMatrix();

      g.rotateY(HALF_PI);

      renderScaleHandle(g);

      g.popMatrix();

      g.popMatrix();

      g.fill(translate_x_color);

      g.pushMatrix();

      g.rotateZ(HALF_PI);

      g.translate(0, - w/2 - spacer, 0);

      g.beginShape();

      renderArrow(g);

      g.pushMatrix();

      g.rotateY(HALF_PI);

      renderArrow(g);

      g.popMatrix();


      g.endShape(CLOSE);

      g.fill(scale_x_color);

      renderScaleHandle(g);

      g.pushMatrix();

      g.rotateY(HALF_PI);

      renderScaleHandle(g);

      g.popMatrix();

      g.popMatrix();

      g.fill(translate_z_color);

      g.pushMatrix();

      g.rotateX(- HALF_PI);

      g.translate(0, - d/2 - spacer, 0);

      renderArrow(g);

      g.pushMatrix();

      g.rotateY(HALF_PI);

      renderArrow(g);

      g.popMatrix();

      g.fill(scale_z_color);

      renderScaleHandle(g);

      g.pushMatrix();

      g.rotateY(HALF_PI);

      renderScaleHandle(g);

      g.popMatrix();

      g.popMatrix();

      g.pushMatrix();

      g.translate(20, -h/2 - 20, 0);

      g.rotateY(radians(-rot_x));

      g.fill(info_color);

      //  g.ellipse(0, 0, 10, 10);

      g.noStroke();



      g.shape(info_svg);



      g.popMatrix();
    }

    g.popMatrix();
  }

  //•••••••••••••••••••••••••••••••••••••

  void reset() {
    w = 50;
    h = 50;
    d = 50;
    x = 0;
    y = 0;
    z = 0;
  }

  //•••••••••••••••••••••••••••••••••••••

  void renderArrow(PGraphics g) {

    g.beginShape();

    g.vertex(-arrow_width/2, 0, 0);
    g.vertex(arrow_width/2, 0, 0);
    g.vertex(arrow_width/2, -arrow_length*0.8, 0);
    g.vertex(arrow_width, -arrow_length*0.8, 0);
    g.vertex(0, -arrow_length, 0);
    g.vertex(-arrow_width, -arrow_length*0.8, 0);
    g.vertex(-arrow_width/2, -arrow_length*0.8, 0);

    g.endShape(CLOSE);
  }

  //•••••••••••••••••••••••••••••••••••••

  void renderScaleHandle(PGraphics g) {

    g.ellipse(0, -(arrow_length + 10), arrow_width, arrow_width);
  }

  //•••••••••••••••••••••••••••••••••••••

  int getSign(float f) {

    int ret = 1;

    if (f < 0)
      ret = -1;


    return ret;
  }

  //•••••••••••••••••••••••••••••••••••••

  void setOffset (int x_, int y_ ) {

    offset_x = x_;
    offset_y = y_;
  }

  //•••••••••••••••••••••••••••••••••••••

  void manageInfoPanel() {


    if (display_info) {

      info.render();

      // fill(255);

      stroke(237, 164, 17, 90);

      dashedLine(cube_2d.x + 600 + offset_x, cube_2d.y + offset_y, info.x, info.y + info.h/2, 5 );


      //  ellipse(cube_2d.x + 600 + offset_x , cube_2d.y + offset_y, 20,20);
    }
  }

  //•••••••••••••••••••••••••••••••••••••

  void countPointsContained() {

    points_contained = 0;

    for (int i = 0; i < p.size(); i++) {

      if (p.get(i).x > x - w/2 && p.get(i).x < x + w/2 && p.get(i).y > y - h/2 && p.get(i).y < y + h/2 && p.get(i).z > z - d/2 && p.get(i).z < z + d/2) {

        points_contained ++;
      }
    }
  }
  
  //•••••••••••••••••••••••••••••••••••••

  void preparePanelText() {
    String [] info_text = new String[0];

    String aux = "x (long): " +  map(x, - cube_side/2,  cube_side/2, c.min_lon_deg, c.max_lon_deg) + "°";

    info_text = append(info_text, aux);

    aux = "y (prof): " +  map(y, - cube_side/2,  cube_side/2, c.min_prof_map, c.max_prof_map)+  " Km";

    info_text = append(info_text, aux);

    aux = "z (lat): " + map(z, - cube_side/2,  cube_side/2, c.max_lat_deg, c.min_lat_deg)  + "°" ;

    info_text = append(info_text, aux);

    aux = "width: " + map(w, 0, 400, 0, kms_per_side) +  " Km";

    info_text = append(info_text, aux);

    aux = "height: " + map(h, 0, 400, 0, kms_per_side) +  " Km";

    info_text = append(info_text, aux);

    aux = "depth: " + map(d, 0, 400, 0, kms_per_side) +  " Km";

    info_text = append(info_text, aux);

    aux = "points inside: " + points_contained;

    info_text = append(info_text, aux);

    info.setText(info_text);
  }
  
  //•••••••••••••••••••••••••••••••••••••
}