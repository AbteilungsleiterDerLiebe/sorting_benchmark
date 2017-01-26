cmake_minimum_required (VERSION 2.6)
project (Benchmark)
find_package(CUDA QUIET REQUIRED)

#Bring the headers, such as Student.h into the project
include_directories(include)

cuda_add_library(cuda_sort
    include/cuda_sort.cuh
	include/I_benchmark_prototye.h
	src/cuda_sort.cu
)

add_executable(
	Benchmark
	include/benchmark.h
	include/I_benchmark_prototye.h
	src/benchmark.cpp
	src/main.cpp
)
	
	# Pass options to NVCC
set(
    CUDA_NVCC_FLAGS
    ${CUDA_NVCC_FLAGS};
    -O3 -gencode arch=compute_22,code=sm_22
    )
	
	# todo add cmake lib to target
target_link_libraries(
	Benchmark cuda_sort
)