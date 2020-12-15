# -I${CUDA_HOME}/samples/common/inc
simulat:
	nvcc -o simulat src/simulat.cu src/cuda/simulat-kernel.cu

clean:
	rm -f simulat
