/*
PCBArt
 ------
 
 Program by: Alon Gruss.
 Last Edited in: 31/10/16.
 */


/*
 TODO:
 - find out how to import into eagle per layer.
 - create console bar at bottom of prgoram.
 - remove unused PImage (last in array).
 - reshape open and save GUI.
 - have an int_list for the layer name (is this needed?).
 */


/////////////////////////safe-zone-start/////////////////////////////
/////////////////////////safe-zone-finish/////////////////////////////


import java.io.BufferedWriter;
import java.io.FileWriter;
import g4p_controls.*;


GGroup grpMain;
GCustomSlider[] slider_array;
GButton b_open;
GButton b_export;


PFont font;

IntDict layer_index_dict;
PrintWriter output;
String brd_prefix_string;
String[] brd_layer_string;
String brd_suffix_string;


boolean DEBUG_MODE_1 = false;
boolean DEBUG_MODE = true;
boolean DEBUG_AUTO_IMAGE_LOAD = true;
boolean DEBUG_AUTO_IMAGE_SLICE = true;
PImage[] image_array;
PGraphics pg_preview;
String time_stamp = nf(hour())+nf(minute())+nf(second());
int number_of_thumbs;
int number_of_thumbs_squared;
int size_of_thumb;
int thumb_gap;
int result_width;
int result_height;

int number_of_iterations = 6;

PGraphics offscreen_buffer;

/*
FILE I/O
 --------------
 */
// file saving
BufferedWriter writer = null;
String filename = "";
String file_location = "";
String line_buffer = "";

void settings() {
  size(1500, 500);
  noSmooth();
}

void setup() {
  setup_file();
  
  setup_layer_indices();  
  setup_brd_strings();
  surface.setTitle("PCB as ART");
  font = createFont("arial.ttf", 24);
  result_width = 500;
  result_height = 500;
  image_array = new PImage[9];

  pg_preview = createGraphics(height, height);
  for (int i=0; i<image_array.length; i++) {
    image_array[i] = createImage(result_width, result_height, RGB);
    clear_image(image_array[i], color(random(255), random(255), random(255)));
  }

  number_of_thumbs= image_array.length-3;
  number_of_thumbs_squared = ceil(sqrt(number_of_thumbs));
  size_of_thumb = int(height/float(number_of_thumbs_squared));
  thumb_gap = 1;

  slider_array = new GCustomSlider[number_of_thumbs];
  for (int y=0; y<number_of_thumbs_squared; y++) {
    for (int x=0; x<number_of_thumbs_squared; x++) {
      if (x*number_of_thumbs_squared+y<number_of_thumbs) {
        slider_array[x*number_of_thumbs_squared+y] = 
          new GCustomSlider(this, height+(x)*(size_of_thumb+thumb_gap), y*(size_of_thumb+thumb_gap), size_of_thumb-1, size_of_thumb*2-20, "blue18px");
        slider_array[x*number_of_thumbs_squared+y].setValue(((x*number_of_thumbs_squared+y)/float(number_of_thumbs)));
        //println(((x*number_of_thumbs_squared+y)/float(number_of_thumbs));
        slider_array[x*number_of_thumbs_squared+y].setEasing(10.0);
      }
    }
  }
  //for (int i=0; i<slider_array.length; i++) {
  //  slider_array[i] = new GCustomSlider(this, 250, 60*i, 150, 50, null);
  //  slider_array[i].setEasing(10.0);
  //}

  b_open = new GButton(this, 0, height*0.95, 100, height*0.05, "OPEN");
  b_open.setLocalColor(2, color(0)); //text color
  b_open.setLocalColor(3, color(0)); //outline color
  b_open.setLocalColor(4, color(255)); //fill color
  b_open.setLocalColor(6, color(0, 255, 0)); //hover fill color

  b_export = new GButton(this, 100, height*0.95, 100, height*0.05, "EXPORT");
  b_export.setLocalColor(2, color(0)); //text color
  b_export.setLocalColor(3, color(0)); //outline color
  b_export.setLocalColor(4, color(255)); //fill color
  b_export.setLocalColor(6, color(0, 255, 0)); //hover fill color


  grpMain = new GGroup(this);
  grpMain.setOpaque(true);
  grpMain.addControls(b_open, b_export);


  if (DEBUG_AUTO_IMAGE_LOAD) {
    //image_array[0]=loadImage("6fvwkqsr.jpg");
    image_array[0]=loadImage("alongruss.jpg");
    //debug_log_output("image loaded");
    //debug_log_output("image width: " + image_array[0].width);
    //debug_log_output("image height: " + image_array[0].height);
    image_array[1].copy(image_array[0], 0, 0, image_array[0].width, image_array[0].height, 0, 0, image_array[1].width, image_array[1].height);
    
  }

  if (DEBUG_AUTO_IMAGE_SLICE) {
    slice_to_layers(image_array[1]);
    
  }
  
  log_to_file(Thread.currentThread().getStackTrace()[1].getMethodName(), '\n');
}

