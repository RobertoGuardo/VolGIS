////////////////////////////////////////////////////////////////////////////////////
//          VolGIS - A new volcano-oriented Geographic Information System         //
//                       A Project made by Roberto Guardo                         //
////////////////////////////////////////////////////////////////////////////////////

// VolGIS CC - BY (Roberto Guardo) - NC - SA [More info at https://creativecommons.org/licenses/]  
// 
//
// Directed by:
//    Roberto Guardo
//    Carola Dreidemie (Laboratorio de ID+i en Visualización, Computación Gráfica y Código Creativo - UNRN)
//
//
// Coded by:
//    Roberto Guardo    day 0 --> ongoin
//    Carola Dreidemie  06/2016 --> ongoin
//    Ariel Uzal        06/2016 --> 04/2017
//    Fernán Inchaurza  04/2018 --> 02/2020
//    
//  
// VolGIS 2018 Ver. 1.0 -- Presented at EGU2018 -- https://meetingorganizer.copernicus.org/EGU2018/EGU2018-221.pdf 
// 
// VolGIS 2018 Ver. 2.0 -- Presented at CoV10   -- https://www.citiesonvolcanoes10.com/wp-content/uploads/2018/08/S01.05-03-09-18-SiciliaDEF-3.pdf
//
// VolGIS 2020 Ver. 2.2 -- Published (This ver) -- https://www.frontiersin.org/articles/10.3389/feart.2020.589925/full

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//

/* 
 
 GRILLA_22
 
 + THE GICENTRE UTILS LIBRARY IS NECESSARY TO PROJECT THE MAP (http://www.gicentre.net/utils/)
 
 + NOTA: SI LOS PUNTOS SE GRAFICAN CON ESCALA MENOR, BUSCAR EL SIGUIENTE RENGLON EN EL CSV Y BORRARLO: 4/8/10,23:13:06.44,38.415,14.953,0.81,0.50
 
 --------------------------------------------------------------------------------------- 
 
 */
 
import org.gicentre.utils.spatial.*;    // Necessary to map projections.


UTM proj;

PShape info_svg;

PFont font;
PFont ui_font;
PFont quick;
int divisions = 5;
float division_side;
float cubes;
PGraphics render;

Table table;
Table table_clean;

ArrayList <Point> p;
int point_select = 0;

int delta_cam_x;
int delta_cam_y;

int delta_pan_y;
int delta_pan_x;

int pan_x;
int pan_y;

float rot_x = 0;
float rot_y = 0;
float zoom = 0;

boolean resetting_cam = false;
boolean mouse_cam;
boolean record;
float cam_lerp_control = 0;
float rot_x_aux;
float rot_y_aux;
float zoom_aux;

int select_index = 0;

IsoSurface iso;

PVector [] isopoints = new PVector [0];

Tomography t;

Menu menu;

Coord c;

boolean small_window = false;

Picker picker;
ArrayList <GumballCube> gumcubes;

Ruler ruler;

//+++++++++++++ Parameter for the orthoView
//float left = -width/2; 
//float right = width/2;
//float bottom = -height/2;
//float top = height/2;
float near;
float far;


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


