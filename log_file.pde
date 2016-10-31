//log_to_file(Thread.currentThread().getStackTrace()[1].getMethodName(), '\n');


void setup_file() {
  filename = generate_filename();
  file_location = generate_file_location();
  create_file();
}

void create_file() {
  try { 
    //Specify the file name and path here
    println(file_location+"\\"+filename+".txt");
    File file = new File(file_location+"\\"+filename+".txt");

    /* This logic will make sure that the file 
     * gets created if it is not present at the
     * specified location*/
    if (!file.exists()) {
      new File(file_location).mkdir();
      file.createNewFile();
      println("file doesnt exist... creating...");
    }

    FileWriter fw = new FileWriter(file);
    writer = new BufferedWriter(fw);
    writer.write(" ");
    System.out.println("File written Successfully");
  }
  catch (IOException ioe) {
    ioe.printStackTrace();
  }
}

String generate_filename() {
  String temp_filename = "set_"+generate_timestamp();
  return temp_filename;
}

String generate_file_location() {
  String temp_location = sketchPath()+"\\exports\\set_"+generate_timestamp();
  return temp_location;
}

String  generate_timestamp() {
  String temp_timestamp = "";
  temp_timestamp="h"+nf(hour(), 2)+"m"+nf(minute(), 2)+"s"+nf(second(), 2);
  return temp_timestamp;
}

void log_to_file(String _input, char _delim) {
  line_buffer+=_input+_delim;
  if (_delim == '\n') {
    write_line();
  }
}

void write_line() {
  try { 
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(file_location+"\\"+filename+".txt", true)));
    out.print(millis());
    out.print(TAB);
    out.print(line_buffer);
    line_buffer = "";
    out.flush();
    out.close();
  }
  catch (IOException e) {  
    println(e);
    println("write_line failed");
  }
}