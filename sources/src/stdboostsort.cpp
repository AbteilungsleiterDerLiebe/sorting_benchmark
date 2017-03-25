#include "Stdboostsort.h"

using namespace boost;

Stdboostsort::Stdboostsort() {
	name = "std boostsort";
}

void Stdboostsort::run(int * unsortedInts, int length)
{
	std::vector<int> value_vec(unsortedInts, unsortedInts + length);
	boost::sort(value_vec);
	std::copy(value_vec.begin(), value_vec.end(), unsortedInts);
}

