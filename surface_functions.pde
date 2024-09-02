//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void createIsoSurface() {

  iso = new IsoSurface(this, new PVector(-cube_side/2, -cube_side/2, -cube_side/2), new PVector(cube_side/2, cube_side/2, cube_side/2), divisions);
  
   if (menu.getToggleState("Apply to isosurface")) {
    iso = new IsoSurface(this, new PVector(c.crop_x_w, c.crop_min_depth, c.crop_y_n), new PVector(c.crop_x_e, c.crop_max_depth,  c.crop_y_s), divisions);
   }

  for (int i = 0; i < isopoints.length; i++) {
    PVector pt = isopoints[i];


    if (menu.getToggleState("Apply to isosurface")) {
      if (pt.x > c.crop_x_w && pt.y > c.crop_min_depth && pt.z > c.crop_y_n  && pt.x < c.crop_x_e && pt.y < c.crop_max_depth && pt.z < c.crop_y_s) {
        iso.addPoint(pt);
      }
    } else {
      iso.addPoint(pt);
    }
  }

  float thresh =  menu.getSliderValue("Isosurface threshold");
  iso.generateSurface(thresh);
}


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void drawIsoSurface() 
{
   // fill(255, 255, 0, 128);
  iso.plot( render);
}
  
  //if (record) {
  //    endRecord();
  //    record = false;
 //}
  

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


void createIsoPoints() {

  for (int i = 0; i < p.size(); i++) {
    Point aux = p.get(i);
    PVector pt = new PVector(aux.x, aux.y, aux.z);
    isopoints = (PVector[]) append(isopoints, pt);
  }


  println("CANTIDAD DE ISOPOINTS: " + isopoints.length);
}