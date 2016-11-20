/*
PCBArt
 ------
 
 ver 0.2.4
 Program by: Alon Gruss.
 Last Edited in: 20/11/16.
 
 The app works in following manner:
 image > brightness layers > [BITWISE COMPOSE BRD LAYERS] > export to xml polygons
 (while constantly giving back visual feedback)
 

///////////////////////safe-zone-start/////////////////////////////
/*
  UI
 --------------
 */
import g4p_controls.*;
GButton b_open;
GButton b_quadtree;
GButton b_export;
GCustomSlider[] slider_array;
String status_msg = "";
boolean loading=false;
float loading_percent = 0.5;

/*
  DEBUG CONTROLS
 --------------
 */
boolean DEBUG_NO_IMAGE_MODE = true;

/*
  DEFAULTS
 --------------
 */

int DEFAULT_IMAGE_WIDTH = 500;
int DEFAULT_IMAGE_HEIGHT = 500;
int DEFAULT_IMAGE_SCREEN_PREVIEW_WIDTH = 167;
int DEFAULT_IMAGE_SCREEN_PREVIEW_HEIGHT = 167;
int DEFAULT_IMAGE_BRD_LAYER_PREVIEW_WIDTH = 84;
int DEFAULT_IMAGE_BRD_LAYER_PREVIEW_HEIGHT = 84;

int DEFAULT_WINDOW_WIDTH = 2*DEFAULT_IMAGE_WIDTH+3*DEFAULT_IMAGE_SCREEN_PREVIEW_WIDTH+DEFAULT_IMAGE_BRD_LAYER_PREVIEW_WIDTH;
int DEFAULT_WINDOW_HEIGHT = 530;
int DEFAULT_STATUS_BAR_WIDTH = DEFAULT_WINDOW_WIDTH-1;
int DEFAULT_STATUS_BAR_HEIGHT = 30;

/*
  IMAGES
 --------------
 */
PImage input_image;
PImage resized_input_image;
PImage[] brightness_layer_images = new PImage[8];
PImage[] BRD_layer_images = new PImage[6];
PImage output_preview_image;


/*
  IO
 --------------
 */
boolean image_loaded = false;
PrintWriter BRD_writer;
String file_location = "";
float BRD_scalar = 0.075;

/*
  QUADTREE
 --------------
 */
Quad_Class_Thread outer_thread;
int number_of_iterations = 12;
Rect_Class[][] rect_array;
int qt_count = 0;
int full_pixel_count = 1;


void settings() {
  size(DEFAULT_WINDOW_WIDTH, DEFAULT_WINDOW_HEIGHT);
  noSmooth();
}

void setup() {
  surface.setTitle("PCB as ART ver.0.2.2");
  setup_UI();
  rect_array = new Rect_Class[6][0];
  //for (int i=0;i<rect_array.length;i++){
  // rect_array[i] = new Rect_Class[0];
  //}
}

