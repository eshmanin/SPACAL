// Martin Goettlich @ DESY
//

#ifndef SteppingAction_H
#define SteppingAction_H 1

#include "G4UserSteppingAction.hh"
#include "G4SteppingManager.hh"
#include "G4SDManager.hh"
#include "G4EventManager.hh"
#include "EventAction.hh"
#include "G4ProcessManager.hh"
#include "G4Track.hh"
#include "G4Step.hh"
#include "G4Event.hh"
#include "G4StepPoint.hh"
#include "G4TrackStatus.hh"
#include "G4VPhysicalVolume.hh"
#include "G4ParticleDefinition.hh"
#include "G4ParticleTypes.hh"
#include "G4OpBoundaryProcess.hh"
#include "G4UnitsTable.hh"
#include "ConfigFile.hh"

#include "CreateTree.hh"
#include "DetectorConstruction.hh"
#include "TrackInformation.hh"
#include "MyMaterials.hh"
#include "LedFiberTiming.hh"

#include <iostream>
#include <vector>

#include "TFile.h"
#include "TTree.h"
#include "TString.h"
#include "TRandom3.h"
 #include "DetectorConstruction.hh"



class SteppingAction : public G4UserSteppingAction
{
public:

  SteppingAction  (const string& configFileName) ;

  SteppingAction(DetectorConstruction* detectorConstruction,
                 const G4int& scint, const G4int& cher, const G4int& protoType, const G4int& write_all_energy_points, const G4int& write_fibres_energy_points, const G4int& write_energy_in_cells );


  ~SteppingAction();
  virtual void UserSteppingAction(const G4Step*);


private:
  DetectorConstruction* fDetectorConstruction;

  G4int propagateScintillation;
  G4int propagateCerenkov;
 G4double absorber_x ;     //size of rectangle containing fibres inside module
  G4double absorber_y ;
  G4double fibre_length;
  G4double module_xy;
  G4double module_yx;
  G4double cellsize;
  G4int protoType;
    G4double devider;
    G4int write_all_energy_points;
    G4int write_fibres_energy_points;
    G4int write_energy_in_cells;
};

#endif
