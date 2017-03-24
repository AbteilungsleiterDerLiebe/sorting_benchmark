#pragma once
#include <I_benchmark_prototye.h>
#include <vector>
#include <algorithm>
#include <boost\compute.hpp>

class Boostsort : public I_benchmark_prototype {
	public:
		virtual void run(int * unsortedInts, int length) override;
};