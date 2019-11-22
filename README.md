# SPACAL Simulation code
## Instruction of using Docker
the docker images will download all the necessary libraries, dependencies and will self compile.
* Check if docker is running
```
systemctl enable docker
systemctl start docker
```
* Build the Docker image
```
docker build --rm -t spacal
```
* Run the Docker image
```
docker run -it spacal:latest
```



## Instructions for installation on a personal PC

To donwnload and compile the package (assuming you have a local working release of Geant4, Root and CLHEP installed), execute the following commands:

git clone https://github.com/eshmanin/SPACAL.git
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

The file template.cfg contains a number of parameters to configure the calorimeter layout. Most of them should be self-explanatory. You can choose one of three prototypes and change it's configuration.

In a output *.root files branches with deposited energy in fibers called:
                                                                    depositedEnergyFibresCross
                                                                    depositedEnergyFibresCenter
                                                                    depositedEnergyFibresCorners
For new prototypes this branches containt:
                                            depositedEnergyFibresCross = Energy in Bottom side      (Yellow in visualization)
                                            depositedEnergyFibresCenter = Energy in Up side         (Red one)
                                            depositedEnergyFibresCorners = Energy in Accessory side (Green one)




