# -I${CUDA_HOME}/samples/common/inc
simulat:
	nvcc -o simulat src/simulat.c

clean:
	rm -f simulat
