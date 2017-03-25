#pragma once
#include "I_benchmark_prototye.h"
#include <boost\range\algorithm.hpp>

class Stdboostsort : public I_benchmark_prototype {

public:
	Stdboostsort();
	virtual void run(int * unsortedInts, int length) override;
};