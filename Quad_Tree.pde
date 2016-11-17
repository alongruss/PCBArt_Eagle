void create_quadtree_from_BRD_layers() {
  //if states are set
  if (BRD_layer_images!=null) {
    for (int i=0; i<BRD_layer_images.length; i++) {
      if (BRD_layer_images[i]!=null) {  //then for each brd_layer
        full_pixel_count = BRD_layer_images[i].width*BRD_layer_images[i].height;
        qt_count = 1;
        BRD_layer_images[i].loadPixels();
        Quad_Class_Thread outer_thread;
        outer_thread = new Quad_Class_Thread(number_of_iterations, 0, 0, BRD_layer_images[i].width, BRD_layer_images[i].height, 255, i);
        outer_thread.run();
        BRD_layer_images[i].updatePixels();
      }
    }
  }
}


public class Quad_Class_Thread extends Thread {
  boolean finished;
  int current_iteration;
  float x, y, w, h;
  int my_color;
  boolean waiting;
  Quad_Class_Thread[] quad_thread_array;
  int BRD_id;

  Quad_Class_Thread( int _current_iteration, float _x, float _y, float _w, float _h, int _c, int _BRD_id) {
    finished = true;
    waiting=false;
    current_iteration = _current_iteration;
    x=_x;
    y=_y;
    w=_w;
    h=_h;
    my_color = _c;
    BRD_id=_BRD_id;
  } 

  public void run() {
    // check for fast exit states:

    if (w>=1) { // is this quad smaller than a pixel?
      //if (current_iteration>0) { //is this a potential parent quad?
      //println("than we should check if it is splitable");
      boolean is_splitable = check_if_splitable();
      //println(is_splitable);
      if (is_splitable) {
        split_quad();
      } else { //this is a a leaf quad
        // therefore we should render
        my_color=color(255, 0, 0);
        rect_array[BRD_id] = (Rect_Class[]) append(rect_array[BRD_id], new Rect_Class(x, y, w, h, my_color));
        qt_count += w*h;
      }
    } else {
      finished = true;
    }
  }

  boolean check_if_splitable() {
    if (current_iteration>0) {
      //go over the pixels and find out if any is bigger than 127
      for (int y_index=0; y_index<h; y_index++) {
        for (int x_index=0; x_index<w; x_index++) {
          //int i_index = (x_index+y_index*w)+x+y+y_index*abs(test_image_1.width-w);
          //int current_pixel = (test_image_1.pixels[i_index]) >> 16 & 0xFF;
          int current_pixel =   BRD_layer_images[BRD_id].get(int(x+x_index), int(y+y_index))>> 16 & 0xFF;
          if (current_pixel<127) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void split_quad() {
    quad_thread_array = new Quad_Class_Thread[4];
    for (int i=0; i<4; i++) {
      //println("I'm splitting to quad "+i);
      quad_thread_array[i] = new Quad_Class_Thread((current_iteration-1), (x+(w*0.5)*(i%2)), (y+(h/2)*floor(i*0.5)), (w*0.5), (h*0.5), color(i*255.0*0.25), BRD_id);
      quad_thread_array[i].run();
    } 
    waiting = true;
    while (waiting) { //wait for children to finish!
      if ((quad_thread_array[0].finished==true)
        &&(quad_thread_array[1].finished==true)
        &&(quad_thread_array[2].finished==true)
        &&(quad_thread_array[3].finished==true)) {
        waiting=false;
      }
    }
  }
}