void run_qt_thread() {
  full_pixel_count = number_of_thumbs*result_width*result_height;
  qt_count = 0;
  for (int i=0; i<number_of_thumbs; i++) {
    debug_log_output(i+" of "+number_of_thumbs);
    if (DEBUG_DEFAULTS) {
      image_array[2+i]=quadtree(image_array[2+i], DEFAULT_NUMBER_OF_ITERATIONS, i);
    } else {
      image_array[2+i]=quadtree(image_array[2+i], number_of_iterations, i);
    }
  }
  full_pixel_count = 1;
  qt_count = 1;
}

PImage quadtree(PImage _input_image, int _number_of_iterations, int _string_index) {
  log_to_file("Entering " + Thread.currentThread().getStackTrace()[1].getMethodName(), '\n');

  offscreen_buffer = createGraphics(_input_image.width, _input_image.height);
  offscreen_buffer.beginDraw();
  offscreen_buffer.background(255);
  offscreen_buffer.endDraw();
  _input_image.loadPixels();
  brd_layer_string[_string_index] = "";
  run_split(_input_image, 0, 0, _input_image.width, _input_image.height, _number_of_iterations, _string_index);
  log_to_file("Exiting " + Thread.currentThread().getStackTrace()[1].getMethodName(), '\n');
  return offscreen_buffer;
  //image(offscreen_buffer,0,0,_input_image.width,_input_image.height);
}


void run_split(PImage _input_image, float _x, float _y, float _w, float _h, int _input_index, int _string_index) {
  log_to_file("Entering " + Thread.currentThread().getStackTrace()[1].getMethodName(), '\n');
  log_to_file(_input_image+"-"+_x+"-"+_y+"-"+_w+"-"+_h+"-"+_input_index+"-"+_string_index, '\n');
  int new_index = _input_index;
  offscreen_buffer.beginDraw();
  offscreen_buffer.pushStyle();
  offscreen_buffer.noStroke();
  boolean is_solved = check_if_solved(_input_image, (int)_x, (int)_y, (int)_w, (int)_h);
  if (is_solved) {
    offscreen_buffer.fill(0);
    strokeWeight(1.0);
    offscreen_buffer.stroke(0, 200, 0);
    offscreen_buffer.rect(_x, _y, _w, _h);
    brd_layer_string[_string_index]+=output_rect_at(1, _x, _y, _w, _h);
    qt_count += _w*_h;
  } else {
    if (new_index>0) {
      if (DEBUG_MODE_1) println("new_index: "+new_index);
      new_index--;
      for (int i=0; i<4; i++) {
        run_split(_input_image, _x+(i%2)*_w*0.5, _y+floor(i/2)*_h*0.5, _w*0.5, _h*0.5, new_index, _string_index);
      }
    } else {
      qt_count += _w*_h;
    }
  }


  offscreen_buffer.popStyle();
  offscreen_buffer.endDraw();

  log_to_file("Exiting " + Thread.currentThread().getStackTrace()[1].getMethodName(), '\n');
}

boolean check_if_solved(PImage _input_image, int _x, int _y, int _w, int _h) {
  if (_w<=1) {
    return true;
  }
  //int first_pixel = (input_image.pixels[_y*_w+_x]) >> 16 & 0xFF;

  for (int y=_y; y<_y+_h; y++) {
    for (int x=_x; x<_x+_w; x++) {
      int current_pixel = (_input_image.pixels[y*abs(_input_image.width-_w)+y*_w+x]) >> 16 & 0xFF;
      if (current_pixel>127) {
        return false;
      }
    }
  }
  if (DEBUG_MODE_1) println("");
  return true;
}