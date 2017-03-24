#pragma once
#include <stdio.h>
#include "I_benchmark_prototye.h"
#include "cuda_runtime.h"
#include "cuda.h"
#include "device_launch_parameters.h"
#include "thrust/host_vector.h"
#include "thrust/device_vector.h"
#include "thrust/sort.h"
#include "thrust/functional.h"
#include "thrust/copy.h"
#include <thrust/device_ptr.h>

class cuda_radix_sort : public I_benchmark_prototype {
	
	public:
		cuda_radix_sort();
		virtual void run(int * unsortedInts, int length) override;
		void radix_sort(int *values);
};