void draw() {
 
 //loading_percent = mouseX/float(width);
  background(200);
  stroke(0);
  fill(100);
  if (image_loaded) {
    if (resized_input_image!=null) {
      image(resized_input_image, 0, 0, DEFAULT_IMAGE_WIDTH, DEFAULT_IMAGE_HEIGHT);
    }

    for (int i=0; i<brightness_layer_images.length; i++) {
      if (brightness_layer_images[i]!=null) {
        image(brightness_layer_images[i], DEFAULT_IMAGE_WIDTH+(i%3)*DEFAULT_IMAGE_SCREEN_PREVIEW_WIDTH, floor(i/3)*DEFAULT_IMAGE_SCREEN_PREVIEW_HEIGHT, DEFAULT_IMAGE_SCREEN_PREVIEW_WIDTH, DEFAULT_IMAGE_SCREEN_PREVIEW_HEIGHT);
        noFill();
        rect(DEFAULT_IMAGE_WIDTH+(i%3)*DEFAULT_IMAGE_SCREEN_PREVIEW_WIDTH, floor(i/3)*DEFAULT_IMAGE_SCREEN_PREVIEW_HEIGHT, DEFAULT_IMAGE_SCREEN_PREVIEW_WIDTH, DEFAULT_IMAGE_SCREEN_PREVIEW_HEIGHT);
      } else {
        //fill(255,0,0); 
        //rect(DEFAULT_IMAGE_WIDTH+(i%3)*DEFAULT_IMAGE_SCREEN_PREVIEW_WIDTH, floor(i/3)*DEFAULT_IMAGE_SCREEN_PREVIEW_HEIGHT, DEFAULT_IMAGE_SCREEN_PREVIEW_WIDTH, DEFAULT_IMAGE_SCREEN_PREVIEW_HEIGHT);
      }
    }

    for (int i=0; i<BRD_layer_images.length; i++) {
      if (BRD_layer_images[i]!=null) {
        image(BRD_layer_images[i], DEFAULT_IMAGE_WIDTH+3*DEFAULT_IMAGE_SCREEN_PREVIEW_WIDTH, i*DEFAULT_IMAGE_BRD_LAYER_PREVIEW_HEIGHT, DEFAULT_IMAGE_BRD_LAYER_PREVIEW_WIDTH, DEFAULT_IMAGE_BRD_LAYER_PREVIEW_HEIGHT);
        noFill();
        rect(DEFAULT_IMAGE_WIDTH+3*DEFAULT_IMAGE_SCREEN_PREVIEW_WIDTH, i*DEFAULT_IMAGE_BRD_LAYER_PREVIEW_HEIGHT, DEFAULT_IMAGE_BRD_LAYER_PREVIEW_WIDTH, DEFAULT_IMAGE_BRD_LAYER_PREVIEW_HEIGHT);
      } else {
        //fill(255,0,0); 
        //rect(DEFAULT_IMAGE_WIDTH+3*DEFAULT_IMAGE_SCREEN_PREVIEW_WIDTH, i*DEFAULT_IMAGE_BRD_LAYER_PREVIEW_HEIGHT, DEFAULT_IMAGE_BRD_LAYER_PREVIEW_WIDTH, DEFAULT_IMAGE_BRD_LAYER_PREVIEW_HEIGHT);
      }
    }

   //for (int i=0; i<rect_array.length; i++) {
      if (rect_array[3]!=null) {
        for (int j=0; j<rect_array[3].length; j++) {
          rect_array[3][j].display();
        }
      }
    //}

    if (output_preview_image!=null) {
      image(output_preview_image, DEFAULT_WINDOW_WIDTH-DEFAULT_IMAGE_WIDTH, 0, DEFAULT_IMAGE_WIDTH, DEFAULT_IMAGE_HEIGHT);
      noFill();
      rect(DEFAULT_WINDOW_WIDTH-DEFAULT_IMAGE_WIDTH, 0, DEFAULT_IMAGE_WIDTH, DEFAULT_IMAGE_HEIGHT);
    } else {
      //fill(255,0,0); 
      //rect(DEFAULT_WINDOW_WIDTH-DEFAULT_IMAGE_WIDTH, 0, DEFAULT_IMAGE_WIDTH, DEFAULT_IMAGE_HEIGHT);
    }
  }
  draw_status_bar(300, DEFAULT_WINDOW_HEIGHT-DEFAULT_STATUS_BAR_HEIGHT, (DEFAULT_STATUS_BAR_WIDTH-300)*0.5, DEFAULT_STATUS_BAR_HEIGHT-1);
  draw_loading_bar(300+(DEFAULT_STATUS_BAR_WIDTH-300)*0.5, DEFAULT_WINDOW_HEIGHT-DEFAULT_STATUS_BAR_HEIGHT, (DEFAULT_STATUS_BAR_WIDTH-300)*0.5, DEFAULT_STATUS_BAR_HEIGHT-1);
}
/////////////////////////safe-zone-finish/////////////////////////////