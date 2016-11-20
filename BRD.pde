void setup_BRD_file() {
  file_location = generate_file_location();
  BRD_writer = createWriter(file_location+"\\"+"positions.brd");
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

void export_BRD() {
  setup_BRD_file();
  write_BRD_prefix();

 //30 29 01 16 21 22
    if (rect_array[0]!=null) {
      for (int j=0; j<rect_array[0].length; j++) {
        write_BRD_rect_at(30,rect_array[0][j].x,rect_array[0][j].y,rect_array[0][j].w,rect_array[0][j].h);
      }
    }
    
    if (rect_array[1]!=null) {
      for (int j=0; j<rect_array[1].length; j++) {
        write_BRD_rect_at(29,rect_array[1][j].x,rect_array[1][j].y,rect_array[1][j].w,rect_array[1][j].h);
      }
    }
    
    if (rect_array[2]!=null) {
      for (int j=0; j<rect_array[2].length; j++) {
        write_BRD_rect_at(1,rect_array[2][j].x,rect_array[2][j].y,rect_array[2][j].w,rect_array[2][j].h);
      }
    }
    
    if (rect_array[3]!=null) {
      for (int j=0; j<rect_array[3].length; j++) {
        write_BRD_rect_at(16,rect_array[3][j].x,rect_array[3][j].y,rect_array[3][j].w,rect_array[3][j].h);
      }
    }
    
    if (rect_array[4]!=null) {
      for (int j=0; j<rect_array[4].length; j++) {
        write_BRD_rect_at(21,rect_array[4][j].x,rect_array[4][j].y,rect_array[4][j].w,rect_array[4][j].h);
      }
    }
    
    if (rect_array[5]!=null) {
      for (int j=0; j<rect_array[5].length; j++) {
        write_BRD_rect_at(22,rect_array[5][j].x,rect_array[5][j].y,rect_array[5][j].w,rect_array[5][j].h);
      }
    }
 

  write_BRD_suffix();
  BRD_close();
}

void write_BRD_rect_at(int _layer, float _xpos, float _ypos, float _width, float _height) {
  String output_line;
  output_line = ("<rectangle x1=\""+_xpos*BRD_scalar+"\" y1=\""+_ypos*BRD_scalar+"\" x2=\""+(_xpos+_width)*BRD_scalar+"\" y2=\""+(_ypos+_height)*BRD_scalar+"\" layer=\""+_layer+"\"/>"+"\n");
  BRD_writer.println(output_line);
}

void write_BRD_prefix() {
  BRD_writer.println("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
  BRD_writer.println("<!DOCTYPE eagle SYSTEM \"eagle.dtd\">");
  BRD_writer.println("<eagle version=\"7.6.0\">");
  BRD_writer.println("<drawing>");
  BRD_writer.println("<settings>");
  BRD_writer.println("<setting alwaysvectorfont=\"no\"/>");
  BRD_writer.println("<setting verticaltext=\"up\"/>");
  BRD_writer.println("</settings>");
  BRD_writer.println("<grid distance=\"0.05\" unitdist=\"inch\" unit=\"inch\" style=\"lines\" multiple=\"1\" display=\"no\" altdistance=\"0.025\" altunitdist=\"inch\" altunit=\"inch\"/>");
  BRD_writer.println("<layers>");
  BRD_writer.println("<layer number=\"1\" name=\"Top\" color=\"4\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"16\" name=\"Bottom\" color=\"1\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"17\" name=\"Pads\" color=\"2\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"18\" name=\"Vias\" color=\"2\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"19\" name=\"Unrouted\" color=\"6\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"20\" name=\"Dimension\" color=\"15\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"21\" name=\"tPlace\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"22\" name=\"bPlace\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"23\" name=\"tOrigins\" color=\"15\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"24\" name=\"bOrigins\" color=\"15\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"25\" name=\"tNames\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"26\" name=\"bNames\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"27\" name=\"tValues\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"28\" name=\"bValues\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"29\" name=\"tStop\" color=\"7\" fill=\"3\" visible=\"no\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"30\" name=\"bStop\" color=\"7\" fill=\"6\" visible=\"no\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"31\" name=\"tCream\" color=\"7\" fill=\"4\" visible=\"no\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"32\" name=\"bCream\" color=\"7\" fill=\"5\" visible=\"no\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"33\" name=\"tFinish\" color=\"6\" fill=\"3\" visible=\"no\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"34\" name=\"bFinish\" color=\"6\" fill=\"6\" visible=\"no\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"35\" name=\"tGlue\" color=\"7\" fill=\"4\" visible=\"no\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"36\" name=\"bGlue\" color=\"7\" fill=\"5\" visible=\"no\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"37\" name=\"tTest\" color=\"7\" fill=\"1\" visible=\"no\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"38\" name=\"bTest\" color=\"7\" fill=\"1\" visible=\"no\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"39\" name=\"tKeepout\" color=\"4\" fill=\"11\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"40\" name=\"bKeepout\" color=\"1\" fill=\"11\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"41\" name=\"tRestrict\" color=\"4\" fill=\"10\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"42\" name=\"bRestrict\" color=\"1\" fill=\"10\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"43\" name=\"vRestrict\" color=\"2\" fill=\"10\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"44\" name=\"Drills\" color=\"7\" fill=\"1\" visible=\"no\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"45\" name=\"Holes\" color=\"7\" fill=\"1\" visible=\"no\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"46\" name=\"Milling\" color=\"3\" fill=\"1\" visible=\"no\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"47\" name=\"Measures\" color=\"7\" fill=\"1\" visible=\"no\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"48\" name=\"Document\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"49\" name=\"Reference\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"51\" name=\"tDocu\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("<layer number=\"52\" name=\"bDocu\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  BRD_writer.println("</layers>");
  BRD_writer.println("<board>");
  BRD_writer.println("<plain>");
}

void write_BRD_suffix() {
  BRD_writer.println("</plain>");
  BRD_writer.println("<libraries>");
  BRD_writer.println("</libraries>");
  BRD_writer.println("<attributes>");
  BRD_writer.println("</attributes>");
  BRD_writer.println("<variantdefs>");
  BRD_writer.println("</variantdefs>");
  BRD_writer.println("<classes>");
  BRD_writer.println("<class number=\"0\" name=\"default\" width=\"0\" drill=\"0\">");
  BRD_writer.println("</class>");
  BRD_writer.println("</classes>");
  BRD_writer.println("<designrules name=\"default\">");
  BRD_writer.println("<description language=\"en\">&lt;b&gt;EAGLE Design Rules&lt;/b&gt;");
  BRD_writer.println("&lt;p&gt;");
  BRD_writer.println("The default Design Rules have been set to cover");
  BRD_writer.println("a wide range of applications. Your particular design");
  BRD_writer.println("may have different requirements, so please make the");
  BRD_writer.println("necessary adjustments and save your customized");
  BRD_writer.println("design rules under a new name.");
  BRD_writer.println("</description>");
  BRD_writer.println("<param name=\"layerSetup\" value=\"(1*16)\"/>");
  BRD_writer.println("<param name=\"mtCopper\" value=\"0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm\"/>");
  BRD_writer.println("<param name=\"mtIsolate\" value=\"1.5mm 0.15mm 0.2mm 0.15mm 0.2mm 0.15mm 0.2mm 0.15mm 0.2mm 0.15mm 0.2mm 0.15mm 0.2mm 0.15mm 0.2mm\"/>");
  BRD_writer.println("<param name=\"mdWireWire\" value=\"8mil\"/>");
  BRD_writer.println("<param name=\"mdWirePad\" value=\"8mil\"/>");
  BRD_writer.println("<param name=\"mdWireVia\" value=\"8mil\"/>");
  BRD_writer.println("<param name=\"mdPadPad\" value=\"8mil\"/>");
  BRD_writer.println("<param name=\"mdPadVia\" value=\"8mil\"/>");
  BRD_writer.println("<param name=\"mdViaVia\" value=\"8mil\"/>");
  BRD_writer.println("<param name=\"mdSmdPad\" value=\"8mil\"/>");
  BRD_writer.println("<param name=\"mdSmdVia\" value=\"8mil\"/>");
  BRD_writer.println("<param name=\"mdSmdSmd\" value=\"8mil\"/>");
  BRD_writer.println("<param name=\"mdViaViaSameLayer\" value=\"8mil\"/>");
  BRD_writer.println("<param name=\"mnLayersViaInSmd\" value=\"2\"/>");
  BRD_writer.println("<param name=\"mdCopperDimension\" value=\"40mil\"/>");
  BRD_writer.println("<param name=\"mdDrill\" value=\"8mil\"/>");
  BRD_writer.println("<param name=\"mdSmdStop\" value=\"0mil\"/>");
  BRD_writer.println("<param name=\"msWidth\" value=\"10mil\"/>");
  BRD_writer.println("<param name=\"msDrill\" value=\"0.6mm\"/>");
  BRD_writer.println("<param name=\"msMicroVia\" value=\"9.99mm\"/>");
  BRD_writer.println("<param name=\"msBlindViaRatio\" value=\"0.5\"/>");
  BRD_writer.println("<param name=\"rvPadTop\" value=\"0.25\"/>");
  BRD_writer.println("<param name=\"rvPadInner\" value=\"0.25\"/>");
  BRD_writer.println("<param name=\"rvPadBottom\" value=\"0.25\"/>");
  BRD_writer.println("<param name=\"rvViaOuter\" value=\"0.25\"/>");
  BRD_writer.println("<param name=\"rvViaInner\" value=\"0.25\"/>");
  BRD_writer.println("<param name=\"rvMicroViaOuter\" value=\"0.25\"/>");
  BRD_writer.println("<param name=\"rvMicroViaInner\" value=\"0.25\"/>");
  BRD_writer.println("<param name=\"rlMinPadTop\" value=\"10mil\"/>");
  BRD_writer.println("<param name=\"rlMaxPadTop\" value=\"20mil\"/>");
  BRD_writer.println("<param name=\"rlMinPadInner\" value=\"10mil\"/>");
  BRD_writer.println("<param name=\"rlMaxPadInner\" value=\"20mil\"/>");
  BRD_writer.println("<param name=\"rlMinPadBottom\" value=\"10mil\"/>");
  BRD_writer.println("<param name=\"rlMaxPadBottom\" value=\"20mil\"/>");
  BRD_writer.println("<param name=\"rlMinViaOuter\" value=\"8mil\"/>");
  BRD_writer.println("<param name=\"rlMaxViaOuter\" value=\"20mil\"/>");
  BRD_writer.println("<param name=\"rlMinViaInner\" value=\"8mil\"/>");
  BRD_writer.println("<param name=\"rlMaxViaInner\" value=\"20mil\"/>");
  BRD_writer.println("<param name=\"rlMinMicroViaOuter\" value=\"4mil\"/>");
  BRD_writer.println("<param name=\"rlMaxMicroViaOuter\" value=\"20mil\"/>");
  BRD_writer.println("<param name=\"rlMinMicroViaInner\" value=\"4mil\"/>");
  BRD_writer.println("<param name=\"rlMaxMicroViaInner\" value=\"20mil\"/>");
  BRD_writer.println("<param name=\"psTop\" value=\"-1\"/>");
  BRD_writer.println("<param name=\"psBottom\" value=\"-1\"/>");
  BRD_writer.println("<param name=\"psFirst\" value=\"-1\"/>");
  BRD_writer.println("<param name=\"psElongationLong\" value=\"100\"/>");
  BRD_writer.println("<param name=\"psElongationOffset\" value=\"100\"/>");
  BRD_writer.println("<param name=\"mvStopFrame\" value=\"1\"/>");
  BRD_writer.println("<param name=\"mvCreamFrame\" value=\"0\"/>");
  BRD_writer.println("<param name=\"mlMinStopFrame\" value=\"4mil\"/>");
  BRD_writer.println("<param name=\"mlMaxStopFrame\" value=\"4mil\"/>");
  BRD_writer.println("<param name=\"mlMinCreamFrame\" value=\"0mil\"/>");
  BRD_writer.println("<param name=\"mlMaxCreamFrame\" value=\"0mil\"/>");
  BRD_writer.println("<param name=\"mlViaStopLimit\" value=\"0mil\"/>");
  BRD_writer.println("<param name=\"srRoundness\" value=\"0\"/>");
  BRD_writer.println("<param name=\"srMinRoundness\" value=\"0mil\"/>");
  BRD_writer.println("<param name=\"srMaxRoundness\" value=\"0mil\"/>");
  BRD_writer.println("<param name=\"slThermalIsolate\" value=\"10mil\"/>");
  BRD_writer.println("<param name=\"slThermalsForVias\" value=\"0\"/>");
  BRD_writer.println("<param name=\"dpMaxLengthDifference\" value=\"10mm\"/>");
  BRD_writer.println("<param name=\"dpGapFactor\" value=\"2.5\"/>");
  BRD_writer.println("<param name=\"checkGrid\" value=\"0\"/>");
  BRD_writer.println("<param name=\"checkAngle\" value=\"0\"/>");
  BRD_writer.println("<param name=\"checkFont\" value=\"1\"/>");
  BRD_writer.println("<param name=\"checkRestrict\" value=\"1\"/>");
  BRD_writer.println("<param name=\"useDiameter\" value=\"13\"/>");
  BRD_writer.println("<param name=\"maxErrors\" value=\"999999\"/>");
  BRD_writer.println("</designrules>");
  BRD_writer.println("<autorouter>");
  BRD_writer.println("<pass name=\"Default\">");
  BRD_writer.println("<param name=\"RoutingGrid\" value=\"50mil\"/>");
  BRD_writer.println("<param name=\"AutoGrid\" value=\"1\"/>");
  BRD_writer.println("<param name=\"Efforts\" value=\"0\"/>");
  BRD_writer.println("<param name=\"TopRouterVariant\" value=\"1\"/>");
  BRD_writer.println("<param name=\"tpViaShape\" value=\"round\"/>");
  BRD_writer.println("<param name=\"PrefDir.1\" value=\"a\"/>");
  BRD_writer.println("<param name=\"PrefDir.2\" value=\"0\"/>");
  BRD_writer.println("<param name=\"PrefDir.3\" value=\"0\"/>");
  BRD_writer.println("<param name=\"PrefDir.4\" value=\"0\"/>");
  BRD_writer.println("<param name=\"PrefDir.5\" value=\"0\"/>");
  BRD_writer.println("<param name=\"PrefDir.6\" value=\"0\"/>");
  BRD_writer.println("<param name=\"PrefDir.7\" value=\"0\"/>");
  BRD_writer.println("<param name=\"PrefDir.8\" value=\"0\"/>");
  BRD_writer.println("<param name=\"PrefDir.9\" value=\"0\"/>");
  BRD_writer.println("<param name=\"PrefDir.10\" value=\"0\"/>");
  BRD_writer.println("<param name=\"PrefDir.11\" value=\"0\"/>");
  BRD_writer.println("<param name=\"PrefDir.12\" value=\"0\"/>");
  BRD_writer.println("<param name=\"PrefDir.13\" value=\"0\"/>");
  BRD_writer.println("<param name=\"PrefDir.14\" value=\"0\"/>");
  BRD_writer.println("<param name=\"PrefDir.15\" value=\"0\"/>");
  BRD_writer.println("<param name=\"PrefDir.16\" value=\"a\"/>");
  BRD_writer.println("<param name=\"cfVia\" value=\"8\"/>");
  BRD_writer.println("<param name=\"cfNonPref\" value=\"5\"/>");
  BRD_writer.println("<param name=\"cfChangeDir\" value=\"2\"/>");
  BRD_writer.println("<param name=\"cfOrthStep\" value=\"2\"/>");
  BRD_writer.println("<param name=\"cfDiagStep\" value=\"3\"/>");
  BRD_writer.println("<param name=\"cfExtdStep\" value=\"0\"/>");
  BRD_writer.println("<param name=\"cfBonusStep\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfMalusStep\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfPadImpact\" value=\"4\"/>");
  BRD_writer.println("<param name=\"cfSmdImpact\" value=\"4\"/>");
  BRD_writer.println("<param name=\"cfBusImpact\" value=\"0\"/>");
  BRD_writer.println("<param name=\"cfHugging\" value=\"3\"/>");
  BRD_writer.println("<param name=\"cfAvoid\" value=\"4\"/>");
  BRD_writer.println("<param name=\"cfPolygon\" value=\"10\"/>");
  BRD_writer.println("<param name=\"cfBase.1\" value=\"0\"/>");
  BRD_writer.println("<param name=\"cfBase.2\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfBase.3\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfBase.4\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfBase.5\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfBase.6\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfBase.7\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfBase.8\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfBase.9\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfBase.10\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfBase.11\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfBase.12\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfBase.13\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfBase.14\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfBase.15\" value=\"1\"/>");
  BRD_writer.println("<param name=\"cfBase.16\" value=\"0\"/>");
  BRD_writer.println("<param name=\"mnVias\" value=\"20\"/>");
  BRD_writer.println("<param name=\"mnSegments\" value=\"9999\"/>");
  BRD_writer.println("<param name=\"mnExtdSteps\" value=\"9999\"/>");
  BRD_writer.println("<param name=\"mnRipupLevel\" value=\"10\"/>");
  BRD_writer.println("<param name=\"mnRipupSteps\" value=\"100\"/>");
  BRD_writer.println("<param name=\"mnRipupTotal\" value=\"100\"/>");
  BRD_writer.println("</pass>");
  BRD_writer.println("<pass name=\"Follow-me\" refer=\"Default\" active=\"yes\">");
  BRD_writer.println("</pass>");
  BRD_writer.println("<pass name=\"Busses\" refer=\"Default\" active=\"yes\">");
  BRD_writer.println("<param name=\"cfNonPref\" value=\"4\"/>");
  BRD_writer.println("<param name=\"cfBusImpact\" value=\"4\"/>");
  BRD_writer.println("<param name=\"cfHugging\" value=\"0\"/>");
  BRD_writer.println("<param name=\"mnVias\" value=\"0\"/>");
  BRD_writer.println("</pass>");
  BRD_writer.println("<pass name=\"Route\" refer=\"Default\" active=\"yes\">");
  BRD_writer.println("</pass>");
  BRD_writer.println("<pass name=\"Optimize1\" refer=\"Default\" active=\"yes\">");
  BRD_writer.println("<param name=\"cfVia\" value=\"99\"/>");
  BRD_writer.println("<param name=\"cfExtdStep\" value=\"10\"/>");
  BRD_writer.println("<param name=\"cfHugging\" value=\"1\"/>");
  BRD_writer.println("<param name=\"mnExtdSteps\" value=\"1\"/>");
  BRD_writer.println("<param name=\"mnRipupLevel\" value=\"0\"/>");
  BRD_writer.println("</pass>");
  BRD_writer.println("<pass name=\"Optimize2\" refer=\"Optimize1\" active=\"yes\">");
  BRD_writer.println("<param name=\"cfNonPref\" value=\"0\"/>");
  BRD_writer.println("<param name=\"cfChangeDir\" value=\"6\"/>");
  BRD_writer.println("<param name=\"cfExtdStep\" value=\"0\"/>");
  BRD_writer.println("<param name=\"cfBonusStep\" value=\"2\"/>");
  BRD_writer.println("<param name=\"cfMalusStep\" value=\"2\"/>");
  BRD_writer.println("<param name=\"cfPadImpact\" value=\"2\"/>");
  BRD_writer.println("<param name=\"cfSmdImpact\" value=\"2\"/>");
  BRD_writer.println("<param name=\"cfHugging\" value=\"0\"/>");
  BRD_writer.println("</pass>");
  BRD_writer.println("<pass name=\"Optimize3\" refer=\"Optimize2\" active=\"yes\">");
  BRD_writer.println("<param name=\"cfChangeDir\" value=\"8\"/>");
  BRD_writer.println("<param name=\"cfPadImpact\" value=\"0\"/>");
  BRD_writer.println("<param name=\"cfSmdImpact\" value=\"0\"/>");
  BRD_writer.println("</pass>");
  BRD_writer.println("<pass name=\"Optimize4\" refer=\"Optimize3\" active=\"yes\">");
  BRD_writer.println("<param name=\"cfChangeDir\" value=\"25\"/>");
  BRD_writer.println("</pass>");
  BRD_writer.println("</autorouter>");
  BRD_writer.println("<elements>");
  BRD_writer.println("</elements>");
  BRD_writer.println("<signals>");
  BRD_writer.println("</signals>");
  BRD_writer.println("</board>");
  BRD_writer.println("</drawing>");
  BRD_writer.println("</eagle>");
}

void BRD_close() {
  BRD_writer.flush(); // Writes the remaining data to the file
  BRD_writer.close(); // Finishes the file
}