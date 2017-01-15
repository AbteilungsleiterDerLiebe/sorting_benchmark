cmake_minimum_required (VERSION 2.6)
project (Benchmark)
find_package(CUDA QUIET REQUIRED)

#Bring the headers, such as Student.h into the project
include_directories(include)
 
#Can manually add the sources using the set command as follows:
#set(SOURCES benchmark.cpp include/benchmark.h)

#However, the file(GLOB...) allows for wildcard additions:
#file(GLOB SOURCES "src/*.cpp")

#add_executable(Benchmark
#  src/benchmark.cpp
#  include/benchmark.h
#)

cuda_add_executable(
  cuda_sort
  include/benchmark.h
  include/cuda_sort.h
  src/benchmark.cpp
  src/cuda_sort.cu
)
	
	# Pass options to NVCC
set(
    CUDA_NVCC_FLAGS
    ${CUDA_NVCC_FLAGS};
    -O3 -gencode arch=compute_22,code=sm_22
    )