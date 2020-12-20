# -I${CUDA_HOME}/samples/common/inc
simulat:
	nvcc -o simulat -I${CUDA_HOME}/samples/common/inc src/simulat.cu 

clean:
	rm -f simulat

run:
	./simulat
	
all: clean simulat 
	./simulat