public void handleSliderEvents(GValueControl slider, GEvent event) { 
  for (int i=0; i<slider_array.length; i++) {
    if (slider == slider_array[i]) {
      image_array[i+2]=run_threshold(image_array[1], image_array[i+2], slider_array[i].getValueF()*255.0).get();
    }
  }
  //update();
}

public void handleButtonEvents(GButton button, GEvent event) { 
  if (button==b_open) {
    File default_folder = new File( sketchPath("")+"/ ");
    selectInput("Select a file to process:", "fileSelected", default_folder);
    //pg_preview = createGraphics(height, height);
    pg_preview.beginDraw();
    pg_preview.background(100, 200, 50);
    pg_preview.endDraw();
  } else if (button==b_export) {
    export_to_layers();
    output_brd();
  }
}

void draw() {
  background(0);

  image(image_array[1], 0, 0, height, height); 

  for (int y=0; y<number_of_thumbs_squared; y++) {
    for (int x=0; x<number_of_thumbs_squared; x++) {
      if (x*number_of_thumbs_squared+y<number_of_thumbs) {
        image(image_array[2+x*number_of_thumbs_squared+y], height+(x)*(size_of_thumb+thumb_gap), y*(size_of_thumb+thumb_gap), size_of_thumb-1, size_of_thumb-1);
      }
    }
  }

  pg_preview.beginDraw();
  pg_preview.background(100, 200, 50);

  for (int i=2; i<image_array.length-2; i++) {
    pg_preview.tint(100, 200, 50, 255.0/(number_of_thumbs+1));
    pg_preview.image(image_array[i], 0, 0, pg_preview.width, pg_preview.height);
  }
  pg_preview.tint(255, 255);
  pg_preview.blend(image_array[image_array.length-2], 0, 0, pg_preview.width, pg_preview.height, 0, 0, pg_preview.width, pg_preview.height, LIGHTEST);
  //pg_preview.image(image_array[image_array.length-2], 0, 0, pg_preview.width, pg_preview.height);
  pg_preview.endDraw();

  image(pg_preview, height*2, 0, height, height);
}


void clear_image(PImage input_image, color input_color) {
  input_image.loadPixels();
  for (int i = 0; i < input_image.width*input_image.height; i++) {
    input_image.pixels[i] = color(input_color);
  }
  input_image.updatePixels();
}

void convert_to_BW(PImage input_image, int conversion_mode) {
  input_image.loadPixels();
  float temp_red =0;
  float temp_green =0;
  float temp_blue =0;
  float temp_red_weight =1;
  float temp_green_weight =1;
  float temp_blue_weight =1;

  for (int i = 0; i < input_image.width*input_image.height; i++) {
    temp_red = (input_image.pixels[i] >> 16 & 0xFF);
    temp_green = (input_image.pixels[i] >> 8 & 0xFF);
    temp_blue = (input_image.pixels[i] >> 0xFF);
    if (conversion_mode==1) {
      temp_red_weight = abs(127-temp_red)/127;
      temp_green_weight = abs(127-temp_green)/127;
      temp_blue_weight = abs(127-temp_blue)/127;
    }
    input_image.pixels[i] = color(2*(temp_red*temp_red_weight+temp_green*temp_green_weight+temp_blue*temp_blue_weight)/(temp_red_weight+temp_green_weight+temp_blue_weight));
  }
  input_image.updatePixels();
}

