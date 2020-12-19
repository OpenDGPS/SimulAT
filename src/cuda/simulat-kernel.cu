#include <stdio.h>

#define NUMOFRASTERRECORDSPERCORE 16 // 160  // defined by num of raster records ~80k divided by num of GPU cores ~512
#define SIZEOFRASTERRECORD 4 // DWORDS to jump between the records

#define NUMOFADDRESSRECORDSPERCORE 5 // 5000 // defined by num of address records ~2.5m divided by num of GPU cores ~512
#define NUMOFADDRESSBLOCKS 12 // 512 // equal to the number of GPU cores
#define SIZEOFADDRESSRECORD 5 // DWORDS to jump between the records

int globalThreadId = 0;

// __global__ 

void mapRasterToAddresses(int rasterRecords, int addressRecords) {

	int threadId, recordNum, addressBlockNum, currentAddressBlockNum, addressNumInBlock, rasterBase, addressBase, addressNum, currentRasterAddress, currentAddressAddress;
	
	threadId = globalThreadId;

	printf("threadId:\t%d\n",threadId);

	for ( addressBlockNum = 0; addressBlockNum < NUMOFADDRESSBLOCKS; addressBlockNum++ ) {
	
		currentAddressBlockNum = ( addressBlockNum + threadId ) % NUMOFADDRESSBLOCKS;
	    
	    addressBase = addressRecords + ( currentAddressBlockNum * NUMOFADDRESSRECORDSPERCORE * SIZEOFADDRESSRECORD );

		printf("\taddressBlockNum:\t%d\tcurrentAddressBlockNum:\t%d\taddressBase:\t%d\n",addressBlockNum,currentAddressBlockNum,addressBase);

		for ( recordNum = 0; recordNum < NUMOFRASTERRECORDSPERCORE; recordNum++ ) {

			currentRasterAddress = rasterRecords + ( recordNum * SIZEOFRASTERRECORD ) + ( threadId * SIZEOFRASTERRECORD );

			printf("\t\t\trecordNum:\t%d\n",recordNum);

			for ( addressNum = 0; addressNum < NUMOFADDRESSRECORDSPERCORE; addressNum++ ) {

				currentAddressAddress = addressBase + ( addressNum * SIZEOFADDRESSRECORD );
				
				printf("threadId = %d \taddressBase = %d \tcurrentRaster = %d \tcurrentAddress = %d\n",threadId, addressBase, currentRasterAddress,currentAddressAddress);
			
			}
	    }
	}
}
