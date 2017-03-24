#include "Stdboostsort.h"

using namespace boost;

void Stdboostsort::run(int * unsortedInts, int length)
{
	std::vector<int> value_vec(unsortedInts, unsortedInts + length);
	boost::sort(value_vec);

	// debug to check if sorting was correct
	std::cout << "value: " << value_vec[9] << " " << value_vec[10] << " "<< value_vec[11] << std::endl;
}

