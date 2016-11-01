# PCBArt_Eagle
Version 0.1.
Last edited: 1/11/16.
Created by: Alon Gruss.

Converts an image into a 2-layerd PCB Eagle .brd file
(brigthness values -> layer combinations).

Working features:
* loads image files.
* copy to layers.
* runs a threshold filter on each layer.
* creates a quadtree for each layer.
* realtime GUI sliders using the G4P library.
* preview of layers and expected result.
* exports an Eagle .brd file (xml).
* exports image files of the layers and the final preview.
* logs functions to log file.

TODO:
* format and refactor code (unreadable atm).
* check for image file validity in format, filesize, number of pixels.
* commit to the main 6 layers by having a hardcoded DEFAULT state.
* progress bar?
* import existing .brd file.
* option for SVG vector files using the Geomartive library.
* consolidate log file writing method with .brd export method.?
