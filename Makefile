# -I${CUDA_HOME}/samples/common/inc
simulat:
	nvcc -o simulat src/simulat.c src/cuda/simulat-kernel.cu

clean:
	rm -f simulat
