void export_to_layers() {
  log_to_file("Entering " + Thread.currentThread().getStackTrace()[1].getMethodName(), '\n');
  for (int i=1; i<image_array.length-1; i++) {
    image_array[i].save(file_location+"\\"+i+".jpg");
  }
  pg_preview.save(file_location+"\\"+(image_array.length-1)+".jpg");
  log_to_file("Exiting " + Thread.currentThread().getStackTrace()[1].getMethodName(), '\n');
}