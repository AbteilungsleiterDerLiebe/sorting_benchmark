#pragma once
#include "I_benchmark_prototye.h"
#include <algorithm>

class Standardsort : public I_benchmark_prototype {

public:
	virtual void run(int * unsortedInts, int length) override;
};