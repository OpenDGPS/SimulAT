#include <stdio.h>

// CUDA runtime
#include <cuda_runtime.h>

// helper functions and utilities to work with CUDA
#include <helper_functions.h>
#include <helper_cuda.h>

#include "cuda/simulat-kernel.cu"

// Latitude Differenz = 0,002246  
// Longitude Differenz = 0,003255
int main ( void ) {
  for (globalThreadId = 0; globalThreadId < 3; globalThreadId++ ) {
    // mapRasterToAddresses(2000,4000);
  }
  int N = 1<<27;
  float *x, *y, *d_x, *d_y;
  x = (float*)malloc(N*sizeof(float));
  y = (float*)malloc(N*sizeof(float));
  printf("%lu\n",sizeof(N));

  cudaMalloc(&d_x, N*sizeof(float)); 
  cudaMalloc(&d_y, N*sizeof(float));

  for (int i = 0; i < N; i++) {
    x[i] = 1.0f;
    y[i] = 2.0f;
  }

  cudaMemcpy(d_x, x, N*sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(d_y, y, N*sizeof(float), cudaMemcpyHostToDevice);

  // Perform SAXPY on 1M elements
  saxpy<<<(N+255)/256, 256>>>(N, 2.0f, d_x, d_y);

  cudaMemcpy(y, d_y, N*sizeof(float), cudaMemcpyDeviceToHost);

  float maxError = 0.0f;
  for (int i = 0; i < N; i++)
    maxError = max(maxError, abs(y[i]-4.0f));
  printf("Max error: %f\n", maxError);

  cudaFree(d_x);
  cudaFree(d_y);
  free(x);
  free(y);
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