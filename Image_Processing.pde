void copy_input_image_to_resized() {
  resized_input_image = createImage(DEFAULT_IMAGE_WIDTH, DEFAULT_IMAGE_HEIGHT, RGB);
  resized_input_image.copy(input_image, 0, 0, input_image.width, input_image.height, 0, 0, resized_input_image.width, resized_input_image.height);
}

void copy_resized_image_to_brightness_layers() {
  for (int i=0; i<brightness_layer_images.length; i++) {
    brightness_layer_images[i] = createImage(DEFAULT_IMAGE_WIDTH, DEFAULT_IMAGE_HEIGHT, RGB);
    brightness_layer_images[i].copy(resized_input_image, 0, 0, resized_input_image.width, resized_input_image.height, 0, 0, brightness_layer_images[i].width, brightness_layer_images[i].height);
  }
}

void init_BRD_layers() {
  for (int i=0; i<BRD_layer_images.length; i++) {
    BRD_layer_images[i] = createImage(DEFAULT_IMAGE_WIDTH, DEFAULT_IMAGE_HEIGHT, RGB);
  }
}

void init_output_preview() {
  output_preview_image = createImage(DEFAULT_IMAGE_WIDTH, DEFAULT_IMAGE_HEIGHT, RGB);
}

PImage dither(PImage _input_for_dither, float _input_value) {
   _input_for_dither.copy(resized_input_image, 0, 0, resized_input_image.width, resized_input_image.height, 0, 0, _input_for_dither.width, _input_for_dither.height);
  _input_for_dither.loadPixels();
  for (int y=0; y<_input_for_dither.height-1; y++) {
    for (int x=0; x<_input_for_dither.width-1; x++) {
      int oldpixel = constrain((_input_for_dither.pixels[x+y*_input_for_dither.width] >> 16 & 0xFF)+int(255.0*(1-_input_value)-127.0),0,255);
      int newpixel  = 255*round((oldpixel)/(255.0));
      _input_for_dither.pixels[x+y*_input_for_dither.width] = color(newpixel);
      int quant_error  = oldpixel - newpixel;
      float color_1 = (((_input_for_dither.pixels[(x+1)+(y+0)*_input_for_dither.width]>> 16 & 0xFF) + quant_error * 7/ 16));
      float color_2 = (((_input_for_dither.pixels[(x-1)+(y+1)*_input_for_dither.width]>> 16 & 0xFF) + quant_error * 3/ 16));
      float color_3 = (((_input_for_dither.pixels[(x+0)+(y+1)*_input_for_dither.width]>> 16 & 0xFF) + quant_error * 5/ 16));
      float color_4 = (((_input_for_dither.pixels[(x+1)+(y+1)*_input_for_dither.width]>> 16 & 0xFF) + quant_error * 1 / 16));
      _input_for_dither.pixels[(x+1)+(y+0)*_input_for_dither.width] = color(color_1);
      _input_for_dither.pixels[(x-1)+(y+1)*_input_for_dither.width] = color(color_2);
      _input_for_dither.pixels[(x+0)+(y+1)*_input_for_dither.width] = color(color_3);
      _input_for_dither.pixels[(x+1)+(y+1)*_input_for_dither.width] = color(color_4);
    }
  }
  _input_for_dither.updatePixels();
  return(_input_for_dither);
}

PImage run_threshold(PImage _source_image, PImage _input_image, float _input_value) {
  float temp_brightness=0;
  _input_image.loadPixels();
  for (int i = 0; i < _source_image.width*_source_image.height; i++) {
    temp_brightness = (_source_image.pixels[i] >> 16 & 0xFF);
    if (temp_brightness>_input_value) {
      _input_image.pixels[i] = color(255);
    } else {
      _input_image.pixels[i] = color(0);
    }
  }
  _input_image.updatePixels();
  return(_input_image);
}

