#include "standardsort.h"

void Standardsort::run(int * unsortedInts, int length)
{
	// sort this with std lib
	std::vector<int> value_vec(unsortedInts, unsortedInts + length);
	std::sort(value_vec.begin(), value_vec.end());

	// debug to check if sorting was correct
	std::cout << "value: " << value_vec[9] << " " << value_vec[10] << " " << value_vec[11] << std::endl;
}

