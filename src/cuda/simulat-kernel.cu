#include <stdio.h>

#define NUMOFRASTERRECORDSPERCORE 3 // 160  // defined by num of raster records ~80k divided by num of GPU cores ~512

// rasters are stored in  int(4Byte): rasterDd, int(4Byte): minLat, int(4Byte): minLon, int(4Byte): maxLat, int(4Byte): maxLon, int(4Byte): [empty]
#define SIZEOFRASTERRECORD 5 // DWORDS to jump between the records

#define NUMOFADDRESSRECORDSPERBLOCK 4 // 5000 // defined by num of address records ~2.5m divided by num of GPU cores ~512
#define NUMOFADDRESSBLOCKS 3 // 512 // equal to the number of GPU cores

// addresses are stored in int(4Byte): id, int(4Byte): lat, int(4Byte): lon, int(4Byte): [rasterId]
#define SIZEOFADDRESSRECORD 4 // DWORDS to jump between the records

#define ADDLAT 1
#define ADDLON 2
#define MINLAT 1
#define MINLON 2
#define MAXLAT 3
#define MAXLON 4

int globalThreadId = 0;

__global__ void saxpy(int n, float a, float *x, float *y) {

	int i = blockIdx.x*blockDim.x + threadIdx.x;

	if (i < n) y[i] = a*x[i] + y[i];
}
// __global__ 

void mapRasterToAddresses(int rasterBase, int addressRecords) {

	int threadId, recordNum, addressBlockNum, currentAddressBlockNum, addressBase, addressNum, currentRasterAddress, currentAddressAddress;
	
	// int rMinLat, rMaxLat, rMinLon, rMaxLon, aLat, aLon;

	threadId = globalThreadId;

	for ( addressBlockNum = 0; addressBlockNum < NUMOFADDRESSBLOCKS; addressBlockNum++ ) {
	
		currentAddressBlockNum = ( addressBlockNum + threadId ) % NUMOFADDRESSBLOCKS;
	    
	    addressBase = addressRecords + ( currentAddressBlockNum * NUMOFADDRESSRECORDSPERBLOCK * SIZEOFADDRESSRECORD );

		for ( recordNum = 0; recordNum < NUMOFRASTERRECORDSPERCORE; recordNum++ ) {

			currentRasterAddress = rasterBase + ( recordNum * SIZEOFRASTERRECORD ) + ( threadId * SIZEOFRASTERRECORD );

			for ( addressNum = 0; addressNum < NUMOFADDRESSRECORDSPERBLOCK; addressNum++ ) {

				currentAddressAddress = addressBase + ( addressNum * SIZEOFADDRESSRECORD );
				
				printf("threadId:\t%d\n",threadId);

				printf("\taddressBlockNum:\t%d\tcurrentAddressBlockNum:\t%d\taddressBase:\t%d\n",addressBlockNum,currentAddressBlockNum,addressBase);

				printf("\t\trecordNum:\t%d\tcurrentRasterAddress:\t%d\n",recordNum,currentRasterAddress);

				printf("\t\t\taddressNum = %d \tcurrentAddressAddress = %d\n", addressNum, currentAddressAddress);

				/*
				rMinLat = currentRasterAddress[currentRasterAddress][MINLAT];
				rMaxLat = currentRasterAddress[currentRasterAddress][MAXLAT];
				rMinLon = currentRasterAddress[currentRasterAddress][MINLON];
				rMaxLon = currentRasterAddress[currentRasterAddress][MAXLON];
				aLat = currentAddressAddress[currentAddressAddress][ADDLAT];
				aLon = currentAddressAddress[currentAddressAddress][ADDLON];
				printf("rMinLat > aLat\n");
				printf("rMaxLat < aLat\n");
				printf("rMinLon > aLon\n");
				printf("rMaxLon > aLon\n");
				*/
			
			}
	    }
	}
}
