#include "boostsort.h"

namespace compute = boost::compute;

Boostsort::Boostsort() {
	name = "Boost Radix Sort";
}

void Boostsort::run(int * unsortedInts, int length)
{
	compute::device gpu = compute::system::default_device();
	compute::context ctx(gpu);
	compute::command_queue queue(ctx, gpu);
	
	std::vector<int> host_vector(unsortedInts, unsortedInts + length);
	compute::vector<int> device_vector(length, ctx);

	// copy data to the device
	compute::copy(
		host_vector.begin(), host_vector.end(), device_vector.begin(), queue
	);

	// sort data on the device
	compute::sort(
		device_vector.begin(), device_vector.end(), queue
	);

	// copy data back to the host
	compute::copy(
		device_vector.begin(), device_vector.end(), unsortedInts, queue
	);
}
