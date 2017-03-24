#pragma once
#include <stdio.h>
#include "I_benchmark_prototye.h"
#include "cuda_runtime.h"
#include "cuda.h"
#include "device_launch_parameters.h"

class cuda_sort : public I_benchmark_prototype {
	
	public:
		cuda_sort();
		virtual void run(int * unsortedInts, int length) override;
		void bitonic_sort(int *values);
	private:
		int THREADS = 0;
		int BLOCKS = 0;
		int NUM_VALS = 0;
};