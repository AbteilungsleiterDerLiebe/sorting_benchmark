#include<iostream>
#include <cuda_sort.cuh>
#include <standardsort.h>
#include <boostsort.h>
#include <stdboostsort.h>
#include <cuda_radix_sort.cuh>
#include <vector>
#include <memory>

class benchmark {
	
	public:
		benchmark();
		
	private:
		void array_fill(int * arr, int length);
		std::vector<std::unique_ptr<I_benchmark_prototype>> benchvec;
};