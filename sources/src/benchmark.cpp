#include "benchmark.h"
#include "cuda_sort.cuh"
/*
*
*	For the Benchmarks first iteration we will start with 250000 -> 500000 -> 1000000 items
*
*/

//#define NUM_VALS 1048576
#define NUM_VALS 256

benchmark::benchmark()
{
	// std sort
	benchvec.push_back(std::move(std::unique_ptr<Standardsort>(new Standardsort)));
	// std boost sort
	benchvec.push_back(std::move(std::unique_ptr<Stdboostsort>(new Stdboostsort)));
	// bitonic bitsort using cuda
	benchvec.push_back(std::move(std::unique_ptr<cuda_sort>(new cuda_sort)));
	// radix sort using opencl
	benchvec.push_back(std::move(std::unique_ptr<Boostsort>(new Boostsort)));
	// radix using CUDA
	benchvec.push_back(std::move(std::unique_ptr<cuda_radix_sort>(new cuda_radix_sort)));
	
	std::vector<int> NUM_VAL = { 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, 33554432, 67108864};
	for (int val : NUM_VAL) {
		for (auto it(benchvec.begin()), ite(benchvec.end()); it != ite; ++it) {
			int * values = (int*)malloc(val * sizeof(int));
			array_fill(values, val);
			int * testvalues = values;
			//	std::cout << "testout: " << testvalues[19] << " " << testvalues[20] << " " << testvalues[21] << " " << testvalues[22] << std::endl;
			std::cout << val << std::endl << (*it)->name << std::endl;
			(*it)->measure(testvalues, val);
			//	std::cout << "testout: " << testvalues[19] << " " << testvalues[20] << " " << testvalues[21] << " " << testvalues[22] << std::endl;
		}
	}
	//for (auto it(benchvec.begin()), ite(benchvec.end()); it != ite; ++it) {
	//	int * values = (int*)malloc(NUM_VALS * sizeof(int));
	//	array_fill(values, NUM_VALS);
	//	int * testvalues = values;
	////	std::cout << "testout: " << testvalues[19] << " " << testvalues[20] << " " << testvalues[21] << " " << testvalues[22] << std::endl;
	//	std::cout << (*it)->name << " "; 
	//	(*it)->measure(testvalues, NUM_VALS);		
	////	std::cout << "testout: " << testvalues[19] << " " << testvalues[20] << " " << testvalues[21] << " " << testvalues[22] << std::endl;
	//}

}

void benchmark::array_fill(int * arr, int length)
{
	int i;
	for (i = 0; i < length; ++i) {
		arr[i] = (int)rand();
	}	
}
