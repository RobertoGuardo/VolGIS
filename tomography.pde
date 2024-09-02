class Tomography {

  //NOTA: ESTA CLASE ESTA HECHA MUY A MEDIDA DE ESTA APLICACION

  PImage [] hor;
  PImage [] ver;

  PImage ver_s_n;
  PImage ver_w_e;

  float hor_image_dist = 1; // en KM

  ///////////// Horizontal Cross Section
  
  //float hor_start_long = 14.852;
  float hor_start_long = 14.845; //Rtn
  //float hor_end_long = 15.201;
  float hor_end_long = 15.2019; //Rtn

  //float hor_start_lat = 37.850;
  float hor_start_lat = 37.8513; //Rtn
  
  //float hor_end_lat = 37.599;
  float hor_end_lat = 37.595; //Rtn

  float [] depths;

  ///////////// Vertical Cross Section (W-E)

  //float ver_w_e_start_lat = 37.7496; //to be fixed
  float ver_w_e_lat = 37.75; //fixed! Rtn
  float ver_w_e_start_long = 14.8639;
  float ver_w_e_end_long = 15.1415;
  

///////////// Vertical Cross Section (S-N)

  
  float ver_s_n_long = 15.00; //to be fixed
  float ver_s_n_start_lat = 37.6256;
  float ver_s_n_end_lat = 37.8416;
  

  float ver_w_e_start_depth = -3;
  float ver_w_e_end_depth = 10;

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Tomography() {

    hor = new PImage[6];

    depths = new float[6];

    String extension = ".png";
    String filename = "tomo/Vp_-3km" + extension; 
    hor[0] = loadImage(filename); 
    filename = "tomo/Vp_-2km" + extension; 
    hor[1] = loadImage(filename); 
    filename = "tomo/Vp_-1km" + extension; 
    hor[2] = loadImage(filename);
    filename = "tomo/Vp_0km" + extension; 
    hor[3] = loadImage(filename);
    filename = "tomo/Vp_1km" + extension; 
    hor[4] = loadImage(filename);
    filename = "tomo/Vp_2km" + extension; 
    hor[5] = loadImage(filename);

//++++++++++++++++ in km b.s.l.

    depths[0] = 3;
    depths[1] = 2;
    depths[2] = 1;
    depths[3] = 0;
    depths[4] = -1; 
    depths[5] = -2;

    ver = new PImage[2];

    //filename = "tomo/W-EBlack" + extension;
    filename = "tomo/W-E" + extension;
    ver[0] = loadImage(filename);    

    filename = "tomo/S-N" + extension;
    ver[1] = loadImage(filename);    

    //filename = "tomo/S-N" + extension;
    //ver_s_n = loadImage(filename);

    //filename = "tomo/W-E" + extension;
    //ver_w_e = loadImage(filename);
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void renderHorizontals(PGraphics g) {

    PVector origin_vector = proj.latLongToUTM(new PVector(hor_start_long, hor_start_lat));

    float lon_or = c.utmToKm(origin_vector.x);  // en km

    float lat_or=  c.utmToKm(origin_vector.y);  // en km

    PVector end_vector = proj.latLongToUTM(new PVector(hor_end_long, hor_end_lat));

    float lat_end =  c.utmToKm(end_vector.y);  // en km
    float lon_end = c.utmToKm(end_vector.x);  // en km

    float x_start =  map(lon_or, c.min_lon_map, c.max_lon_map, -cube_side/2, cube_side/2);
    float z_start =  map(lat_or, c.min_lat_map, c.max_lat_map, cube_side/2, -cube_side/2);

    float x_end =  map(lon_end, c.min_lon_map, c.max_lon_map, -cube_side/2, cube_side/2);
    float z_end =  map(lat_end, c.min_lat_map, c.max_lat_map, cube_side/2, -cube_side/2);

    g.pushMatrix();

    g.pushStyle();

    // g.translate(0, -cube_side/2, 0);

    if (menu.getToggleState("Horizontal 3 b.s.l.") ) {

      renderHorizontalSlice(0, x_start, z_start, x_end, z_end, g );
    }
    if (menu.getToggleState("Horizontal 2 b.s.l.") ) {

      renderHorizontalSlice(1, x_start, z_start, x_end, z_end, g);
    }
    if (menu.getToggleState("Horizontal 1 b.s.l.") ) {

      renderHorizontalSlice(2, x_start, z_start, x_end, z_end, g );
    }
    if (menu.getToggleState("Horizontal 0") ) {

      renderHorizontalSlice(3, x_start, z_start, x_end, z_end, g);
    }
    if (menu.getToggleState("Horizontal -1 b.s.l.") ) {

      renderHorizontalSlice(4, x_start, z_start, x_end, z_end, g);
    }
    if (menu.getToggleState("Top layer") ) {

      renderHorizontalSlice(5, x_start, z_start, x_end, z_end, g );
    }

    g.popStyle();

    g.popMatrix();
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


  void renderHorizontalSlice(int i, float x_start, float z_start, float x_end, float z_end, PGraphics g ) {      
    float y = map(depths[i], c.min_prof_map, c.max_prof_map, -cube_side/2, cube_side/2);

    g.noFill();

    g.noStroke();

    g.pushMatrix();

    g.beginShape();

    g.tint(255, 255);

    g.texture(hor[i]);

    g.vertex(x_start, y, z_start, 0, 0);  /// rojo

    g.vertex(x_end, y, z_start, hor[i].width, 0);

    g.vertex(x_end, y, z_end, hor[i].width, hor[i].height);  /// azul

    g.vertex(x_start, y, z_end, 0, hor[i].height);  /// verde

    g.endShape(CLOSE);


    g.popMatrix();
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void renderVerticals(PGraphics g) {

    g.pushMatrix();

    g.pushStyle();

    {
      PVector origin_vector = proj.latLongToUTM(new PVector(ver_w_e_start_long, ver_w_e_lat));

      float lat_or=  c.utmToKm(origin_vector.y);  // en km
      float lon_or = c.utmToKm(origin_vector.x);  // en km

      PVector end_vector = proj.latLongToUTM(new PVector(ver_w_e_end_long, ver_w_e_lat));

      float lat_end =  c.utmToKm(end_vector.y);  // en km
      float lon_end = c.utmToKm(end_vector.x);  // en km

      float x_start =  map(lon_or, c.min_lon_map, c.max_lon_map, -cube_side/2, cube_side/2);
      float z_start =  map(lat_or, c.min_lat_map, c.max_lat_map, cube_side/2, -cube_side/2);
      float y_start = map(ver_w_e_start_depth, c.min_prof_map, c.max_prof_map, -cube_side/2, cube_side/2);

      float x_end =  map(lon_end, c.min_lon_map, c.max_lon_map, -cube_side/2, cube_side/2);
      float z_end =  map(lat_end, c.min_lat_map, c.max_lat_map, cube_side/2, -cube_side/2);
      float y_end = map(ver_w_e_end_depth, c.min_prof_map, c.max_prof_map, -cube_side/2, cube_side/2);


        /// DE NORTE A SUR
      g.noFill();

      g.noStroke();

      g.pushMatrix();

      g.beginShape();

      g.tint(255, 255);

      g.texture(ver[0]);

      g.vertex(x_start, y_start, z_start, 0, 0);

      g.vertex(x_end, y_start, z_start, ver[0].width, 0);

      g.vertex(x_end, y_end, z_end, ver[0].width, ver[0].height);

      g.vertex(x_start, y_end, z_end, 0, ver[0].height);

      g.endShape(CLOSE);

      g.popMatrix();
    }

    {

      PVector origin_vector = proj.latLongToUTM(new PVector(ver_s_n_long, ver_s_n_start_lat));

      float lat_or=  c.utmToKm(origin_vector.y);  // en km
      float lon_or = c.utmToKm(origin_vector.x);  // en km

      PVector end_vector = proj.latLongToUTM(new PVector(ver_s_n_long, ver_s_n_end_lat));

      float lat_end = c.utmToKm(end_vector.y);  // en km
      float lon_end = c.utmToKm(end_vector.x);  // en km

      float x_start =  map(lon_or, c.min_lon_map, c.max_lon_map, -cube_side/2, cube_side/2);
      float z_start =  map(lat_or, c.min_lat_map, c.max_lat_map, cube_side/2, -cube_side/2);
      float y_start = map(ver_w_e_start_depth, c.min_prof_map, c.max_prof_map, -cube_side/2, cube_side/2);

      float x_end =  map(lon_end, c.min_lon_map, c.max_lon_map, -cube_side/2, cube_side/2);
      float z_end =  map(lat_end, c.min_lat_map, c.max_lat_map, cube_side/2, -cube_side/2);
      float y_end = map(ver_w_e_end_depth, c.min_prof_map, c.max_prof_map, -cube_side/2, cube_side/2);

      g.noFill();

      g.noStroke();

      g.pushMatrix();

      g.beginShape();

      g.tint(255, 255);

      g.texture(ver[1]);
      
      /// DE ESTE A OESTE

      /*  g.vertex(x_start, y_start, z_start, 0, 0);
       
       g.vertex(x_start, y_start, z_end, ver[1].width, 0);
       
       g.vertex(x_start, y_end, z_end, ver[1].width, ver[1].height);
       
       g.vertex(x_start, y_end, z_start, 0, ver[1].height); */

      g.vertex(x_start, y_start, z_start, 0,0);

      g.vertex(x_start, y_start, z_end, ver[1].width, 0);

      g.vertex(x_start, y_end, z_end, ver[1].width, ver[1].height);

      g.vertex(x_start, y_end, z_start, 0, ver[1].height);


      g.endShape(CLOSE);

      g.popMatrix();
    }

    g.popStyle();

    g.popMatrix();
  }
}