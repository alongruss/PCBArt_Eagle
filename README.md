# PCBArt_Eagle
Version 0.2.2
Last edited: 17/11/16.
Created by: Alon Gruss.

Converts an image into a 2-layerd PCB Eagle .brd file
 The app works in following manner:
 image > brightness layers > [BITWISE COMPOSE BRD LAYERS] > quadtree > export to xml polygons
 (while constantly giving back visual feedback)

Working features:
* formated and refactored code.
* 6 layers hardcoded.
* loads image files.
* check for image file validity in format, filesize, number of pixels.
* copy to layers.
* runs a threshold filter on each layer.
* creates a quadtree for each layer.
* quadtree function is thread based.
* realtime GUI sliders using the G4P library.
* preview of layers and expected result.
* exports an Eagle .brd file (xml).

* progress bar.

TODO:
* import existing .brd file.
* option for SVG vector files using the Geomartive library.
* logs functions to log file.
* exports image files of the layers and the final preview.
