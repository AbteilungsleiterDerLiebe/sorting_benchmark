#pragma once
#include <stdio.h>
#include "I_benchmark_prototye.h"
#include "cuda_runtime.h"
#include "cuda.h"
#include "device_launch_parameters.h"

class cuda_sort : public I_benchmark_prototype {
	
	public:
		virtual int test_output() override;
		void bitonic_sort(int *values);

};