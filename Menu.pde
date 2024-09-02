class Menu {

  float x = 0;
  float y = 0;

  int slider_h = 50;
  int cslider_h =60;
  int textbox_h = 40;
  int toggle_h = 20;
  int cam_h = 120;
  int separator_h = 15;

  int slider_w = 250;
  int textbox_w = 70;

  float x_elements = 0;
  float y_acum = 0;

  ArrayList <Slider> sliders;
  ArrayList <SliderComplex> csliders;
  ArrayList <Textbox> boxes;
  ArrayList <Toggle> toggles;
  ArrayList <Info> infos;

  float[] separators ;

  CamControl cam;

  boolean has_cam = false;

  boolean has_scroll = false;

  PFont f;

  float height_diff = 0;
  boolean scroll_pressed = false;
  float scroll_w = 8;
  float scroll_h = 0;
  float scroll_y = 0;
  float scroll_x = 292;
  float scroll_click_offset = 0;

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


  Menu() {
    initArrayLists();
    x_elements = x + 20;
    y_acum = y;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Menu( float x_, float y_) {
    x = x_;
    y = y_;
    initArrayLists();
    x_elements = x + 20;
    y_acum = y;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void initArrayLists() {
    sliders = new ArrayList();
    csliders = new ArrayList();
    boxes = new ArrayList();
    toggles = new ArrayList();
    infos = new ArrayList();
    cam = null;
    separators = new float[0];
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void render() {

    //renderDebug();
    
    fill(30);
    noStroke();
    rect(0,0,300,height);

    for (int i = 0; i < sliders.size(); i++) {
      sliders.get(i).render();
    }

    for (int i = 0; i < csliders.size(); i++) {
      csliders.get(i).render();
    }

    for (int i = 0; i < boxes.size(); i++) {
      boxes.get(i).render();
    }

    for (int i = 0; i < toggles.size(); i++) {
      toggles.get(i).render();
    }

    for (int i = 0; i < infos.size(); i++) {
      infos.get(i).render();
    }

    if (cam != null) {
      cam.render();
    }

    renderSeparators();

    if (has_scroll) {

      renderScroll();
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void renderScroll() {

    pushStyle();

    rectMode(CENTER);

    noStroke();

    fill(20);

    rect(scroll_x +1, scroll_y+1, scroll_w, scroll_h, 3);

    fill(60);

    rect(scroll_x, scroll_y, scroll_w, scroll_h, 3);

    if (scroll_pressed) {


      fill(8, 193, 192, 40);

      rect(scroll_x, scroll_y, scroll_w, scroll_h, 3);
    }

    popStyle();
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


  void renderDebug() {

    pushStyle();

    stroke(128, 0, 0, 150);

    for (int i = 0; i < sliders.size(); i++) {      
      line(x, sliders.get(i).y, x+200, sliders.get(i).y);
    }

    for (int i = 0; i < csliders.size(); i++) {
      line(x, csliders.get(i).y, x+200, csliders.get(i).y);
    }

    for (int i = 0; i < boxes.size(); i++) {
      line(x, boxes.get(i).y, x+200, boxes.get(i).y);
    }

    for (int i = 0; i < toggles.size(); i++) {
      line(x, toggles.get(i).y, x+200, toggles.get(i).y);
    }

    for (int i = 0; i < infos.size(); i++) {
      line(x, infos.get(i).y, x+200, infos.get(i).y);
    }

    if (cam != null) {
      line(x, cam.y, x+200, cam.y);
    }

    popStyle();
  }





  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void update() {

    for (int i = 0; i < sliders.size(); i++) {
      sliders.get(i).update();
    }

    for (int i = 0; i < csliders.size(); i++) {
      csliders.get(i).update();
    }

    if (cam != null) {
      cam.update();
    }

    if (has_scroll && scroll_pressed) {

      manageScroll(mouseY-pmouseY);
    }

    /*   for (int i = 0; i < boxes.size(); i++) {
     boxes.get(i).update();
     }
     
     for (int i = 0; i < toggles.size(); i++) {
     toggles.get(i).update(); 
     }*/
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void renderSeparators() {

    pushStyle();

    int w = 280;

    for (int i = 0; i < separators.length; i ++) {
      stroke(0);
      line(x_elements, separators[i], x + w, separators[i]);
      stroke(90);
      line(x_elements, separators[i] + 1, x + w, separators[i] + 1);
    }

    popStyle();
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void checkMouse() {

    for (int i = 0; i < sliders.size(); i++) {
      sliders.get(i).checkMouse();
    }

    for (int i = 0; i < csliders.size(); i++) {
      csliders.get(i).checkMouse();
    }

    for (int i = 0; i < boxes.size(); i++) {
      boxes.get(i).checkMouse();
    }

    for (int i = 0; i < toggles.size(); i++) {
      toggles.get(i).checkMouse();
    }

    if (cam != null) {
      cam.checkMouse();
    }

    if (has_scroll) {
      if (mouseX > scroll_x - scroll_w/2 && mouseX < scroll_x + scroll_w/2 && mouseY > scroll_y - scroll_h/2 && mouseY < scroll_y + scroll_h/2) {
        scroll_pressed  = true;
        scroll_click_offset = scroll_y - mouseY;
      } else {
        scroll_pressed = false;
      }
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void release() {

    for (int i = 0; i < sliders.size(); i++) {
      sliders.get(i).release();
    }

    for (int i = 0; i < csliders.size(); i++) {
      csliders.get(i).release();
    }

    if (cam != null) {
      cam.release();
    }

    scroll_pressed = false;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  boolean checkKeys() {

    boolean flag = false;
    for (int i = 0; i < csliders.size(); i++) {
      if (csliders.get(i).checkKeys())
        flag = true;
    }

    for (int i = 0; i < boxes.size(); i++) {
      if (boxes.get(i).checkKeys())
        flag = true;
    }

    return flag;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setFont(PFont f) {

    for (int i = 0; i < sliders.size(); i++) {
      sliders.get(i).setFont(f);
    }

    for (int i = 0; i < csliders.size(); i++) {
      csliders.get(i).setFont(f);
    }

    for (int i = 0; i < boxes.size(); i++) {
      boxes.get(i).setFont(f);
    }

    for (int i = 0; i < toggles.size(); i++) {
      toggles.get(i).setFont(f);
    }

    for (int i = 0; i < infos.size(); i++) {
      infos.get(i).setFont(f);
    }

    if (cam != null) {
      cam.setFont(f);
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void addSeparator() {
    separators = append(separators, y_acum);
    y_acum += separator_h;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void addSlider(String id, float min, float max, float init, boolean isInt ) {

    Slider aux =  new Slider(id, min, max, slider_w);
    aux.setPosition(x_elements, y_acum);
    if (isInt)
      aux.setAsInt();
    aux.setVal(init);

    sliders.add(aux);
    y_acum += slider_h;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void addSliderComplex(String id, float min, float max, float init, boolean isInt ) {

    SliderComplex aux =  new SliderComplex(id, min, max, slider_w);
    aux.setPosition(x_elements, y_acum);
    if (isInt)
      aux.setAsInt();
    aux.setVal(init);

    csliders.add(aux);
    y_acum += cslider_h;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void addTextbox(String id, boolean isNumber  ) {

    Textbox aux = new Textbox(x_elements, y_acum, textbox_w, 15);
    aux.setId(id);
    if (isNumber)
      aux.setNumber();

    boxes.add(aux);
    y_acum += textbox_h;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void addTextbox(String id, boolean isNumber, String text  ) {

    Textbox aux = new Textbox(x_elements, y_acum, textbox_w, 15);
    aux.setId(id);
    if (isNumber)
      aux.setNumber();
    aux.setText(text);
    boxes.add(aux);
    y_acum += textbox_h;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ Dibujar guia

  void addToggle(String id, boolean checked  ) {

    Toggle aux = new Toggle(x_elements, y_acum, id);

    if (checked)
      aux.check();

    toggles.add(aux);
    y_acum += toggle_h;
  }


  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ Metros por lados

  void addInfo(String id  ) {

    Info aux = new Info(x_elements, y_acum, id);


    infos.add(aux);
    y_acum += toggle_h;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//  void addCamControl() {

//    if (cam == null) {
//      cam = new CamControl(x_elements + 20, y_acum);
//    }

//    y_acum += cam_h;
//  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  float getSliderValue(String id) {

    float ret = 0;

    id = id.toLowerCase();

    for (int i = 0; i < sliders.size(); i++) {
      if (id.equals( sliders.get(i).getId().toLowerCase())) {
        ret =  sliders.get(i).getVal();
        break;
      }
    }

    for (int i = 0; i < csliders.size(); i++) {
      if (id.equals( csliders.get(i).getId().toLowerCase())) {
        ret =  csliders.get(i).getVal();
        break;
      }
    }

    return ret;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  int getSliderValueInt(String id) {

    int ret = 0;

    id = id.toLowerCase();

    for (int i = 0; i < sliders.size(); i++) {
      if (id.equals( sliders.get(i).getId().toLowerCase())) {
        ret =  int(sliders.get(i).getVal());
        break;
      }
    }

    for (int i = 0; i < csliders.size(); i++) {
      if (id.equals( csliders.get(i).getId().toLowerCase())) {
        ret =  int(csliders.get(i).getVal());
        break;
      }
    }

    return ret;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  String getTextboxCont(String id) {

    String ret = "";

    id = id.toLowerCase();

    for (int i = 0; i < boxes.size(); i++) {
      if (id.equals( boxes.get(i).getId().toLowerCase())) {
        ret =  boxes.get(i).getText();
        break;
      }
    }

    return ret;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  boolean getTextboxFocus(String id) {

    boolean ret = false;

    id = id.toLowerCase();

    for (int i = 0; i < boxes.size(); i++) {
      if (id.equals( boxes.get(i).getId().toLowerCase())) {
        ret =  boxes.get(i).getFocus();
        break;
      }
    }

    return ret;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ Computar y mostrar Isosurface

  boolean getToggleState(String id) {

    boolean ret = false;

    id = id.toLowerCase();

    for (int i = 0; i < toggles.size(); i++) {
      if (id.equals( toggles.get(i).getId().toLowerCase())) {
        ret =  toggles.get(i).isPressed();
        break;
      }
    }

    return ret;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "subdivisiones" || "umbral isosurface"

  boolean getToggleFlag(String id) {

    id = id.toLowerCase();

    boolean ret = false;
    for (int i = 0; i < toggles.size(); i++) {
      if (id.equals( toggles.get(i).getId().toLowerCase())) {
        ret =  toggles.get(i).getFlag();
        break;
      }
    }

    return ret;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  menu.lowerToggleFlag("Computar y mostrar isosurface");

  void lowerToggleFlag(String id) {

    id = id.toLowerCase();

    for (int i = 0; i < toggles.size(); i++) {
      if (id.equals( toggles.get(i).getId().toLowerCase())) {
        toggles.get(i).unflag();
        break;
      }
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ Resetear camara

  void uncheckToggle(String id) {

    id = id.toLowerCase();

    for (int i = 0; i < toggles.size(); i++) {
      if (id.equals( toggles.get(i).getId().toLowerCase())) {
        toggles.get(i).uncheck();
        break;
      }
    }
  }
  
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void checkToggle(String id) {

    id = id.toLowerCase();

    for (int i = 0; i < toggles.size(); i++) {
      if (id.equals( toggles.get(i).getId().toLowerCase())) {
        toggles.get(i).check();
        break;
      }
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  float getCamZoom() {

    float ret = 0;

    if (cam != null) {

      ret = cam.getZoom();
    }

    return ret;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  float getCamPanX() {

    float ret = 0;

    if (cam != null) {

      ret = cam.getPanX();
    }

    return ret;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  float getCamPanY() {

    float ret = 0;

    if (cam != null) {

      ret = cam.getPanY();
    }

    return ret;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  PVector getCamPan() {

    PVector ret = new PVector(0, 0);
    
    if (cam != null) {

      ret = cam.getPan();
    }

    return ret;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setSliderValue(String id, float val) {

    id = id.toLowerCase();

    for (int i = 0; i < sliders.size(); i++) {
      if (id.equals( sliders.get(i).getId().toLowerCase())) {
        sliders.get(i).setVal(val);
        break;
      }
    }

    for (int i = 0; i < csliders.size(); i++) {
      if (id.equals( csliders.get(i).getId().toLowerCase())) {
        csliders.get(i).setVal(val);
        break;
      }
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setBoxText(String id, String s) {

    id = id.toLowerCase();

    for (int i = 0; i < boxes.size(); i++) {
      if (id.equals( boxes.get(i).getId().toLowerCase())) {
        boxes.get(i).setText(s);
        break;
      }
    }
  }


  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setInfoText(String id, String s) {

    id = id.toLowerCase();

    for (int i = 0; i < infos.size(); i++) {
      if (id.equals( infos.get(i).getId().toLowerCase())) {
        infos.get(i).setText(s);
        break;
      }
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  boolean getSliderFlag(String id) {

    boolean ret = false;

    id = id.toLowerCase();

    for (int i = 0; i < sliders.size(); i++) {
      if (id.equals( sliders.get(i).getId().toLowerCase())) {
        ret = sliders.get(i).getFlag();
        break;
      }
    }

    for (int i = 0; i < csliders.size(); i++) {
      if (id.equals( csliders.get(i).getId())) {
        ret = csliders.get(i).getFlag();
        break;
      }
    }

    return ret;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void setScroll() {

    has_scroll = true;
  }

  //•••••••••••••••••••••••••••••••

  void calculateScroll() {

    height_diff = y_acum - height;

    if (height_diff > 0) {

      setScroll();
    }

    scroll_h = height - height_diff;

    scroll_y = scroll_h/2;
  }

  //•••••••••••••••••••••••••••••••

  void manageScroll(float y) {
    
    float prev_y = scroll_y;

    scroll_y =  scroll_y + y ;
    scroll_y = constrain(scroll_y, scroll_h/2, height - scroll_h/2);

    int dy = int(prev_y - scroll_y);

    for (int i = 0; i < sliders.size(); i++) {
      sliders.get(i).move(0, dy);
    }

    for (int i = 0; i < csliders.size(); i++) {
      csliders.get(i).move(0, dy);
    }

    for (int i = 0; i < boxes.size(); i++) {
      boxes.get(i).move(0, dy);
    }

    for (int i = 0; i < toggles.size(); i++) {
      toggles.get(i).move(0, dy);
    }

    for (int i = 0; i < infos.size(); i++) {
      infos.get(i).move(0, dy);
    }

    if (cam != null) {
      cam.render();
    }

    for (int i = 0; i < separators.length; i ++) {
      separators[i] += dy;
    }
  }

  //•••••••••••••••••••••••••••••••
}