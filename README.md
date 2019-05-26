# SPACAL



Instructions for installation on a personal PC

To donwnload and compile the package (assuming you have a local working release of Geant4 and CLHEP installed), execute the following commands:

git clone https://github.com/eshmanin/spacal.git
cd SPACAL/build
cmake ../
make -j
cd -

Instructions to run the code

To run the code in interactive mode (i.e. with visualization), simply execute

./build/FibresCalo template.cfg
This mode reads the visualization and beam parameters from file vis.mac

To produce multiple events and save the output in a root file, execute

./build/FibresCalo template.cfg outFileName
In this case, the beam parameters are read from file gps.mac

The file template.cfg contains a number of parameters to configure the calorimeter layout. Most of them should be self-explanatory.
