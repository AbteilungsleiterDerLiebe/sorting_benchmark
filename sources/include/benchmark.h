#include<iostream>
#include <cuda_sort.cuh>
#include <vector>

class benchmark {
	
	public:
		benchmark();
		
	private:
		cuda_sort cuda;
};