void settings() {

  if (displayHeight < 1080 ) {
    small_window = true;
  }

  if (small_window) {

    size(1600, 720, P2D);
  } else {

    size(1600, 1000, P2D);
  }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void setup() {

  c = new Coord();

  loadExternal();  // carga las tablas y las tipografiasd

  Ellipsoid inter = new Ellipsoid(Ellipsoid.INTERNATIONAL);  // init libreria de proyeccion

  proj = new UTM(inter, 33, 'N'); // init libreria de proyeccion

  initRender();

  computePoints();  // analisis y creacion de terremotos

  resetCamera();


  picker = new Picker(render.width, render.height);  

  gumcubes = new ArrayList();

  t = new Tomography();  // carga y procesamiento de tomografias

  menu = new Menu(0, 20);  // a partir de aca, creacion de menu

 // menu.addSliderComplex("subdivisiones", 1, 200, 5, true); // Ori
  menu.addSliderComplex("Subdivisions", 1, 200, 99, true); // Events with ERH-ERZ <= 0,5
  menu.addInfo("Meters per side:");
  menu.addInfo("Meters per division:");
  menu.addInfo("Number of events (CropBox):");
  menu.addToggle("Show axis", false);
  menu.addToggle("Show grid", false);
  menu.addToggle("Show sea level", false);
  menu.addToggle("Gradient subdivisions", true);
  menu.addSeparator();
  //menu.addCamControl();
  menu.addToggle("Free movement", true);
  menu.addToggle("Reset Cam", false);
  menu.addSeparator();
  menu.addToggle("Analyze minima", false);
  menu.addSliderComplex("Minima threshold", 1, 50, 15, true);
  menu.addToggle("Analyze maxima", false);
  menu.addSliderComplex("Maxima threshold", 3, 50, 16, true);
  menu.addSeparator();
  menu.addToggle("Compute and show isoSurface", false);
  menu.addSliderComplex("Isosurface threshold", 0, 20, 0, false); //ori
  menu.addSeparator();
  menu.addToggle("Show earthquakes", true);
  menu.addSliderComplex("Magnitude threshold", 0, 10, 0, false); 

  menu.addSeparator();
  menu.addToggle("Crop box", false);
  menu.addToggle("Apply to isosurface", false);
  menu.addToggle("Add subcube", false);
  menu.addTextbox("min. long", true, str(c.min_lon_deg));    //14.95
  menu.addTextbox("max. long", true, str(c.max_lon_deg));    //15.15
  menu.addTextbox("min. lat", true, str(c.min_lat_deg));    //37.68
  menu.addTextbox("max. lat", true, str(c.max_lat_deg));    //37.78
  menu.addTextbox("min. depth (Km)", true, str(c.min_pro));  //-2
  menu.addTextbox("max. depth (Km)", true, str(c.max_pro));  //8
  /*----------------------------------------------------------------------------- EtnaCropBox
  menu.addTextbox("min. long", true, "14.95");
  menu.addTextbox("max. long", true, "15.15");
  menu.addTextbox("min. lat", true, "37.68");
  menu.addTextbox("max. lat", true, "37.78");
  menu.addTextbox("min. depth (Km)", true, "-2");
  menu.addTextbox("max. depth (Km)", true, "8");
  -------------------------------------------------------------------------------------------*/
  menu.addSeparator();
  menu.addToggle("Ortho", false);
  menu.addSeparator();
  menu.addToggle("Tomography Section", false);
  // menu.addToggle("Horizontal -2 b.s.l.", true); //ori
  menu.addToggle("Top layer", true);
  menu.addToggle("Horizontal -1 b.s.l.", false);
  menu.addToggle("Horizontal 0", false);
  menu.addToggle("Horizontal 1 b.s.l.", false);
  menu.addToggle("Horizontal 2 b.s.l.", false);
  menu.addToggle("Horizontal 3 b.s.l.", false);
  menu.addSeparator();
  menu.addToggle("Tomography Vertical Section", false);
  menu.addSeparator();
  menu.addToggle("Active rule", false);
  menu.setFont(ui_font);
  menu.calculateScroll();

  createIsoSurface();  // creacion de isosurface

  ruler = new Ruler();
  ruler.setFont(ui_font);

  println("\n••setup••end••\n");
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void draw() {
  
  if (record) {
    beginRecord("nervoussystem.obj.OBJExport", "VolGIS.obj");
  }
  
  surface.setTitle(str(frameRate));

  divisions = menu.getSliderValueInt("Subdivisions");
  division_side = (cube_side*1.0)/divisions;
  cubes = pow(divisions, 3); 

  if (menu.getSliderFlag("subdivisiones") || menu.getSliderFlag("Isosurface threshold") || menu.getToggleFlag("Compute and show isosurface")) {
    if (menu.getToggleState("Compute and show isosurface")) {
      createIsoSurface();
      menu.lowerToggleFlag("Compute and show isosurface");
    }
    
  }

  // 
  if (menu.getSliderValueInt("Minima threshold") > menu.getSliderValueInt("Maxima threshold")) {
    menu.setSliderValue("Maxima threshold", menu.getSliderValueInt("Minima threshold") + 1);
  }

  density_high_thresh = menu.getSliderValueInt("Maxima threshold");
  density_low_thresh = menu.getSliderValueInt("Minima threshold");

  if (mouseX > 300  && mouse_cam  && mouseButton == LEFT) {
    delta_cam_x = mouseX - pmouseX;
    delta_cam_y = mouseY - pmouseY;
  } else {
    delta_cam_x = 0;
    delta_cam_y = 0;
  }

  if (mouseX > 300  && mouse_cam  && mouseButton == RIGHT) {
    delta_pan_x = mouseX - pmouseX; 
    delta_pan_y = mouseY - pmouseY;
    //camera(mouseX, height/2, (height/2) / tan(PI/6), mouseX, height/2, 0, 0, 1, 0);
  } else {
    delta_pan_x = 0; 
    delta_pan_y = 0;
  }

  if (menu.getToggleState("Free movement")) {

    rot_x += delta_cam_x;
    rot_y -= delta_cam_y;
    pan_x -= delta_pan_x;
    pan_y -= delta_pan_y;
  }


  zoom += map(menu.getCamZoom(), -1, 1, -10, 10);

  zoom = constrain(zoom, 1, 4000);
  rot_x += map(menu.getCamPanX(), -1, 1, -2, 2);
  rot_y -= map(menu.getCamPanY(), -1, 1, -2, 2);

  rot_y = rot_y % 360;
  rot_x = rot_x % 360;

  picker.prepareBufferer();


  picker.setBufferCamera(pan_x, pan_y, zoom, pan_x, pan_y, 0.0, 
    0.0, 1.0, 0.0);
  for (int i = 0; i < gumcubes.size(); i ++) {
    gumcubes.get(i).renderBuffer(picker.buffer);
  }  


  picker.closeBuffer();

  for (int i = 0; i < gumcubes.size(); i ++) {
    gumcubes.get(i).checkHovers();
  } 
// ------------------------------------------------------------------------------          ORTHOGRAPHIC VIEW 
  render.beginDraw();                        
  if (menu.getToggleState("Ortho")) {
    //render.ortho();
    render.ortho(-cube_side/3, cube_side/3,-cube_side/3, cube_side/3);           //must correct the rule NdRtn
    picker.buffer.ortho();
  } else {
    render.perspective();
    picker.buffer.perspective();
  }
  render.lights();
  render.background(0);

  render.camera(pan_x, pan_y, zoom, pan_x, pan_y, 0.0, 0.0, 1.0, 0.0);

  render.pushMatrix();
  render.translate(render.width/2, render.height/2);
  render.rotateX(radians(rot_y));
  render.rotateY(radians(rot_x));

  if (menu.getToggleState("Show earthquakes")) {
    for (int i = 0; i < p.size(); i++) {

      if (p.get(i).mag >= menu.getSliderValue("Magnitude threshold")) {

        if (i== point_select) {
          p.get(i).select();
        } else {
          p.get(i).deselect();
        }
        p.get(i).render(render);
      }
    }
  }   

  if (menu.getToggleState("Show axis"))
    drawHelperGuides();
  else
    drawNorthArrow();

  if (menu.getToggleState("Show grid")) {  
    if (menu.getToggleState("Gradient subdivisions"))
      drawGradientDivisions();
    else
      drawDivisions();
    drawBoundingCube();
  }
  if (menu.getToggleState("Show sea level")) {
    drawSeaPlane();
  }

  if (menu.getToggleState("Compute and show isosurface")) {
    drawIsoSurface();
  }

  if (menu.getToggleState("Analyze minima") || menu.getToggleState("Analyze maxima")) {
    analyzeDensity();
  }

  if (menu.getToggleState("Tomography Section") ) {
    t.renderHorizontals(render);
  }
  if (menu.getToggleState("Tomography Vertical Section") ) {
    t.renderVerticals(render);
  }

  if (menu.getToggleState("Reset Cam")) {
    fireCameraReset();
    menu.uncheckToggle("Reset Cam");
  }   

  if (menu.getToggleState("Add subcube")) {
    addSubCube();
    menu.uncheckToggle("Add subcube");
  }   

  checkCropValues();

  if (menu.getToggleState("Crop box")) {
    c.findCropBoxCoords();
    renderCropBox();
  }  


  if (resetting_cam) {

    rot_x = lerp(rot_x_aux, init_rot_x, quinticOut(cam_lerp_control));
    rot_y = lerp(rot_y_aux, init_rot_y, quinticOut(cam_lerp_control));
    zoom = lerp(zoom_aux, init_zoom, quinticOut(cam_lerp_control));

    if (cam_lerp_control <1) {
      cam_lerp_control += 0.005;
    } else {
      resetting_cam = false;
      cam_lerp_control = 0;
    }
  }

  int info_panel_acum = 0;

  for (int i = 0; i < gumcubes.size(); i ++) {

    gumcubes.get(i).update(render);
    gumcubes.get(i).render(render);

    if (gumcubes.get(i).display_info) {

      gumcubes.get(i).info.setPosition(gumcubes.get(i).info.x, info_panel_acum);
      info_panel_acum += gumcubes.get(i).info.h;
    }
  }


  render.popMatrix();

  render.endDraw();

  background(30);  


  image(render, 300, 0);

  if (menu.getToggleState("Active rule")) {
    if (!ruler.active) {
      menu.checkToggle("Ortho");
    }
    if ( checkRulerRequisites() ) {    
      ruler.activate();
      ruler.update();
      ruler.render();
    }
  } else
    ruler.deactivate();


  menu.update();
  menu.render();



  for (int i = 0; i < gumcubes.size(); i ++) {

    gumcubes.get(i).manageInfoPanel();
  }

  updateMenuInfo();
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void mousePressed() {

  // menu.setInfoText(,)

  resetting_cam = false;

  boolean something_pressed = false;

  for (int i = 0; i < gumcubes.size(); i ++) {

    if (gumcubes.get(i).checkMouse()) {
      something_pressed = true;
    }
    if (gumcubes.get(i).active) unSelectCubes(i);
  }


  if (mouseX > 300  && ! something_pressed) {

    mouse_cam = true;
  }

  menu.checkMouse();

  ruler.mouse();
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void mouseReleased() {

  menu.release();
  for (int i = 0; i < gumcubes.size(); i ++) {

    gumcubes.get(i).release();
  }



  mouse_cam = false;
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void mouseWheel(MouseEvent event) {
  float aux = event.getCount();
  if (mouseX > 300) {

    zoom -= aux*3;
    resetting_cam = false;
  } else if (mouseX < 300) {


    menu.manageScroll(aux*3);
  }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


void keyPressed() 
{
    if (!menu.checkKeys())
    { 
      checkForViews();
  
      if (key == 's' || key =='S') 
      {
          String filename = "screenshots/capture-" + year() + "-" + nf(month(),2) + "-" + nf(day(),2) + "_"  + nf(hour(),2) + "." + nf(minute(),2) + nf(second(),2) + ".png";
          saveFrame(filename);
          println("saved " + filename);
      }
      else if (keyCode == BACKSPACE || keyCode == DELETE || keyCode == 127) {
          attemptSubcubeDelete();
      }
      else if (key == 'i' || key =='I') {
          attemptSubcubeInfo();
      }
      else if ((key == 'r' || key =='R')){
          record = true;
          println("Record On");
      }
      //else if ((key == 'm' || key =='M'))
    }
      
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void resetCamera() {
  zoom = init_zoom;
  rot_x = init_rot_x ;
  rot_y = init_rot_y ;
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void fireCameraReset() {

  resetting_cam = true;
  cam_lerp_control = 0;
  rot_x_aux = rot_x;
  rot_y_aux = rot_y;
  zoom_aux = zoom;
}

//•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

void addSubCube() {
  int x = int(random(-200, 200));
  int y = int(random(-200, 200));
  int z = int(random(-200, 200));
  GumballCube cube = new GumballCube(x, y, z);
  cube.asignColors();
  cube.setOffset(-300, 0);
  gumcubes.add(cube);
}

//•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

void unSelectCubes(int index) {

  for (int i = 0; i < gumcubes.size(); i ++) {

    if (i!=index) {

      gumcubes.get(i).active = false;
    }
  }
}

//•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

void attemptSubcubeDelete() {

  for (int i = 0; i < gumcubes.size(); i ++) {

    if (gumcubes.get(i).active) {

      gumcubes.remove(i);
    }
  }
}

void attemptSubcubeInfo() {

  for (int i = 0; i < gumcubes.size(); i ++) {

    if (gumcubes.get(i).active) {

      gumcubes.get(i).display_info  = ! gumcubes.get(i).display_info;
    }
  }
}
