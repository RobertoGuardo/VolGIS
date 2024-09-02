//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void drawHelperGuides() {
  render.pushStyle();
  render.strokeWeight(1);
  // ------ Y AXIS ----

  render.fill(0, 255, 0);
  render.noStroke();
  render.pushMatrix();
  render.translate(0, -300, 0);
  //render.text("Y", 10, 0);
  render.text("Z", 10, 0);
  render.popMatrix();
  render.stroke(0, 255, 0);
  render.line(0, -400, 0, 400);

  // ------ X AXIS ----

  render.fill(255, 0, 0);
  render.noStroke();
  render.pushMatrix();
  render.translate(300, 0, 0);
  render.rotateX(radians(-rot_y));
  render.text("X", 0, -10);
  render.fill(255, 129, 3);
  render.text("EAST", 0, -40);
  render.text("WEST", -600, -40);
  render.popMatrix();
  render.stroke(255, 0, 0);
  render.line(-400, 0, 400, 0);

  // ------ Z AXIS ----

  render.fill(0, 0, 255);
  render.noStroke();
  render.pushMatrix();
  render.translate(0, 0, 300);
  render.rotateY(radians(90));
  render.rotateX(radians(-rot_y));
  //render.text("Z", 0, -10);
  render.text("Y", 0, -10);
  render.fill(255, 129, 3);
  render.text("SOUTH", 0, -40);
  render.text("NORTH", 600, -40);
  render.popMatrix();
  render.stroke(0, 0, 255);
  render.line(0, 0, -400, 0, 0, 400);

  render.noStroke();
  render.fill(200, 90);
  render.sphere(5);
  render.popStyle();
}

//••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