void copy_image(PImage input_image, PImage output_image) {
  //if (DEBUG_MODE) debug_log_output("entering: "+ Thread.currentThread().getStackTrace()[1].getMethodName());

  //float width_size_scalar = float(output_image.width)/float(input_image.width);
  //if (DEBUG_MODE) debug_log_output("width_size_scalar: " + width_size_scalar);
  //float height_size_scalar = float(output_image.height)/float(input_image.height);
  // if (DEBUG_MODE) debug_log_output("height_size_scalar: " + height_size_scalar);


  //input_image.loadPixels();
  //output_image.loadPixels();
  //for (int i = 0; i < output_image.width*output_image.height; i++) {
  //  output_image.pixels[i] = input_image.pixels[int(i*width_size_scalar+i*height_size_scalar)];
  //}
  //output_image.updatePixels();

  //if (DEBUG_MODE) debug_log_output("exiting: "+ Thread.currentThread().getStackTrace()[1].getMethodName());
}
void slice_to_layers(PImage input_image) {
  for (int i=0; i<number_of_thumbs; i++) {
    clear_image(image_array[i+2], color(255));
    image_array[i+2]=run_threshold(input_image, image_array[i+2], i*255/number_of_thumbs);
  }
}

PImage run_threshold(PImage _source_image, PImage _input_image, float _input_value) {
  float temp_brightness=0;
  _input_image.loadPixels();
  for (int i = 0; i < _source_image.width*_source_image.height; i++) {
    temp_brightness = (_source_image.pixels[i] >> 16 & 0xFF);
    //println(temp_brightness);
    if (temp_brightness>_input_value) {
      _input_image.pixels[i] = color(255);
    } else {
      _input_image.pixels[i] = color(0);
    }
  }
  _input_image.updatePixels();

  return(_input_image);
}



void keyPressed() {
  log_to_file("Entering " + Thread.currentThread().getStackTrace()[1].getMethodName(), '\n');
  log_to_file("key pressed: "+ key, '\n');
  
  
  if (key == 'o') {
    File default_folder = new File( sketchPath("")+"/ ");
    selectInput("Select a file to process:", "fileSelected", default_folder);
  } else if (key == 't') {
    //copy_image(input_image_1, pg_TOP);
    image_array[1].copy(image_array[0], 0, 0, image_array[0].width, image_array[0].height, 0, 0, image_array[1].width, image_array[1].height);
   
  } else if (key == 'b') {
    convert_to_BW(image_array[1], 1);
  
  } else if (key == 'u') {
    slice_to_layers(image_array[1]);
   
  } else if (key == 's') {
    export_to_layers();
    exit();
  } else if (key == 'k') {
    for (int i=0; i<number_of_thumbs; i++) {
      debug_log_output(i+" of "+number_of_thumbs);
      image_array[2+i]=quadtree(image_array[2+i], number_of_iterations,i);
    }
  } else {
  }
  log_to_file("Exiting " + Thread.currentThread().getStackTrace()[1].getMethodName(), '\n');
}

void fileSelected(File selection) {
  if (selection == null) {
    //debug_log_output("Window was closed or the user hit cancel.");
  } else {
    //debug_log_output("User selected " + selection.getAbsolutePath());
    image_array[0] = loadImage(selection.getAbsolutePath());
    //debug_log_output("image loaded");
    // debug_log_output("image width: " + image_array[0].width);
    //debug_log_output("image height: " + image_array[0].height);
    image_array[1].copy(image_array[0], 0, 0, image_array[0].width, image_array[0].height, 0, 0, image_array[1].width, image_array[1].height);
  
  }
}

void debug_log_output(String input) {
  println(input);

}