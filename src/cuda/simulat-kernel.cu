#include <stdio.h>

#define NUMOFRASTERRECORDSPERCORE 3 // 160  // defined by num of raster records ~80k divided by num of GPU cores ~512

// rasters are stored in  int(4Byte): rasterDd, int(4Byte): minLat, int(4Byte): minLon, int(4Byte): maxLat, int(4Byte): maxLon, int(4Byte): [empty]
#define SIZEOFRASTERRECORD 5 // DWORDS to jump between the records

#define NUMOFADDRESSRECORDSPERBLOCK 4 // 5000 // defined by num of address records ~2.5m divided by num of GPU cores ~512
#define NUMOFADDRESSBLOCKS 3 // 512 // equal to the number of GPU cores

// addresses are stored in int(4Byte): id, int(4Byte): lat, int(4Byte): lon, int(4Byte): [rasterId]
#define SIZEOFADDRESSRECORD 4 // DWORDS to jump between the records

int globalThreadId = 0;

// __global__ 

void mapRasterToAddresses(int rasterBase, int addressRecords) {

	int threadId, recordNum, addressBlockNum, currentAddressBlockNum, addressBase, addressNum, currentRasterAddress, currentAddressAddress;
	
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

				printf("if currentRasterAddress:[%d][1] < currentAddressAddress:[%d][1]\n", currentRasterAddress, currentAddressAddress);
			
			}
	    }
	}
}