void drawNorthArrow() {

  render.pushStyle();
  render.pushMatrix();
  render.translate(0, 0, -300);
  render.rotateX(HALF_PI);
  render.strokeWeight(2);
  render.stroke(32, 229, 211);
  render.noFill();
  render.beginShape();
  render.vertex(0, 0);
  render.vertex(-15, 10);
  render.vertex(0, -30);
  render.endShape(CLOSE);
  render.fill(32, 229, 211);
  render.beginShape();
  render.vertex(0, 0);
  render.vertex(15, 10);
  render.vertex(0, -30);
  render.endShape(CLOSE);
  render.textAlign(CENTER, CENTER);
  render.text("N", 0, 25);
  render.popMatrix();
  render.popStyle();
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
void drawSeaPlane() {
  render.pushStyle();
  render.pushMatrix();
  render.rotateX(radians(-90));
  render.translate(0, 0, c.sea_level/2);
  //render.clip(-100, -100, 250, 250);
  //render.translate(0, 0, 0);
  render.noStroke();
  render.fill(0, 207, 224);
  //render.rect(-250, -250, 500, 500);
  render.rect(-100, -100, 250, 250);
  render.popMatrix();
  render.popStyle();
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void drawBoundingCube() {
  render.pushStyle();
  render.stroke(255);
  render.strokeWeight(5);
  render.noFill();
  render.box(cube_side);
  render.popStyle();
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void drawDivisions() {
  render.pushStyle();
  render.stroke(255);
  render.strokeWeight(1);
  render.noFill();
  render.pushMatrix();
  render.translate(-cube_side/2, cube_side/2, cube_side/2);

  // ------ VERTICAL DIVISIONS ----

  render.pushMatrix();
  for (int j = 0; j  <= divisions; j ++ ) {
    for (int i = 0; i <= divisions; i ++ ) {
      render.line(i*division_side, 0, i*division_side, -cube_side);
    }
    render.translate(0, 0, -division_side);
  }
  render.popMatrix();

  // ------ HORIZONTAL DIVISIONS ----

  render.pushMatrix();
  for (int j = 0; j  <= divisions; j ++ ) {
    for (int i = 0; i <= divisions; i ++ ) {
      render.line(0, -i*division_side, cube_side, -i*division_side) ;
    }
    render.translate(0, 0, -division_side);
  }
  render.popMatrix();

  // ------ DEPTH DIVISIONS ----

  render.pushMatrix();
  for (int j = 0; j  <= divisions; j ++ ) {
    for (int i = 0; i <= divisions; i ++ ) {
      render.line(0, -i*division_side, 0, 0, -i*division_side, -cube_side) ;
    }
    render.translate(division_side, 0, 0);
  }
  render.popMatrix();

  render.popMatrix();
  render.popStyle();
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void drawGradientDivisions() {
  render.pushStyle();
  render.colorMode(HSB, 360, 100, 100, 100);
  int hue1 = 217;
  int hue2 = 161;
  int alfa = 50;
  render.strokeWeight(1);
  render.noFill();
  render.pushMatrix();
  render.translate(-cube_side/2, cube_side/2, cube_side/2);

  // ------ VERTICAL DIVISIONS ----

  render.pushMatrix();
  for (int j = 0; j  <= divisions; j ++ ) {
    float h = map(j, 0, divisions, hue1, hue2);
    render.stroke(h, 100, 100, alfa);
    for (int i = 0; i <= divisions; i ++ ) {
      render.line(i*division_side, 0, i*division_side, -cube_side);
    }
    render.translate(0, 0, -division_side);
  }
  render.popMatrix();

  render.stroke(255);

  // ------ HORIZONTAL DIVISIONS ----


  hue1 = 58;
  hue2 = 16;

  render.pushMatrix();
  for (int j = 0; j  <= divisions; j ++ ) {
    float h = map(j, 0, divisions, hue1, hue2);
    render.stroke(h, 100, 100, alfa);
    for (int i = 0; i <= divisions; i ++ ) {
      render.line(0, -i*division_side, cube_side, -i*division_side) ;
    }
    render.translate(0, 0, -division_side);
  }
  render.popMatrix();

  // ------ DEPTH DIVISIONS ----

  render.stroke(255);

  hue1 = 306;
  hue2 = 260;

  render.pushMatrix();
  for (int j = 0; j  <= divisions; j ++ ) {
    float h = map(j, 0, divisions, hue1, hue2);
    render.stroke(h, 100, 100, alfa);
    for (int i = 0; i <= divisions; i ++ ) {
      render.line(0, -i*division_side, 0, 0, -i*division_side, -cube_side) ;
    }
    render.translate(division_side, 0, 0);
  }  
  render.popMatrix();

  render.popMatrix();
  render.popStyle();
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void drawSingleDivision(int index) {

  render.pushStyle();
  render.stroke(255);
  render.strokeWeight(3);
  render.fill(0, 252, 221);
  render.noFill();
  render.pushMatrix();
  render.translate(-cube_side/2, -cube_side/2, -cube_side/2);
  // zero point

  int acum = 0;
  int x_acum = 0;
  int y_acum = 0;
  int z_acum = 0;


  for (int i = 0; i < divisions; i++ ) {  // Y Y Y Y Y Y 
    for (int j = 0; j < divisions; j++ ) {  // Z Z Z Z Z Z
      for (int k = 0; k < divisions; k++ ) {  // X X X X X X
        if (acum == index) {
          render.translate(division_side*k, division_side*i, division_side*j);
        }
        acum++;
      }
    }
  }


  render.translate(division_side/2, division_side/2, division_side/2);
  render.box(division_side);
  render.popStyle();
  render.popMatrix();
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void  analyzeDensity() {
  render.pushStyle();
  render.stroke(255);
  render.strokeWeight(3);
  render.fill(0, 255, 0);
  render.noFill();
  render.pushMatrix();
  render.translate(-cube_side/2, -cube_side/2, -cube_side/2);


  // zero point

  int acum = 0;
  int x_acum = 0;
  int y_acum = 0;
  int z_acum = 0;

  //  int density_high_thresh = 3;

  //  int density_low_thresh = 1;


  for (int i = 0; i < divisions; i++ ) {  // Y Y Y Y Y Y 
    for (int j = 0; j < divisions; j++ ) {  // Z Z Z Z Z Z
      for (int k = 0; k < divisions; k++ ) {  // X X X X X X
        // render.translate(division_side*k, division_side*i, division_side*j);
        int count = countPoints(k, i, j);
        if (menu.getToggleState("Analyze maxima")) {
          if (count >= density_high_thresh ) {
            render.stroke(255, 0, 0);
            render.noFill();
            render.pushMatrix();
            render.translate(division_side*k, division_side*i, division_side*j);
            render.translate(division_side/2, division_side/2, division_side/2);
            render.box(division_side);
            render.popMatrix();
          }
        }  
        if (menu.getToggleState("Analyze minima")) {
          if (count < density_low_thresh ) {
            render.stroke(0, 255, 0);
            render.noFill();
            render.pushMatrix();
            render.translate(division_side*k, division_side*i, division_side*j);
            render.translate(division_side/2, division_side/2, division_side/2);
            render.box(division_side);
            render.popMatrix();
          }
          // acum++;
        }
      }
    }
  }

  //render.box(division_side);
  render.popStyle();
  render.popMatrix();
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

int countPoints(int x_r, int y_r, int z_r) {


  float x = -cube_side/2 + (x_r * division_side);
  float y = -cube_side/2 + (y_r * division_side);
  float z = -cube_side/2 + (z_r * division_side);

  int acum = 0;

  for (int i = 0; i < p.size(); i++) {

    PVector pos =  p.get(i).getPosition();

    if (pos.x > x  && pos.x < x + division_side) {
      if (pos.y > y  && pos.y < y + division_side) {
        if (pos.z > z  && pos.z < z + division_side) {
          acum++;
        }
      }
    }
  }

  return acum;
}