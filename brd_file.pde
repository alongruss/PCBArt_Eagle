void setup_brd_file() {
  output = createWriter("exports/"+time_stamp+"/positions.brd");
}

void setup_brd_strings() {
  brd_layer_string = new String[6];
  for (int i=0; i<brd_layer_string.length; i++) {
    brd_layer_string[i] = "";
  }
}

void setup_layer_indices() {
  layer_index_dict = new IntDict();
  layer_index_dict.set("Top", 1);
  layer_index_dict.set("Bottom", 16);
  layer_index_dict.set("Pads", 17);
  layer_index_dict.set("Vias", 18);
  layer_index_dict.set("Unrouted", 19);
  layer_index_dict.set("Dimension", 20);
  layer_index_dict.set("tPlace", 21);
  layer_index_dict.set("bPlace", 22);
  layer_index_dict.set("tOrigins", 23);
  layer_index_dict.set("bOrigins", 24);
  layer_index_dict.set("tNames", 25);
  layer_index_dict.set("bNames", 26);
  layer_index_dict.set("tValues", 27);
  layer_index_dict.set("bValues", 28);
  layer_index_dict.set("tStop", 29);
  layer_index_dict.set("bStop", 30);
  layer_index_dict.set("tCream", 31);
  layer_index_dict.set("bCream", 32);
  layer_index_dict.set("tFinish", 33);
  layer_index_dict.set("bFinish", 34);
  layer_index_dict.set("tGlue", 35);
  layer_index_dict.set("bGlue", 36);
  layer_index_dict.set("tTest", 37);
  layer_index_dict.set("bTest", 38);
  layer_index_dict.set("tKeepout", 39);
  layer_index_dict.set("bKeepout", 40);
  layer_index_dict.set("tRestrict", 41);
  layer_index_dict.set("bRestrict", 42);
  layer_index_dict.set("vRestrict", 43);
  layer_index_dict.set("Drills", 44);
  layer_index_dict.set("Holes", 45);
  layer_index_dict.set("Milling", 46);
  layer_index_dict.set("Measures", 47);
  layer_index_dict.set("Document", 48);
  layer_index_dict.set("Reference", 49);
  layer_index_dict.set("tDocu", 51);
  layer_index_dict.set("bDocu", 52);
}

void setup_brd_prefix() {
}

void setup_brd_suffix() {
}

