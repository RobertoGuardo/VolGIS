class Coord {

  float min_lat  = 0;  // valores de minimo y maximo de latitud, longitud, profundidad y magnitud (pasados a UTM)
  float max_lat = 0;
  float min_lon = 0;
  float max_lon = 0;
  float min_pro = 0;
  float max_pro = 0;
  float min_mag = 0;
  float max_mag = 0;

  float min_lat_map = 0; // valores de minimo y maximo de latitud, longitud y profundidad, para mappear
  float max_lat_map = 0;
  float min_lon_map = 0;
  float max_lon_map = 0;
  float min_prof_map = 0;
  float max_prof_map = 0;

  float min_lat_deg = 0;  // valores de minimo y maximo, latitud y longitud, en grados
  float max_lat_deg = 0;
  float min_lon_deg = 0;
  float max_lon_deg = 0;

  float min_lat_crop = 0;
  float max_lat_crop = 0;
  float min_lon_crop = 0;
  float max_lon_crop = 0;
  float min_pro_crop = 0;
  float max_pro_crop = 0;

  float crop_x_w = 0;
  float crop_y_n = 0;
  float crop_x_e = 0;
  float crop_y_s = 0;
  float crop_min_depth = 0;
  float crop_max_depth = 0;
  float crop_w = 0;
  float crop_h = 0;
  float crop_d = 0;
  float crop_center_x = 0;
  float crop_center_y = 0;
  float crop_center_z = 0;
  
  
  float sea_level = 0;

  //••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

  Coord() {
  }

  //••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

  void searchMaxMins() {


    boolean first =false;

    for (int i = 0; i < table_clean.getRowCount(); i ++) {

      TableRow row = table_clean.getRow(i);

      float lat = row.getFloat("Lat N");
      float lon = row.getFloat("Long E");
      float pro = row.getFloat("prof (km)"); 
      float mag = row.getFloat("Md");

      float lat_deg_aux = lat;
      float lon_deg_aux = lon;

      //   PVector aux_vec = proj.latLongToUTM(new PVector(lon, lat), 15.0, 0.0, 0 , 0, 0.9996);

      PVector aux_vec = proj.latLongToUTM(new PVector(lon, lat));

      // PVECTOR SKJDA double lngOrigin, double latOrigin, double xOffset, double yOffset, double scaleFactor

      lat = utmToKm(aux_vec.y);  // en km
      lon = utmToKm(aux_vec.x);  // en km

      // println(lat + "   " + lon);

      if (pro < prof_limit ) {

        if (!first) {
          min_lat = lat;
          max_lat = lat;
          min_lon = lon;
          max_lon = lon;
          min_pro = pro;
          max_pro = pro;
          min_mag = mag;
          max_mag = mag;

          min_lat_deg = lat_deg_aux;
          max_lat_deg = lat_deg_aux;          
          min_lon_deg = lon_deg_aux;  
          max_lon_deg = lon_deg_aux;

          first = true;
        } else {
          if (lat < min_lat) {
            min_lat = lat;
            min_lat_deg = lat_deg_aux;
          }
          if (lat > max_lat) {
            max_lat = lat;
            max_lat_deg = lat_deg_aux;
          }
          if (lon < min_lon) {
            min_lon = lon;
            min_lon_deg = lon_deg_aux;
          }
          if (lon > max_lon) {
            max_lon = lon;
            max_lon_deg = lon_deg_aux;
          }
          if (pro < min_pro) {
            min_pro = pro;
          }
          if (pro > max_pro) {
            max_pro = pro;
          }
          if (mag < min_mag) {
            min_mag = mag;
          }
          if (mag > max_mag) {
            max_mag = mag;
          }
        }
      }
    }

    println("••••••••••••••••••••••••••••••••••");
    println("ANALISIS DE PUNTOS");
    println("••••••••••••••••••••••••••••••••••");

//--------------------- MANUAL FOR ALL THE EVENTS

    //min_lon = 474.20935;
    //max_lon = 525.9884;
    //min_lat = 4151.4136;
    //max_lat = 4194.809;
    //min_pro = -3.0;
    //max_pro = 9.98;
    //min_mag = 0.0;
    //max_mag = 4.4;
    
    //min_lon_deg = 14.707;
    //max_lon_deg = 15.295;
    //min_lat_deg = 37.509;
    //max_lat_deg = 37.9;
    

    println("MINIMA LONGITUD     " + min_lon);
    println("MAXIMA LONGITUD     " + max_lon);
    println("MINIMA LATITUD      " + min_lat);
    println("MAXIMA LATITUD      " + max_lat);
    println("MINIMA PROFUNDIDAD  " + min_pro);
    println("MAXIMA PROFUNDIDAD  " + max_pro);
    println("MINIMA MAGNITUD     " + min_mag);
    println("MAXIMA MAGNITUD     " + max_mag);

    println("MINIMA LONGITUD (DEG)      " + min_lon_deg );
    println("MAXIMA LONGITUD (DEG)      " + max_lon_deg );
    println("MINIMA LATITUD (DEG)       " + min_lat_deg );
    println("MAXIMA LATITUD (DEG)       " + max_lat_deg );

    float delta_lat = max_lat - min_lat;
    float delta_lon = max_lon - min_lon;
    float delta_prof = max_pro - min_pro;

    println("••••••••••••••••••••••••••••••••••");
    
//--------------------- MANUAL FOR ALL THE EVENTS
    //delta_lat = 43.395508;
    //delta_lon = 51.779053;
    //delta_prof = 12.98;

    println("DELTA LATITUD     " + delta_lat);
    println("DELTA LONGITUD    " + delta_lon);
    println("DELTA PROFUNDIAD  " + delta_prof);

    //esto muy a mano a partir de acá

    if (delta_lat > delta_lon) {  
      min_lat_map = min_lat;
      max_lat_map = max_lat;
      min_lon_map = min_lon - (delta_lat - delta_lon)/2;
      max_lon_map = max_lon + (delta_lat - delta_lon)/2;
    } else {
      min_lon_map = min_lon;
      max_lon_map = max_lon;
      min_lat_map = min_lat - (delta_lon - delta_lat)/2;
      max_lat_map = max_lat + (delta_lon - delta_lat)/2;
    }

    delta_lat = max_lat_map - min_lat_map;
    delta_lon = max_lon_map - min_lon_map;

    min_prof_map = min_pro;
    max_prof_map = max_pro;

    float aux_prof = delta_lat - delta_prof;

    kms_per_side = delta_lat;

    max_prof_map += aux_prof;

    // println(max_prof_map);
    //delta_prof = max_prof_map - min_prof_map;
    
    
//--------------------- MANUAL FOR ALL THE EVENTS

    //delta_lat = 51.779297;
    //delta_lon = 51.779053;
    //delta_prof = 12.98;


    println("DELTA LATITUD PROCESADA    " + delta_lat);
    println("DELTA LONGITUD PROCESADA   " + delta_lon);
    println("DELTA PROFUNDIAD PROCESADA " + delta_prof);

    /*  println(max_lat_map);
     
     PVector aux = proj.UTMToLatLong(new PVector((max_lat_map * 1000), (max_lon_map * 1000)));
     println("äsasfsdfasdfasdfasd  "  + aux  );  */
     
      sea_level =  map(0,min_prof_map, max_prof_map,-cube_side, cube_side);
      //sea_level =  map(0,min_prof_map, max_prof_map,-350, 500);

     
  }

  //••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

  float utmToKm(float val) {

    float factor = 1000.0;

    float res = (1.0*val)/factor;

    return res;
  }

  //••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

  void setCropValues(float mi_lat, float ma_lat, float mi_lon, float ma_lon, float mi_pro, float ma_pro) {

    min_lat_crop = mi_lat;
    max_lat_crop = ma_lat;
    min_lon_crop = mi_lon;
    max_lon_crop = ma_lon;
    min_pro_crop = mi_pro;
    max_pro_crop = ma_pro;
  }

  //••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

  void findCropBoxCoords() {

    PVector n_w = proj.latLongToUTM(new PVector(c.min_lon_crop, c.max_lat_crop));
    PVector s_e = proj.latLongToUTM(new PVector(c.max_lon_crop, c.min_lat_crop));

    n_w.x = c.utmToKm(n_w.x);
    n_w.y = c.utmToKm(n_w.y);

    s_e.x = c.utmToKm(s_e.x);
    s_e.y = c.utmToKm(s_e.y);

    crop_x_w = map(n_w.x, c.min_lon_map, c.max_lon_map, -cube_side/2, cube_side/2);

    crop_y_n = map(n_w.y, c.min_lat_map, c.max_lat_map, cube_side/2, - cube_side/2);

    crop_x_e = map(s_e.x, c.min_lon_map, c.max_lon_map, -cube_side/2, cube_side/2);

    crop_y_s = map(s_e.y, c.min_lat_map, c.max_lat_map, cube_side/2, -cube_side/2) ;

    crop_w = crop_x_e - crop_x_w;

    crop_min_depth = map(c.min_pro_crop, c.min_prof_map, c.max_prof_map, -cube_side/2, cube_side/2);

    crop_max_depth = map(c.max_pro_crop, c.min_prof_map, c.max_prof_map, -cube_side/2, cube_side/2);

    crop_h = crop_max_depth - crop_min_depth;

    crop_d =  crop_y_s - crop_y_n;

    crop_center_x = crop_x_w + crop_w/2;

    crop_center_y = crop_min_depth + crop_h/2;

    crop_center_z = crop_y_n + crop_d/2;
  }
}