/*
http://stackoverflow.com/questions/26206544/parallel-radix-sort-how-would-this-implementation-actually-work-are-there-some
*/
#include "cuda_radix_sort.cuh"
#include <thrust/device_vector.h>
#include <thrust/sort.h>
#include <thrust/copy.h>
#include <thrust/detail/type_traits.h>
#include <cstdlib>


cuda_radix_sort::cuda_radix_sort()
{
	name = "cuda radix sort";
}

void cuda_radix_sort::run(int * unsortedInts, int length)
{
	thrust::device_vector<int> d_data(unsortedInts, unsortedInts + length);

	thrust::sort(d_data.begin(), d_data.end());

	thrust::copy(d_data.begin(), d_data.end(), unsortedInts);
}

void cuda_radix_sort::radix_sort(int * values)
{

}


extern "C" __declspec(dllexport) void __cdecl GPURadixSort(int*, unsigned int);

extern void GPURadixSort(int* data, unsigned int numElements)
{
	thrust::device_vector<int> d_data(data, data + numElements);

	thrust::sort(d_data.begin(), d_data.end());

	thrust::copy(d_data.begin(), d_data.end(), data);
}



