#include "standardsort.h"

Standardsort::Standardsort() {
	name = "std sort";
}

void Standardsort::run(int * unsortedInts, int length)
{
	// sort this with std lib
	std::vector<int> value_vec(unsortedInts, unsortedInts + length);
	std::sort(value_vec.begin(), value_vec.end());
	std::copy(value_vec.begin(), value_vec.end(), unsortedInts);
}

