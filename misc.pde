//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void handleConsole() {

  pushMatrix();
  pushStyle();

  translate(20, 870);
  textFont(ui_font);
  textAlign(LEFT, TOP);

  noStroke();

  String aux = "Km. per side : " +  int(kms_per_side);
  fill(200);
  text(aux, 0, 5);

  aux = "Km per division : " +  (kms_per_side / divisions);
  fill(200);
  text(aux, 0, 20);

  aux = "m per division : " +  ((kms_per_side / divisions) * 1000);
  fill(200);
  text(aux, 0, 35);

  aux = ("Cubos resultantes : " +  int(cubes));
  fill(200);
  text(aux, 0, 50);

  translate(0, 65);

  aux = "Cantidad de puntos : " +  p.size();
  fill(200);
  text(aux, 0, 5);

  aux = "Punto seleccionado : " +  point_select;
  fill(200);
  text(aux, 0, 20);

  popMatrix();
  popStyle();
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void loadExternal() {
  font = loadFont("Futura-Medium-24.vlw");
  ui_font = loadFont("quick10.vlw");

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ Original Dataset  
  //table_clean = loadTable("Etnaeq_2000_2016_1-10.csv", "header"); // Etna events from 2000 to 2016, from -3 to 10 km b.s.l. with errors
  table_clean = loadTable("Etnaeq_2000_2016_1-10_0,5 - dupli.csv", "header"); // Etna events from 2000 to 2016, erh and erz <= 0.5
  //table_clean = loadTable("Etnaeq_2000_2016_1-10_0,4.csv", "header"); // Etna events from 2000 to 2016, erh and erz <= 0.4

  
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ StabilityCheck  10% Less from the total
  //table_clean = loadTable("10PercentLess/Etnaeq_2000_2016_1-10_0,5 - 10p_1.csv", "header"); // Etna events (erh and erz <= 0.5) without 10% random events 1st iteration
  //table_clean = loadTable("10PercentLess/Etnaeq_2000_2016_1-10_0,5 - 10p_2.csv", "header"); // Etna events (erh and erz <= 0.5) without 10% random events 2nd iteration
  //table_clean = loadTable("10PercentLess/Etnaeq_2000_2016_1-10_0,5 - 10p_3.csv", "header"); // Etna events (erh and erz <= 0.5) without 10% random events 3rd iteration
  //table_clean = loadTable("10PercentLess/Etnaeq_2000_2016_1-10_0,5 - 10p_4.csv", "header"); // Etna events (erh and erz <= 0.5) without 10% random events 4th iteration
  //table_clean = loadTable("10PercentLess/Etnaeq_2000_2016_1-10_0,5 - 10p_5.csv", "header"); // Etna events (erh and erz <= 0.5) without 10% random events 5th iteration
  //table_clean = loadTable("10PercentLess/Etnaeq_2000_2016_1-10_0,5 - 10p_6.csv", "header"); // Etna events (erh and erz <= 0.5) without 10% random events 6th iteration
  //table_clean = loadTable("10PercentLess/Etnaeq_2000_2016_1-10_0,5 - 10p_7.csv", "header"); // Etna events (erh and erz <= 0.5) without 10% random events 7th iteration
  //table_clean = loadTable("10PercentLess/Etnaeq_2000_2016_1-10_0,5 - 10p_8.csv", "header"); // Etna events (erh and erz <= 0.5) without 10% random events 8th iteration
  //table_clean = loadTable("10PercentLess/Etnaeq_2000_2016_1-10_0,5 - 10p_9.csv", "header"); // Etna events (erh and erz <= 0.5) without 10% random events 9th iteration
  //table_clean = loadTable("10PercentLess/Etnaeq_2000_2016_1-10_0,5 - 10p_10.csv", "header"); // Etna events (erh and erz <= 0.5) without 10% random events 10th iteration
  
  
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ StabilityCheck  20% Less from the total
  //table_clean = loadTable("20PercentLess/Etnaeq_2000_2016_1-10_0,5 - 20p_1.csv", "header"); // Etna events (erh and erz <= 0.5) without 20% random events 1st iteration
  //table_clean = loadTable("20PercentLess/Etnaeq_2000_2016_1-10_0,5 - 20p_2.csv", "header"); // Etna events (erh and erz <= 0.5) without 20% random events 2nd iteration
  //table_clean = loadTable("20PercentLess/Etnaeq_2000_2016_1-10_0,5 - 20p_3.csv", "header"); // Etna events (erh and erz <= 0.5) without 20% random events 3rd iteration
  //table_clean = loadTable("20PercentLess/Etnaeq_2000_2016_1-10_0,5 - 20p_4.csv", "header"); // Etna events (erh and erz <= 0.5) without 20% random events 4th iteration
  //table_clean = loadTable("20PercentLess/Etnaeq_2000_2016_1-10_0,5 - 20p_5.csv", "header"); // Etna events (erh and erz <= 0.5) without 20% random events 5th iteration
  //table_clean = loadTable("20PercentLess/Etnaeq_2000_2016_1-10_0,5 - 20p_6.csv", "header"); // Etna events (erh and erz <= 0.5) without 20% random events 6th iteration
  //table_clean = loadTable("20PercentLess/Etnaeq_2000_2016_1-10_0,5 - 20p_7.csv", "header"); // Etna events (erh and erz <= 0.5) without 20% random events 7th iteration
  //table_clean = loadTable("20PercentLess/Etnaeq_2000_2016_1-10_0,5 - 20p_8.csv", "header"); // Etna events (erh and erz <= 0.5) without 20% random events 8th iteration
  //table_clean = loadTable("20PercentLess/Etnaeq_2000_2016_1-10_0,5 - 20p_9.csv", "header"); // Etna events (erh and erz <= 0.5) without 20% random events 9th iteration
  //table_clean = loadTable("20PercentLess/Etnaeq_2000_2016_1-10_0,5 - 20p_10.csv", "header"); // Etna events (erh and erz <= 0.5) without 20% random events 10th iteration
  
  
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ StabilityCheck  40% Less from the total
  //table_clean = loadTable("40PercentLess/Etnaeq_2000_2016_1-10_0,5 - 40p_1.csv", "header"); // Etna events (erh and erz <= 0.5) without 40% random events 1st iteration
  //table_clean = loadTable("40PercentLess/Etnaeq_2000_2016_1-10_0,5 - 40p_2.csv", "header"); // Etna events (erh and erz <= 0.5) without 40% random events 2nd iteration
  //table_clean = loadTable("40PercentLess/Etnaeq_2000_2016_1-10_0,5 - 40p_3.csv", "header"); // Etna events (erh and erz <= 0.5) without 40% random events 3rd iteration
  //table_clean = loadTable("40PercentLess/Etnaeq_2000_2016_1-10_0,5 - 40p_4.csv", "header"); // Etna events (erh and erz <= 0.5) without 40% random events 4th iteration
  //table_clean = loadTable("40PercentLess/Etnaeq_2000_2016_1-10_0,5 - 40p_5.csv", "header"); // Etna events (erh and erz <= 0.5) without 40% random events 5th iteration
  //table_clean = loadTable("40PercentLess/Etnaeq_2000_2016_1-10_0,5 - 40p_6.csv", "header"); // Etna events (erh and erz <= 0.5) without 40% random events 6th iteration
  //table_clean = loadTable("40PercentLess/Etnaeq_2000_2016_1-10_0,5 - 40p_7.csv", "header"); // Etna events (erh and erz <= 0.5) without 40% random events 7th iteration
  //table_clean = loadTable("40PercentLess/Etnaeq_2000_2016_1-10_0,5 - 40p_8.csv", "header"); // Etna events (erh and erz <= 0.5) without 40% random events 8th iteration
  //table_clean = loadTable("40PercentLess/Etnaeq_2000_2016_1-10_0,5 - 40p_9.csv", "header"); // Etna events (erh and erz <= 0.5) without 40% random events 9th iteration
  //table_clean = loadTable("40PercentLess/Etnaeq_2000_2016_1-10_0,5 - 40p_10.csv", "header"); // Etna events (erh and erz <= 0.5) without 40% random events 10th iteration
  

  
  
  info_svg = loadShape("info.svg");
  
  info_svg.disableStyle();
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ // initial values  ---> Moved to "config_variables"

//void initRender() {
//  render = createGraphics(1000, 1000, P3D);
//  render.beginDraw();
//  render.textFont(font);
//  render.endDraw();

//  delta_pan_y = 0;
//  delta_pan_x = 0 ;
  
//  // Centered on the center of the area
//  //pan_x = render.width/2;        //intial X position of the camera
//  //pan_y = render.height/2;  //intial Y position of the camera


//  // centered on the tomography
//  //pan_x = render.width/2 - 1;        //intial X position of the camera
//  //pan_y = render.height/2 - 39;  //intial Y position of the camera
//}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void computePoints() {

  c.searchMaxMins();

  p = new ArrayList();

  createPoints();

  createIsoPoints();
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void checkCropValues() {

  if (float(menu.getTextboxCont("min. long")) < returnWithTwoDecimals(c.min_lon_deg) || float(menu.getTextboxCont("min. long")) > returnWithTwoDecimals(c.max_lon_deg) ) {
    if (!menu.getTextboxFocus("min. long")) {
      menu.setBoxText("min. long", str(c.min_lon_deg));
    }
  }
  if (float(menu.getTextboxCont("max. long")) > returnWithTwoDecimals(c.max_lon_deg) || float(menu.getTextboxCont("max. long")) < returnWithTwoDecimals(c.min_lon_deg) ) {
    if (!menu.getTextboxFocus("max. long")) {
      menu.setBoxText("max. long", str(c.max_lon_deg));
    }
  }
  if (float(menu.getTextboxCont("min. lat")) < returnWithTwoDecimals(c.min_lat_deg) || float(menu.getTextboxCont("min. lat")) > returnWithTwoDecimals(c.max_lat_deg)) {
    if (!menu.getTextboxFocus("min. lat")) {
      menu.setBoxText("min. lat", str(c.min_lat_deg));
    }
  }
  if (float(menu.getTextboxCont("max. lat")) > returnWithTwoDecimals(c.max_lat_deg)  || float(menu.getTextboxCont("max. lat")) < returnWithTwoDecimals(c.min_lat_deg) ) {
    if (!menu.getTextboxFocus("max. lat")) {
      menu.setBoxText("max. lat", str(c.max_lat_deg));
    }
  }

  c.setCropValues(float(menu.getTextboxCont("min. lat")), float( menu.getTextboxCont("max. lat")), float(menu.getTextboxCont("min. long")), float(menu.getTextboxCont("max. long")), float(menu.getTextboxCont("min. depth (Km)")), float(menu.getTextboxCont("max. depth (Km)"))) ;
}

//•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

float returnWithTwoDecimals(float val) {

  int aux = int(val * 100);

  float ret = (aux * 1.0) / 100;

  return ret;
}

//•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••          CROP BOX  

void renderCropBox() {
  render.pushStyle();
  render.stroke(0, 255, 255);
  render.strokeWeight(5);
  //render.fill(0, 207, 224); // NdRtn to create horizontal custom section !
  render.noFill(); // original
  render.pushMatrix();  
  render.translate(c.crop_center_x, c.crop_center_y, c.crop_center_z);
  render.strokeWeight(4);
  render.box(c.crop_w, c.crop_h, c.crop_d);
  render.sphere(2);
  render.popMatrix();
  render.popStyle();
}

//•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

void checkForViews() {

  if (key == '1') {
    rot_x = 0;
    rot_y = 0;
    resetting_cam = false;
    ruler.deactivate();

  } else if (key == '2') {
    rot_x = -90;
    rot_y = 0;
    resetting_cam = false;
    ruler.deactivate();
    
  } else if (key == '3') {
    rot_x = 0;
    rot_y = -90;
    resetting_cam = false;
    ruler.deactivate();
    
  } else if (key == '6') {
    rot_x = 0;
    rot_y = 90;
    resetting_cam = false;
    ruler.deactivate();
    
  }
}

//•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

void updateMenuInfo() {



  menu.setInfoText("Meters per side:", str(kms_per_side * 1000));
  menu.setInfoText("Meters per division:", str((kms_per_side * 1000)/divisions));
  menu.setInfoText("Number of events (CropBox):", p.size() + " (" +  getCroppedAmmount() + ")");
}

int getCroppedAmmount() {

  int ret = 0;


  if (menu.getToggleState("Crop box")) {
    float x_min = c.crop_center_x - c.crop_w/2;
    float x_max = c.crop_center_x + c.crop_w/2;
    float y_min = c.crop_center_y - c.crop_h/2;
    float y_max = c.crop_center_y + c.crop_h/2;
    float z_min = c.crop_center_z - c.crop_d/2;
    float z_max = c.crop_center_z + c.crop_d/2;

    for (int i = 0; i < p.size(); i++) {

      if (p.get(i).x > x_min && p.get(i).x < x_max && p.get(i).y > y_min && p.get(i).y < y_max && p.get(i).z > z_min && p.get(i).z < z_max)
        ret++;
   
    }
    
  }



  return ret;
}

//•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

void dashedLine(float x1, float y1, float x2, float y2, float dash_length ) {
  float steps = dist(x1, y1, x2, y2) / dash_length;
  for (int i = 0; i < steps - 1; i +=2 ) {
    float xa = lerp(x1, x2, i/steps);
    float ya = lerp(y1, y2, i/steps);
    float xb = lerp(x1, x2, (i + 1)/steps);
    float yb = lerp(y1, y2, (i + 1)/steps);
    line(xa, ya, xb, yb);
  }
}

//•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

boolean checkRulerRequisites(){
  
  boolean aux = true;
  
  if(!menu.getToggleState("Ortho"))
    aux = false;
  if(rot_x != 0 && rot_x != -90)
    aux = false;
  if(rot_y != 0 && rot_y != -90)
    aux = false;
    
  return aux;
}
