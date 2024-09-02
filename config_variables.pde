
void initRender() 
{
  render = createGraphics(1000, 1000, P3D);
  render.beginDraw();
  render.textFont(font);
  render.endDraw();

  delta_pan_y = 0;
  delta_pan_x = 0 ;
  
//******** Centered on the center of the area
  //pan_x = render.width/2;        //intial X position of the camera
  //pan_y = render.height/2;  //intial Y position of the camera


//******** Centered on the tomography (For TOP View)
  pan_x = render.width/2 - 1;        //intial X position of the camera
  pan_y = render.height/2 - 39;  //intial Y position of the camera
  
//******** Centered on the tomography (For South View)
  //pan_x = render.width/2;        //intial X position of the camera
  //pan_y = render.height/2 -177;  //intial Y position of the camera  
  

}

int cube_side = 400;
float kms_per_side = 50;

//********** TOP View
float init_rot_x = 0;
float init_rot_y = -90;


//********** W-E View (From South)
//float init_rot_x = 0;
//float init_rot_y = 0;

//********** S-N View (From East)
//float init_rot_x = -90; 
//float init_rot_y = 0; 

//********** N-S View (From West)
//float init_rot_x = 90;
//float init_rot_y = 0; 



float init_zoom = 435;
int density_high_thresh = 5;
int density_low_thresh = 1;
float prof_limit = 10.5;