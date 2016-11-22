void setup_UI() {
  b_open = new GButton(this, 0, height*0.95, 100, height*0.05, "OPEN");
  b_open.setLocalColor(2, color(0)); //text color
  b_open.setLocalColor(3, color(0)); //outline color
  b_open.setLocalColor(4, color(255)); //fill color
  b_open.setLocalColor(6, color(0, 255, 0)); //hover fill color

  b_quadtree = new GButton(this, 100, height*0.95, 100, height*0.05, "QUAD");
  b_quadtree.setLocalColor(2, color(0)); //text color
  b_quadtree.setLocalColor(3, color(0)); //outline color
  b_quadtree.setLocalColor(4, color(255)); //fill color
  b_quadtree.setLocalColor(6, color(0, 255, 0)); //hover fill color

  b_export = new GButton(this, 200, height*0.95, 100, height*0.05, "EXPORT");
  b_export.setLocalColor(2, color(0)); //text color
  b_export.setLocalColor(3, color(0)); //outline color
  b_export.setLocalColor(4, color(255)); //fill color
  b_export.setLocalColor(6, color(0, 255, 0)); //hover fill color
}

void setup_sliders() {
  slider_array = new GCustomSlider[brightness_layer_images.length];
  for (int i=0; i<slider_array.length; i++) {
    slider_array[i]=new GCustomSlider(this, DEFAULT_IMAGE_WIDTH+(i%3)*DEFAULT_IMAGE_SCREEN_PREVIEW_WIDTH, floor(i/3)*DEFAULT_IMAGE_SCREEN_PREVIEW_HEIGHT, DEFAULT_IMAGE_SCREEN_PREVIEW_WIDTH, DEFAULT_IMAGE_SCREEN_PREVIEW_HEIGHT, "blue18px");
    slider_array[i].setValue(float(i)/float(slider_array.length));
    slider_array[i].setEasing(10.0);
    brightness_layer_images[i]=run_threshold(resized_input_image, brightness_layer_images[i], slider_array[i].getValueF()*255.0);
    //brightness_layer_images[i]=dither(brightness_layer_images[i],slider_array[i].getValueF());
  }
}

public void handleButtonEvents(GButton button, GEvent event) { 
  if (button==b_open) {
    File default_folder = new File( sketchPath("")+"/ ");
    selectInput("Select a file to process:", "fileSelected", default_folder);
  }

  if (button==b_quadtree) {
    loading=true;
    create_quadtree_from_BRD_layers();
  }

  if (button==b_export) {
    export_BRD();
  }
}

public void handleSliderEvents(GValueControl slider, GEvent event) { 
  for (int i=0; i<slider_array.length; i++) {
    if (slider == slider_array[i]) {
      //brightness_layer_images[i]=dither(brightness_layer_images[i],slider_array[i].getValueF());
      brightness_layer_images[i]=run_threshold(resized_input_image, brightness_layer_images[i], slider_array[i].getValueF()*255.0);
    }
  }
  compose_BRD_layers();
  compose_preview();
}

void fileSelected(File selection) {
  if (selection != null) {
    image_loaded = false;
    String filename = selection.getName();
    filename = filename.toLowerCase();
    int index_of_extension = filename.lastIndexOf('.');
    if (index_of_extension > 0) {
      String extension = filename.substring(index_of_extension+1);
      if (extension.equals("jpg")||extension.equals("png")||extension.equals("bmp")) {
        status_msg = "File is a valid image type: " +extension; 
        input_image = loadImage(selection.getAbsolutePath()); 
        if ((input_image==null)||(input_image.width<=0)||(input_image.height<=0)) {
          status_msg = "Bad or corrupted file data!";
        } else if ((input_image.width>10000)||(input_image.height>10000)) {
          status_msg = "Image dimensions too big";
        } else {
          image_loaded = true;
          copy_input_image_to_resized();
          copy_resized_image_to_brightness_layers();
          init_BRD_layers();
          init_output_preview();
          setup_sliders();
          status_msg = "Image loaded!";
        }
      } else {
        status_msg = "File is NOT a valid image type! (" +extension+ ")";
      }
    }
  } else {
    status_msg = "Wrong filename or filetype";
  }
}

void draw_status_bar(float _x, float _y, float _w, float _h) {
  pushStyle();
  stroke(0);
  fill(255);
  rect (_x, _y, _w, _h);
  fill(0);
  textSize(10);
  int status_text_gap = 20;
  textAlign(LEFT, CENTER);
  text("STATUS: "+status_msg, _x+status_text_gap, _y, _w-status_text_gap*2, _h);
  popStyle();
}

void draw_loading_bar(float _x, float _y, float _w, float _h) {
  pushStyle();
  stroke(0);
  fill(255);
  rect (_x, _y, _w, _h);
  if (loading) {
    loading_percent= qt_count/full_pixel_count;
    if (loading_percent==100)
    {
      loading=false;
    }
    fill(255-loading_percent*255, loading_percent*255, 0);
    rect (_x+2, _y+2, loading_percent*(_w-4), _h-4);
    textSize(10);
    int status_text_gap = 20;
    textAlign(LEFT, CENTER);
    fill(0);
    text("WORK IN PROGRESS // "+int(loading_percent*100.0)+"%", _x+status_text_gap, _y+1, _w-status_text_gap*2, _h);
    text("WORK IN PROGRESS // "+int(loading_percent*100.0)+"%", _x+status_text_gap, _y-1, _w-status_text_gap*2, _h);
    text("WORK IN PROGRESS // "+int(loading_percent*100.0)+"%", _x+status_text_gap-1, _y, _w-status_text_gap*2, _h);
    text("WORK IN PROGRESS // "+int(loading_percent*100.0)+"%", _x+status_text_gap+1, _y, _w-status_text_gap*2, _h);
    text("WORK IN PROGRESS // "+int(loading_percent*100.0)+"%", _x+status_text_gap+1, _y+1, _w-status_text_gap*2, _h);
    text("WORK IN PROGRESS // "+int(loading_percent*100.0)+"%", _x+status_text_gap-1, _y-1, _w-status_text_gap*2, _h);
    text("WORK IN PROGRESS // "+int(loading_percent*100.0)+"%", _x+status_text_gap-1, _y+1, _w-status_text_gap*2, _h);
    text("WORK IN PROGRESS // "+int(loading_percent*100.0)+"%", _x+status_text_gap+1, _y-1, _w-status_text_gap*2, _h);
    fill(255);
    text("WORK IN PROGRESS // "+int(loading_percent*100.0)+"%", _x+status_text_gap, _y, _w-status_text_gap*2, _h);
  } else {
    fill(0);
    textSize(10);
    int status_text_gap = 20;
    textAlign(LEFT, CENTER);
    text("NO TASKS", _x+status_text_gap, _y, _w-status_text_gap*2, _h);
  }
  popStyle();
}