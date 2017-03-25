#pragma once
#include "I_benchmark_prototye.h"
#include <algorithm>

class Standardsort : public I_benchmark_prototype {

public:
	Standardsort();
	virtual void run(int * unsortedInts, int length) override;
};