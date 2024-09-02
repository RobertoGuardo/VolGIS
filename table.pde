//************************************************

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void eliminateDuplicates() {

  table_clean = new Table();

  table_clean.addColumn("data");
  table_clean.addColumn("ora");
  table_clean.addColumn("Lat N");
  table_clean.addColumn("Long E");
  table_clean.addColumn("prof (km)");
  table_clean.addColumn("Md");

  for (int i = 0; i < table.getRowCount(); i ++) {

    TableRow row = table.getRow(i);

    String date =  row.getString("data");
    String time =  row.getString("ora");
    float lat = row.getFloat("Lat N");
    float lon = row.getFloat("Long E");
    float prof = row.getFloat("prof (km)");
    float mag = row.getFloat("Md");
    // println(date + "|" + time + "|" + lat + "|" + lon + "|" + prof + "|" + mag);

    if (i == 0) {
      TableRow newRow = table_clean.addRow();
      newRow.setString("data", date);
      newRow.setString("ora", time);
      newRow.setFloat("Lat N", lat);
      newRow.setFloat("Long E", lon);
      newRow.setFloat("prof (km)", prof);
      newRow.setFloat("Md", mag);
      saveTable(table_clean, "data/clean.csv");
    } else {
      if (isNewRow(row, table_clean)) {
        TableRow newRow = table_clean.addRow();
        newRow.setString("data", date);
        newRow.setString("ora", time);
        newRow.setFloat("Lat N", lat);
        newRow.setFloat("Long E", lon);
        newRow.setFloat("prof (km)", prof);
        newRow.setFloat("Md", mag);
      }
    }
    //  println(i);
  }

  saveTable(table_clean, "data/clean.csv");
  println("saved!!");
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

boolean isNewRow(TableRow row, Table tab) {

  boolean ret = true;

  String date =  row.getString("data");
  String time =  row.getString("ora");
  float lat = row.getFloat("Lat N");
  float lon = row.getFloat("Long E");
  float prof = row.getFloat("prof (km)");
  float mag = row.getFloat("Md");

  for (int i = 0; i < tab.getRowCount(); i ++) {

    TableRow row_aux = tab.getRow(i);

    String date_aux =  row_aux.getString("data");
    String time_aux =  row_aux.getString("ora");
    float lat_aux = row_aux.getFloat("Lat N");
    float lon_aux = row_aux.getFloat("Long E");
    float prof_aux = row_aux.getFloat("prof (km)");
    float mag_aux = row_aux.getFloat("Md");

    if (date.equals(date_aux) && time.equals(time_aux) && lat == lat_aux && lon == lon_aux && prof == prof_aux && mag == mag_aux) {

      ret = false;
    }
  }
  return ret;
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void createPoints() {

  for (int i = 0; i < table_clean.getRowCount(); i ++) {

    TableRow row = table_clean.getRow(i);

    float lat = row.getFloat("Lat N");
    float lon = row.getFloat("Long E");
    float pro = row.getFloat("prof (km)");
    float mag = row.getFloat("Md");

    // println(aux_vec);

    PVector aux_vec = proj.latLongToUTM(new PVector(lon, lat));

    lat = c.utmToKm(aux_vec.y);  // en km
    lon = c.utmToKm(aux_vec.x);  // en km  

    //  println(lat + " " + lon + " " + pro);

    if (pro <= prof_limit ) {
      // max_prof_map = prof_limit;
      float y =  map(pro, c.min_prof_map, c.max_prof_map, -cube_side/2, cube_side/2);
      float x =  map(lon, c.min_lon_map, c.max_lon_map, -cube_side/2, cube_side/2);
      float z =  map(lat, c.min_lat_map, c.max_lat_map, cube_side/2, -cube_side/2);

      Point aux = new Point(x, y, z, mag);

      float h = map(pro, c.min_pro, c.max_pro, 360, 230);
      if (!Float.isNaN(mag)) {
        // mag = 0;
        // println(i);
        //  float h = map(mag, min_mag, max_mag, 122, 5);
        aux.setHue(h);
        p.add(aux);
      }
    }

    //   min_prof_map = min_pro;
    //   max_prof_map = max_pro;
  }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//void createRandomPoints() {
//  int p_amt = int(random(1500, 5000));
//  p_amt = 3500;

//  for (int i = 0; i < p_amt; i++) {
//    float y =  random(-cube_side/2, cube_side/2);
//    Point aux = new Point(random(-cube_side/2, cube_side/2), y, random(-cube_side/2, cube_side/2), 0);
//    float h = map(y, -cube_side/2, cube_side/2, 360, 230);
//    aux.setHue(h);
//    p.add(aux);
//  }
//}