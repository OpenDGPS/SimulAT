#include <stdio.h>

#define NUMOFRASTERRECORDSPERCORE 3 // 160  // defined by num of raster records ~80k divided by num of GPU cores ~512
#define SIZEOFRASTERRECORD 4 // DWORDS to jump between the records

#define NUMOFADDRESSRECORDSPERCORE 4 // 5000 // defined by num of address records ~2.5m divided by num of GPU cores ~512
#define NUMOFADDRESSBLOCKS 3 // 512 // equal to the number of GPU cores
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

			printf("\t\t\trecordNum:\t%d\tcurrentRasterAddress:\t%d\n",recordNum,currentRasterAddress);

			for ( addressNum = 0; addressNum < NUMOFADDRESSRECORDSPERCORE; addressNum++ ) {

				currentAddressAddress = addressBase + ( addressNum * SIZEOFADDRESSRECORD );
				
				printf("\t\t\t\taddressNum = %d \tcurrentAddressAddress = %d\n", addressNum, currentAddressAddress);
			
			}
	    }
	}
}