void output_brd_prefix() {
  output.println("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
  output.println("<!DOCTYPE eagle SYSTEM \"eagle.dtd\">");
  output.println("<eagle version=\"7.6.0\">");
  output.println("<drawing>");
  output.println("<settings>");
  output.println("<setting alwaysvectorfont=\"no\"/>");
  output.println("<setting verticaltext=\"up\"/>");
  output.println("</settings>");
  output.println("<grid distance=\"0.05\" unitdist=\"inch\" unit=\"inch\" style=\"lines\" multiple=\"1\" display=\"no\" altdistance=\"0.025\" altunitdist=\"inch\" altunit=\"inch\"/>");
  output.println("<layers>");
  output.println("<layer number=\"1\" name=\"Top\" color=\"4\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"16\" name=\"Bottom\" color=\"1\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"17\" name=\"Pads\" color=\"2\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"18\" name=\"Vias\" color=\"2\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"19\" name=\"Unrouted\" color=\"6\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"20\" name=\"Dimension\" color=\"15\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"21\" name=\"tPlace\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"22\" name=\"bPlace\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"23\" name=\"tOrigins\" color=\"15\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"24\" name=\"bOrigins\" color=\"15\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"25\" name=\"tNames\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"26\" name=\"bNames\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"27\" name=\"tValues\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"28\" name=\"bValues\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"29\" name=\"tStop\" color=\"7\" fill=\"3\" visible=\"no\" active=\"yes\"/>");
  output.println("<layer number=\"30\" name=\"bStop\" color=\"7\" fill=\"6\" visible=\"no\" active=\"yes\"/>");
  output.println("<layer number=\"31\" name=\"tCream\" color=\"7\" fill=\"4\" visible=\"no\" active=\"yes\"/>");
  output.println("<layer number=\"32\" name=\"bCream\" color=\"7\" fill=\"5\" visible=\"no\" active=\"yes\"/>");
  output.println("<layer number=\"33\" name=\"tFinish\" color=\"6\" fill=\"3\" visible=\"no\" active=\"yes\"/>");
  output.println("<layer number=\"34\" name=\"bFinish\" color=\"6\" fill=\"6\" visible=\"no\" active=\"yes\"/>");
  output.println("<layer number=\"35\" name=\"tGlue\" color=\"7\" fill=\"4\" visible=\"no\" active=\"yes\"/>");
  output.println("<layer number=\"36\" name=\"bGlue\" color=\"7\" fill=\"5\" visible=\"no\" active=\"yes\"/>");
  output.println("<layer number=\"37\" name=\"tTest\" color=\"7\" fill=\"1\" visible=\"no\" active=\"yes\"/>");
  output.println("<layer number=\"38\" name=\"bTest\" color=\"7\" fill=\"1\" visible=\"no\" active=\"yes\"/>");
  output.println("<layer number=\"39\" name=\"tKeepout\" color=\"4\" fill=\"11\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"40\" name=\"bKeepout\" color=\"1\" fill=\"11\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"41\" name=\"tRestrict\" color=\"4\" fill=\"10\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"42\" name=\"bRestrict\" color=\"1\" fill=\"10\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"43\" name=\"vRestrict\" color=\"2\" fill=\"10\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"44\" name=\"Drills\" color=\"7\" fill=\"1\" visible=\"no\" active=\"yes\"/>");
  output.println("<layer number=\"45\" name=\"Holes\" color=\"7\" fill=\"1\" visible=\"no\" active=\"yes\"/>");
  output.println("<layer number=\"46\" name=\"Milling\" color=\"3\" fill=\"1\" visible=\"no\" active=\"yes\"/>");
  output.println("<layer number=\"47\" name=\"Measures\" color=\"7\" fill=\"1\" visible=\"no\" active=\"yes\"/>");
  output.println("<layer number=\"48\" name=\"Document\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"49\" name=\"Reference\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"51\" name=\"tDocu\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("<layer number=\"52\" name=\"bDocu\" color=\"7\" fill=\"1\" visible=\"yes\" active=\"yes\"/>");
  output.println("</layers>");
  output.println("<board>");
  output.println("<plain>");
}

void output_brd_suffix() {
  output.println("</plain>");
  output.println("<libraries>");
  output.println("</libraries>");
  output.println("<attributes>");
  output.println("</attributes>");
  output.println("<variantdefs>");
  output.println("</variantdefs>");
  output.println("<classes>");
  output.println("<class number=\"0\" name=\"default\" width=\"0\" drill=\"0\">");
  output.println("</class>");
  output.println("</classes>");
  output.println("<designrules name=\"default\">");
  output.println("<description language=\"en\">&lt;b&gt;EAGLE Design Rules&lt;/b&gt;");
  output.println("&lt;p&gt;");
  output.println("The default Design Rules have been set to cover");
  output.println("a wide range of applications. Your particular design");
  output.println("may have different requirements, so please make the");
  output.println("necessary adjustments and save your customized");
  output.println("design rules under a new name.");
  output.println("</description>");
  output.println("<param name=\"layerSetup\" value=\"(1*16)\"/>");
  output.println("<param name=\"mtCopper\" value=\"0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm 0.035mm\"/>");
  output.println("<param name=\"mtIsolate\" value=\"1.5mm 0.15mm 0.2mm 0.15mm 0.2mm 0.15mm 0.2mm 0.15mm 0.2mm 0.15mm 0.2mm 0.15mm 0.2mm 0.15mm 0.2mm\"/>");
  output.println("<param name=\"mdWireWire\" value=\"8mil\"/>");
  output.println("<param name=\"mdWirePad\" value=\"8mil\"/>");
  output.println("<param name=\"mdWireVia\" value=\"8mil\"/>");
  output.println("<param name=\"mdPadPad\" value=\"8mil\"/>");
  output.println("<param name=\"mdPadVia\" value=\"8mil\"/>");
  output.println("<param name=\"mdViaVia\" value=\"8mil\"/>");
  output.println("<param name=\"mdSmdPad\" value=\"8mil\"/>");
  output.println("<param name=\"mdSmdVia\" value=\"8mil\"/>");
  output.println("<param name=\"mdSmdSmd\" value=\"8mil\"/>");
  output.println("<param name=\"mdViaViaSameLayer\" value=\"8mil\"/>");
  output.println("<param name=\"mnLayersViaInSmd\" value=\"2\"/>");
  output.println("<param name=\"mdCopperDimension\" value=\"40mil\"/>");
  output.println("<param name=\"mdDrill\" value=\"8mil\"/>");
  output.println("<param name=\"mdSmdStop\" value=\"0mil\"/>");
  output.println("<param name=\"msWidth\" value=\"10mil\"/>");
  output.println("<param name=\"msDrill\" value=\"0.6mm\"/>");
  output.println("<param name=\"msMicroVia\" value=\"9.99mm\"/>");
  output.println("<param name=\"msBlindViaRatio\" value=\"0.5\"/>");
  output.println("<param name=\"rvPadTop\" value=\"0.25\"/>");
  output.println("<param name=\"rvPadInner\" value=\"0.25\"/>");
  output.println("<param name=\"rvPadBottom\" value=\"0.25\"/>");
  output.println("<param name=\"rvViaOuter\" value=\"0.25\"/>");
  output.println("<param name=\"rvViaInner\" value=\"0.25\"/>");
  output.println("<param name=\"rvMicroViaOuter\" value=\"0.25\"/>");
  output.println("<param name=\"rvMicroViaInner\" value=\"0.25\"/>");
  output.println("<param name=\"rlMinPadTop\" value=\"10mil\"/>");
  output.println("<param name=\"rlMaxPadTop\" value=\"20mil\"/>");
  output.println("<param name=\"rlMinPadInner\" value=\"10mil\"/>");
  output.println("<param name=\"rlMaxPadInner\" value=\"20mil\"/>");
  output.println("<param name=\"rlMinPadBottom\" value=\"10mil\"/>");
  output.println("<param name=\"rlMaxPadBottom\" value=\"20mil\"/>");
  output.println("<param name=\"rlMinViaOuter\" value=\"8mil\"/>");
  output.println("<param name=\"rlMaxViaOuter\" value=\"20mil\"/>");
  output.println("<param name=\"rlMinViaInner\" value=\"8mil\"/>");
  output.println("<param name=\"rlMaxViaInner\" value=\"20mil\"/>");
  output.println("<param name=\"rlMinMicroViaOuter\" value=\"4mil\"/>");
  output.println("<param name=\"rlMaxMicroViaOuter\" value=\"20mil\"/>");
  output.println("<param name=\"rlMinMicroViaInner\" value=\"4mil\"/>");
  output.println("<param name=\"rlMaxMicroViaInner\" value=\"20mil\"/>");
  output.println("<param name=\"psTop\" value=\"-1\"/>");
  output.println("<param name=\"psBottom\" value=\"-1\"/>");
  output.println("<param name=\"psFirst\" value=\"-1\"/>");
  output.println("<param name=\"psElongationLong\" value=\"100\"/>");
  output.println("<param name=\"psElongationOffset\" value=\"100\"/>");
  output.println("<param name=\"mvStopFrame\" value=\"1\"/>");
  output.println("<param name=\"mvCreamFrame\" value=\"0\"/>");
  output.println("<param name=\"mlMinStopFrame\" value=\"4mil\"/>");
  output.println("<param name=\"mlMaxStopFrame\" value=\"4mil\"/>");
  output.println("<param name=\"mlMinCreamFrame\" value=\"0mil\"/>");
  output.println("<param name=\"mlMaxCreamFrame\" value=\"0mil\"/>");
  output.println("<param name=\"mlViaStopLimit\" value=\"0mil\"/>");
  output.println("<param name=\"srRoundness\" value=\"0\"/>");
  output.println("<param name=\"srMinRoundness\" value=\"0mil\"/>");
  output.println("<param name=\"srMaxRoundness\" value=\"0mil\"/>");
  output.println("<param name=\"slThermalIsolate\" value=\"10mil\"/>");
  output.println("<param name=\"slThermalsForVias\" value=\"0\"/>");
  output.println("<param name=\"dpMaxLengthDifference\" value=\"10mm\"/>");
  output.println("<param name=\"dpGapFactor\" value=\"2.5\"/>");
  output.println("<param name=\"checkGrid\" value=\"0\"/>");
  output.println("<param name=\"checkAngle\" value=\"0\"/>");
  output.println("<param name=\"checkFont\" value=\"1\"/>");
  output.println("<param name=\"checkRestrict\" value=\"1\"/>");
  output.println("<param name=\"useDiameter\" value=\"13\"/>");
  output.println("<param name=\"maxErrors\" value=\"999999\"/>");
  output.println("</designrules>");
  output.println("<autorouter>");
  output.println("<pass name=\"Default\">");
  output.println("<param name=\"RoutingGrid\" value=\"50mil\"/>");
  output.println("<param name=\"AutoGrid\" value=\"1\"/>");
  output.println("<param name=\"Efforts\" value=\"0\"/>");
  output.println("<param name=\"TopRouterVariant\" value=\"1\"/>");
  output.println("<param name=\"tpViaShape\" value=\"round\"/>");
  output.println("<param name=\"PrefDir.1\" value=\"a\"/>");
  output.println("<param name=\"PrefDir.2\" value=\"0\"/>");
  output.println("<param name=\"PrefDir.3\" value=\"0\"/>");
  output.println("<param name=\"PrefDir.4\" value=\"0\"/>");
  output.println("<param name=\"PrefDir.5\" value=\"0\"/>");
  output.println("<param name=\"PrefDir.6\" value=\"0\"/>");
  output.println("<param name=\"PrefDir.7\" value=\"0\"/>");
  output.println("<param name=\"PrefDir.8\" value=\"0\"/>");
  output.println("<param name=\"PrefDir.9\" value=\"0\"/>");
  output.println("<param name=\"PrefDir.10\" value=\"0\"/>");
  output.println("<param name=\"PrefDir.11\" value=\"0\"/>");
  output.println("<param name=\"PrefDir.12\" value=\"0\"/>");
  output.println("<param name=\"PrefDir.13\" value=\"0\"/>");
  output.println("<param name=\"PrefDir.14\" value=\"0\"/>");
  output.println("<param name=\"PrefDir.15\" value=\"0\"/>");
  output.println("<param name=\"PrefDir.16\" value=\"a\"/>");
  output.println("<param name=\"cfVia\" value=\"8\"/>");
  output.println("<param name=\"cfNonPref\" value=\"5\"/>");
  output.println("<param name=\"cfChangeDir\" value=\"2\"/>");
  output.println("<param name=\"cfOrthStep\" value=\"2\"/>");
  output.println("<param name=\"cfDiagStep\" value=\"3\"/>");
  output.println("<param name=\"cfExtdStep\" value=\"0\"/>");
  output.println("<param name=\"cfBonusStep\" value=\"1\"/>");
  output.println("<param name=\"cfMalusStep\" value=\"1\"/>");
  output.println("<param name=\"cfPadImpact\" value=\"4\"/>");
  output.println("<param name=\"cfSmdImpact\" value=\"4\"/>");
  output.println("<param name=\"cfBusImpact\" value=\"0\"/>");
  output.println("<param name=\"cfHugging\" value=\"3\"/>");
  output.println("<param name=\"cfAvoid\" value=\"4\"/>");
  output.println("<param name=\"cfPolygon\" value=\"10\"/>");
  output.println("<param name=\"cfBase.1\" value=\"0\"/>");
  output.println("<param name=\"cfBase.2\" value=\"1\"/>");
  output.println("<param name=\"cfBase.3\" value=\"1\"/>");
  output.println("<param name=\"cfBase.4\" value=\"1\"/>");
  output.println("<param name=\"cfBase.5\" value=\"1\"/>");
  output.println("<param name=\"cfBase.6\" value=\"1\"/>");
  output.println("<param name=\"cfBase.7\" value=\"1\"/>");
  output.println("<param name=\"cfBase.8\" value=\"1\"/>");
  output.println("<param name=\"cfBase.9\" value=\"1\"/>");
  output.println("<param name=\"cfBase.10\" value=\"1\"/>");
  output.println("<param name=\"cfBase.11\" value=\"1\"/>");
  output.println("<param name=\"cfBase.12\" value=\"1\"/>");
  output.println("<param name=\"cfBase.13\" value=\"1\"/>");
  output.println("<param name=\"cfBase.14\" value=\"1\"/>");
  output.println("<param name=\"cfBase.15\" value=\"1\"/>");
  output.println("<param name=\"cfBase.16\" value=\"0\"/>");
  output.println("<param name=\"mnVias\" value=\"20\"/>");
  output.println("<param name=\"mnSegments\" value=\"9999\"/>");
  output.println("<param name=\"mnExtdSteps\" value=\"9999\"/>");
  output.println("<param name=\"mnRipupLevel\" value=\"10\"/>");
  output.println("<param name=\"mnRipupSteps\" value=\"100\"/>");
  output.println("<param name=\"mnRipupTotal\" value=\"100\"/>");
  output.println("</pass>");
  output.println("<pass name=\"Follow-me\" refer=\"Default\" active=\"yes\">");
  output.println("</pass>");
  output.println("<pass name=\"Busses\" refer=\"Default\" active=\"yes\">");
  output.println("<param name=\"cfNonPref\" value=\"4\"/>");
  output.println("<param name=\"cfBusImpact\" value=\"4\"/>");
  output.println("<param name=\"cfHugging\" value=\"0\"/>");
  output.println("<param name=\"mnVias\" value=\"0\"/>");
  output.println("</pass>");
  output.println("<pass name=\"Route\" refer=\"Default\" active=\"yes\">");
  output.println("</pass>");
  output.println("<pass name=\"Optimize1\" refer=\"Default\" active=\"yes\">");
  output.println("<param name=\"cfVia\" value=\"99\"/>");
  output.println("<param name=\"cfExtdStep\" value=\"10\"/>");
  output.println("<param name=\"cfHugging\" value=\"1\"/>");
  output.println("<param name=\"mnExtdSteps\" value=\"1\"/>");
  output.println("<param name=\"mnRipupLevel\" value=\"0\"/>");
  output.println("</pass>");
  output.println("<pass name=\"Optimize2\" refer=\"Optimize1\" active=\"yes\">");
  output.println("<param name=\"cfNonPref\" value=\"0\"/>");
  output.println("<param name=\"cfChangeDir\" value=\"6\"/>");
  output.println("<param name=\"cfExtdStep\" value=\"0\"/>");
  output.println("<param name=\"cfBonusStep\" value=\"2\"/>");
  output.println("<param name=\"cfMalusStep\" value=\"2\"/>");
  output.println("<param name=\"cfPadImpact\" value=\"2\"/>");
  output.println("<param name=\"cfSmdImpact\" value=\"2\"/>");
  output.println("<param name=\"cfHugging\" value=\"0\"/>");
  output.println("</pass>");
  output.println("<pass name=\"Optimize3\" refer=\"Optimize2\" active=\"yes\">");
  output.println("<param name=\"cfChangeDir\" value=\"8\"/>");
  output.println("<param name=\"cfPadImpact\" value=\"0\"/>");
  output.println("<param name=\"cfSmdImpact\" value=\"0\"/>");
  output.println("</pass>");
  output.println("<pass name=\"Optimize4\" refer=\"Optimize3\" active=\"yes\">");
  output.println("<param name=\"cfChangeDir\" value=\"25\"/>");
  output.println("</pass>");
  output.println("</autorouter>");
  output.println("<elements>");
  output.println("</elements>");
  output.println("<signals>");
  output.println("</signals>");
  output.println("</board>");
  output.println("</drawing>");
  output.println("</eagle>");
}

void brd_close() {
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
}


void output_brd() {
  setup_brd_file();
  output_brd_prefix();
  for (int i=0; i<brd_layer_string.length; i++) {
    output.println(brd_layer_string[i]);
  }
  output_brd_suffix();
  brd_close();
}

String output_rect_at(int _layer, float _xpos, float _ypos, float _width, float _height) {
  String output;
  output = ("<rectangle x1=\""+_xpos+"\" y1=\""+_ypos+"\" x2=\""+(_xpos+_width)+"\" y2=\""+(_ypos+_height)+"\" layer=\""+_layer+"\"/>"+"\n");
  //debug_log_output(output);
  return output;
}