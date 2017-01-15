#pragma once

class cuda_sort {
	public:
		cuda_sort();
	private:
		void saxpy(int n, float a, float *x, float *y);
		void cuda_function();
};