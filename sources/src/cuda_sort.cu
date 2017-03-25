#include "cuda_sort.cuh"
#include <algorithm>

cuda_sort::cuda_sort()
{
	name = "cuda Bitonic sort";
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


void cuda_sort::run(int * unsortedInts, int length)
{
	THREADS = 512;
	NUM_VALS = length;
	BLOCKS = NUM_VALS / THREADS;

	int *dev_values;
	size_t size = NUM_VALS * sizeof(int);

	cudaMalloc((void**)&dev_values, size);
	cudaMemcpy(dev_values, unsortedInts, size, cudaMemcpyHostToDevice);

	dim3 blocks(BLOCKS, 1); // num blocks
	dim3 threads(THREADS, 1); // num threads

	int j, k;

	// Major step
	for (k = 2; k <= NUM_VALS; k <<= 1) {
		// Minor step
		for (j = k >> 1; j > 0; j = j >> 1) {
			bitonic_sort_step <<<blocks, threads >>>(dev_values, j, k);
		}
	}
	int * res;
	cudaMemcpy(unsortedInts, dev_values, size, cudaMemcpyDeviceToHost);
	cudaFree(dev_values);
}


void cuda_sort::bitonic_sort(int * values)
{
	std::vector<int> test(values, values + NUM_VALS);
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