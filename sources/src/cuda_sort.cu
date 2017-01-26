#include "cuda_sort.cuh"
#include <iostream>
#include <vector>
#include <time.h>
#include <algorithm>

// defines
#define THREADS 512 // 2^9
#define BLOCKS 131072 // 2^15
#define NUM_VALS THREADS*BLOCKS

void print_elapsed(clock_t start, clock_t stop)
{
	double elapsed = ((double)(stop - start)) / CLOCKS_PER_SEC;
	printf("Elapsed time: %.3fs\n", elapsed);
}

int random_int()
{
	return (int)rand();
}

void array_fill(int *arr, int length)
{
	int i;
	for (i = 0; i < length; ++i) {
		arr[i] = random_int();
	}
}

int cuda_sort::test_output()
{

	clock_t start, stop;

	

	int * values = (int*)malloc(NUM_VALS * sizeof(int));
	array_fill(values, NUM_VALS);

	// sort this with std lib
	std::vector<int> value_vec(values, values + NUM_VALS);
	std::vector<int> value_vec2(values, values + NUM_VALS);
	
	start = clock();
	bitonic_sort(values);
	stop = clock();

	std::cout << "Number of elements: " << value_vec2.size() << std::endl;
	print_elapsed(start, stop);

	start = clock();
	std::sort(value_vec2.begin(), value_vec2.end());
	stop = clock();


	std::cout << "same array with std::sort: " << std::endl;
	print_elapsed(start, stop);
	/*	
	for each (int var in value_vec2)
	{
		std::cout << var << std::endl;
	}
	*/
	


	return 42;
}

__global__
void bitonic_sort_step(int * dev_values, int j, int k)
{
	// sorting params
	unsigned int i, ixj;
	i = threadIdx.x + blockDim.x * blockIdx.x;
	ixj = i^j;
	
	// threads with the lowest ids sort the array
	if ((ixj) > i) {
		if ((i&k) == 0) {
			// sort ascending
			if (dev_values[i] > dev_values[ixj]) {
				// swap i with ixj
				int temp = dev_values[i];
				dev_values[i] = dev_values[ixj];
				dev_values[ixj] = temp;
			}
		}
		if ((i&k) != 0) {
			// sort descending
			if (dev_values[i] < dev_values[ixj]) {
				// swap ixj with i
				int temp = dev_values[i];
				dev_values[i] = dev_values[ixj];
				dev_values[ixj] = temp;
			}
		}
	}
}

void cuda_sort::bitonic_sort(int * values)
{
	int *dev_values;
	size_t size = NUM_VALS * sizeof(int);

	cudaMalloc((void**)&dev_values, size);
	cudaMemcpy(dev_values, values, size, cudaMemcpyHostToDevice);

	dim3 blocks(BLOCKS, 1); // num blocks
	dim3 threads(THREADS, 1); // num threads

	int j, k;

	// Major step
	for (k = 2; k <= NUM_VALS; k <<= 1) {
		// Minor step
		for (j = k >> 1; j > 0; j = j >> 1) {
			bitonic_sort_step <<<blocks, threads>>>(dev_values, j, k);
		}
	}
	cudaMemcpy(values, dev_values, size, cudaMemcpyDeviceToHost);
	cudaFree(dev_values);
}
