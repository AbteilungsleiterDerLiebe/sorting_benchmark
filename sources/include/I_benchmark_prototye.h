#pragma once
#include <vector>
#include <time.h>
#include <iostream>

class I_benchmark_prototype {

	public:
		void measure(int * unsortedInts, int length) {
			clock_t start, stop;
			start = clock();
			run(unsortedInts, length);
			stop = clock();
			print_elapsed(start, stop);
		}
		std::string name;

	private:
		virtual void run(int * unsortedInts, int length) = 0;
		void print_elapsed(clock_t start, clock_t stop)
		{
			double elapsed = ((double)(stop - start)) / CLOCKS_PER_SEC;
			//std::cout << "" << name << ": ";
			printf("Elapsed time: %.3fs", elapsed);
			printf("\n");
		}

		void setName(std::string _name) {
			name = _name;
		}

		std::string getName() {
			return name;
		}

};