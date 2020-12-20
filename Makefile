# -I${CUDA_HOME}/samples/common/inc
simulat:
	time nvcc -o simulat -I${CUDA_HOME}/samples/common/inc src/simulat.cu 

clean:
	rm -f simulat

all: clean simulat 
	./simulat