void compose_BRD_layers() {





  BRD_layer_images[1].loadPixels(); //composing tStop
  for (int i = 0; i < BRD_layer_images[1].width*BRD_layer_images[1].height; i++) {
    BRD_layer_images[1].pixels[i] =
      (~((~brightness_layer_images[1].pixels[i])
      |(brightness_layer_images[2].pixels[i])
      |(brightness_layer_images[3].pixels[i])
      |(brightness_layer_images[4].pixels[i])
      |(brightness_layer_images[5].pixels[i])
      |(brightness_layer_images[6].pixels[i])))
      &((~brightness_layer_images[0].pixels[i])
      |(~brightness_layer_images[7].pixels[i]));
  }
  BRD_layer_images[1].updatePixels(); 



  BRD_layer_images[0].loadPixels();  //composing bStop
  for (int i = 0; i < BRD_layer_images[0].width*BRD_layer_images[0].height; i++) {
    BRD_layer_images[0].pixels[i] =
      (~((brightness_layer_images[3].pixels[i])
      |(brightness_layer_images[4].pixels[i])
      |(brightness_layer_images[5].pixels[i])))
      &((~brightness_layer_images[0].pixels[i])
      |(~brightness_layer_images[1].pixels[i]));
  }
  BRD_layer_images[0].updatePixels(); 

  BRD_layer_images[2].loadPixels(); //composing TOP
  for (int i = 0; i < BRD_layer_images[2].width*BRD_layer_images[2].height; i++) {
    BRD_layer_images[2].pixels[i] =
      ~(~((~brightness_layer_images[0].pixels[i])
      |(~brightness_layer_images[1].pixels[i])
      |(brightness_layer_images[3].pixels[i])
      |(brightness_layer_images[4].pixels[i])
      |(brightness_layer_images[5].pixels[i])
      |(brightness_layer_images[6].pixels[i])))
      &((brightness_layer_images[2].pixels[i])
      |(~brightness_layer_images[7].pixels[i]));
  }
  BRD_layer_images[2].updatePixels(); 


  BRD_layer_images[3].loadPixels(); //composing BOTTOM
  for (int i = 0; i < BRD_layer_images[3].width*BRD_layer_images[3].height; i++) {
    BRD_layer_images[3].pixels[i] =
      ~(~((~brightness_layer_images[0].pixels[i])
      |(~brightness_layer_images[1].pixels[i])
      |(brightness_layer_images[3].pixels[i])
      |(brightness_layer_images[4].pixels[i])))
      &(brightness_layer_images[5].pixels[i]);
  }
  BRD_layer_images[3].updatePixels(); 

  BRD_layer_images[4].loadPixels(); //composing tPlace
  for (int i = 0; i < BRD_layer_images[4].width*BRD_layer_images[4].height; i++) {
    BRD_layer_images[4].pixels[i] =
      ~(~((~brightness_layer_images[0].pixels[i])
      |(~brightness_layer_images[1].pixels[i])
      |(brightness_layer_images[2].pixels[i])
      |(brightness_layer_images[3].pixels[i])
      |(brightness_layer_images[4].pixels[i])
      |(brightness_layer_images[5].pixels[i])
      |(~brightness_layer_images[7].pixels[i])))
      &(brightness_layer_images[6].pixels[i]);
  }
  BRD_layer_images[4].updatePixels(); 

  BRD_layer_images[5].loadPixels(); //composing bPlace
  for (int i = 0; i < BRD_layer_images[5].width*BRD_layer_images[5].height; i++) {
    BRD_layer_images[5].pixels[i] =
      ~(~((~brightness_layer_images[0].pixels[i])
      |(~brightness_layer_images[1].pixels[i])
      |(brightness_layer_images[3].pixels[i])
      |(brightness_layer_images[5].pixels[i])))
      &(brightness_layer_images[4].pixels[i]);
  }
  BRD_layer_images[5].updatePixels();
}

void compose_preview() {
  output_preview_image.loadPixels(); //composing preview
  float temp_red = 0;
  float temp_green = 0;
  float temp_blue = 0;
  for (int i = 0; i < output_preview_image.width*output_preview_image.height; i++) {
    temp_red+=(255-(BRD_layer_images[0].pixels[i] & 0xFF))*0.2;
    temp_red+=(255-(BRD_layer_images[1].pixels[i] & 0xFF))*0.2;
    temp_red+=(BRD_layer_images[2].pixels[i] & 0xFF)*0.2;
    temp_red+=(BRD_layer_images[3].pixels[i] & 0xFF)*0.2;
    temp_red/=4;
    temp_green+=(255-(BRD_layer_images[0].pixels[i] & 0xFF))*0.5;
    temp_green+=(255-(BRD_layer_images[1].pixels[i] & 0xFF))*0.5;
    temp_green+=(BRD_layer_images[2].pixels[i] & 0xFF)*0.5;
    temp_green+=(BRD_layer_images[3].pixels[i] & 0xFF)*0.5;
    temp_green/=4;
    temp_blue+=(255-(BRD_layer_images[0].pixels[i] & 0xFF))*0.1;
    temp_blue+=(255-(BRD_layer_images[1].pixels[i] & 0xFF))*0.1;
    temp_blue+=(BRD_layer_images[2].pixels[i] & 0xFF)*0.1;
    temp_blue+=(BRD_layer_images[3].pixels[i] & 0xFF)*0.1;
    temp_blue/=4;
    output_preview_image.pixels[i] = color(temp_red, temp_green, temp_blue);
  }
  output_preview_image.updatePixels();
}