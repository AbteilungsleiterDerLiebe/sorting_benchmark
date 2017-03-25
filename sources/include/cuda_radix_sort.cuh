#pragma once
#include <stdio.h>
#include "I_benchmark_prototye.h"



class cuda_radix_sort : public I_benchmark_prototype {
	
	public:
		cuda_radix_sort();
		virtual void run(int * unsortedInts, int length) override;
		void radix_sort(int *values);
	private:
		int THREADS = 0;
		int BLOCKS = 0;
		int NUM_VALS = 0;

};