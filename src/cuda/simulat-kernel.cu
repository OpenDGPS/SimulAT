
#define NUM_OF_PERSONS_FIELD_IN_RASTER 4

int genderLUT = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1];
int ageMinLUT = [0,3,6,9,13,18,24,34,44,54,69,79,0,3,6,9,13,18,24,34,44,54,69,79];
int ageMaxLut = [2,5,8,12,17,23,33,43,53,68,78,2,5,8,12,17,23,33,43,53,68,78];

__device__ void createPersonsFromRaster(int *rasterRecord) {
	   int numOfPersons, numOfHouseholds, pickAdult, i, j, k;
	   numOfPersons = rasterRecord[NUM_OF_PERSONS_FIELD_IN_RASTER];
	   int listOfFieldsWithAvailableAdults = [0,1,2,3,4,5,6,7,8,9,10]; // needs to be initialized
	   int listOfFieldsWithAvailableHH = [0,1,2,3,4];
	   for ( i = 0; i < numOfPersons; i++ ) {
	       pickAdult = random(0 to length(listOfFieldsWithAvailableAdults));
	       personId = i;
	       gender = genderLUT[listOfFieldsWithAvailableAdults[pickAdult]];
	       ageMin = ageMinLUT[listOfFieldsWithAvailableAdults[pickAdult]];
	       ageMax = ageMaxLUT[listOfFieldsWithAvailableAdults[pickAdult]];
	       age = random(ageMin,ageMax);
	       
	       rasterRecord[NUM_OF_PERSONS_FIELD_IN_RASTER + listOfFieldsWithAvailableAdults[pickAdult]]--;
	       if ( rasterRecord[NUM_OF_PERSONS_FIELD_IN_RASTER + listOfFieldsWithAvailableAdults[pickAdult]] == 0 ) {
	       	  remove pickAdult from listOfFieldsWithAvailableAdults;
		}
		if ( availableInHH == 0 ) {
		   pickHH = random(0 to length(listOfFieldsWithAvailableHH));
		   rasterRecord[HHID_START_AT + pickHH]--;
		   if ( listOfFieldsWithAvailableHH[piHH] == 3 ) // 3 to 5 persons
		      switch ( random (0 to 100) < 50 )
		      	     case < 50:
			     	  hhSize = 3;
			     case < 85:
			     	  hhSize = 4;
			     default:
				hhSize = 5;
		   if ( listOfFieldsWithAvailableHH[piHH] == 4 ) // 6+ persons {
                      switch ( random (0 to 100) < 50 )
		             case < 30:
                                  hhSize = 6;
			     case < 55:
                                  hhSize = 7;
                             case < 65:
                                  hhSize = 8;
                             case < 75:
                                  hhSize = 9;
                             case < 85:
                                  hhSize = 10;
                             case < 92:
                                  hhSize = 11;
                             case < 95:
                                  hhSize = 12;
                             case < 98:
                                  hhSize = 13;
                             default:
                             	hhSize = random (13 to 25);
			}		   
		}
		  	  
		  
		  
	   }
}

