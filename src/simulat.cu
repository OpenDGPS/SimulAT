#include <stdio.h>

// CUDA runtime
#include <cuda_runtime.h>

// helper functions and utilities to work with CUDA
#include <helper_functions.h>
#include <helper_cuda.h>

// #include "cuda/simulat-kernel.cu"


int main ( void ) {
  mapRasterToAddresses(0,0);
  /*
    1. Initializing memory for raster records
    2. Read the CSV to host memory 
    3. Read the address records to host memory
    4. Map the addresses to a buffer host memory
    5. Shuffle raster and address buffer by a prime number
       each to the final host memory spaces
    6. copy host memory to device memory
  */

  return 0;
}