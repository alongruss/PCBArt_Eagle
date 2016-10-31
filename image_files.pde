void export_to_layers() {
  for (int i=1; i<image_array.length-1; i++) {
    image_array[i].save("exports/"+time_stamp+"/"+i+".jpg");
  }
  pg_preview.save("exports/"+time_stamp+"/"+(image_array.length-1)+".jpg");
}