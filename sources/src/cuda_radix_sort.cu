/*
http://stackoverflow.com/questions/26206544/parallel-radix-sort-how-would-this-implementation-actually-work-are-there-some
*/

#include "cuda_radix_sort.cuh"
#include <algorithm>
#include <stdio.h>
#include <stdlib.h>

cuda_radix_sort::cuda_radix_sort()
{
}

void cuda_radix_sort::run(int * unsortedInts, int length)
{
	cudaSetDevice(0);
	int* v;
	cudaMalloc(&v, length * sizeof(int));
	cudaMemcpy(v, unsortedInts, length * sizeof(int), cudaMemcpyHostToDevice);

	try {
		thrust::sort(thrust::device_ptr<int>(v), thrust::device_ptr<int>(v + length));
	}
	catch (thrust::system_error &e) {
		printf("Error: %s \n", e.what());
	}

	//// generate 32M random numbers serially

	//thrust::host_vector<int> h_vec(unsortedInts, unsortedInts + length);

	//// transfer data to the device

	//thrust::device_vector<int> d_vec = h_vec;

	//// sort data on the device (Only HOST VECTOR compiles!)

	//thrust::sort(d_vec.begin(), d_vec.end());

	//// transfer data back to host

	//thrust::copy(d_vec.begin(), d_vec.end(), h_vec.begin());
}



void cuda_radix_sort::radix_sort(int * values)
{

}