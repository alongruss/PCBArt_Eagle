PImage quadtree(PImage _input_image, int _number_of_iterations, int _string_index) {
  offscreen_buffer = createGraphics(_input_image.width, _input_image.height);
  _input_image.loadPixels();
  brd_layer_string[_string_index] = "";
  run_split(_input_image, 0, 0, _input_image.width, _input_image.height, _number_of_iterations, _string_index);
  return offscreen_buffer;
  //image(offscreen_buffer,0,0,_input_image.width,_input_image.height);
  
}


void run_split(PImage _input_image, float _x, float _y, float _w, float _h, int _input_index, int _string_index) {
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
    brd_layer_string[_string_index]+=output_rect_at(1,_x, _y, _w, _h);
    // output.print(1+","+(int)_x+","+(int)_y+","+(int)_w);
  } else {
    if (new_index>0) {
      if (DEBUG_MODE_1) println("new_index: "+new_index);
      new_index--;
      for (int i=0; i<4; i++) {
        run_split(_input_image, _x+(i%2)*_w*0.5, _y+floor(i/2)*_h*0.5, _w*0.5, _h*0.5, new_index, _string_index);
      }
    } else {
      //offscreen_buffer.stroke(0, 0, 255);
      offscreen_buffer.fill(255);
      offscreen_buffer.rect(_x, _y, _w, _h);
    }
  }
  offscreen_buffer.popStyle();
  offscreen_buffer.endDraw();
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