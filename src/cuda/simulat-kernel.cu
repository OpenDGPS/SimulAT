#define NUMOFRASTERRECORDSPERCORE 160  // defined by num of raster records ~80k divided by num of GPU cores ~512
#define SIZEOFRASTERRECORD 4 // DWORDS to jump between the records

#define NUMOFADDRESSRECORDSPERCORE 5000 // defined by num of address records ~2.5m divided by num of GPU cores ~512
#define NUMOFADDRESSBLOCKS 512 // equal to the number of GPU cores
#define SIZEOFADDRESSRECORD 5 // DWORDS to jump between the records

__global__ void mapRasterToAddresses(int rasterRecords, int addressRecords) {

	int threadId, recordNum, addressBlockNum, currentAddressBlockNum, addressNumInBlock, rasterBase, addressBase, addressNum, currentRaster, currentAddress;
	
	for ( addressBlockNum = 0; addressBlockNum < NUMOFADDRESSBLOCKS; addressBlockNum++ ) {
	
		currentAddressBlockNum = ( addressBlockNum + threadId ) % NUMOFADDRESSBLOCKS;
	    
	    addressBase = addressRecords + ( currentAddressBlockNum * NUMOFADDRESSRECORDSPERCORE * SIZEOFADDRESSRECORD );

	    for ( recordNum = 0; recordNum < NUMOFRASTERRECORDSPERCORE; recordNum++ ) {

	    	currentRaster = rasterRecords + ( recordNum * SIZEOFRASTERRECORD ) + ( threadId * SIZEOFRASTERRECORD );

			for ( addressNum = 0; addressNum < NUMOFADDRESSRECORDSPERCORE; addressNum++ ) {

			    currentAddress = addressBase + ( addressNum * SIZEOFADDRESSRECORD );
			
			}
	    }
	}
}
