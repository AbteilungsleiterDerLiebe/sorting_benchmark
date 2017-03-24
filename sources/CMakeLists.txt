cmake_minimum_required (VERSION 2.6)
project (Benchmark)
find_package(CUDA QUIET REQUIRED)
find_package( OpenCL REQUIRED )

#Bring the headers, such as Student.h into the project
include_directories(include)

#include(${CMAKE_CURRENT_SOURCE_DIR}/Boost/CMakeLists.txt)

SET (BOOST_ROOT 		"D:/Bachelor/sorting_benchmark/thridparty/boost_1_63_0")
SET (BOOST_INCLUDEDIR 	"D:/Bachelor/sorting_benchmark/thridparty/boost_1_63_0")
SET (BOOST_LIBRARYDIR 	"D:/Bachelor/sorting_benchmark/thridparty/boost_1_63_0/stage/lib")

SET (OPENCL_INCLUDE_DIR "F:/CUDA/Toolkit/include/CL/cl.h")
SET (OPENCL_LIBRARIES	"F:/CUDA/Toolkit/lib/x64/Opencl.lib")
# find Boost
find_package(Boost 1.63 REQUIRED)
include_directories( ${OPENCL_INCLUDE_DIR} )
#link_directories(${OPENCL_LIBRARYDIR_DIR})
include_directories( ${OPENCL_LIBRARIES})

#set(Boost_INCLUDE_DIR D:/Bachelor/sorting_benchmark/sources/boost_1_63_0)
#set(Boost_LIBRARY_DIR D:/Bachelor/sorting_benchmark/sources/boost_1_63_0/stage/lib)
find_package(Boost 1.63 REQUIRED)
include_directories(${BOOST_INCLUDEDIR})
link_directories(${BOOST_LIBRARYDIR})


cuda_add_library(cuda_sort
    include/cuda_sort.cuh
	include/cuda_radix_sort.cuh
	include/I_benchmark_prototye.h
	src/cuda_sort.cu
	src/cuda_radix_sort.cu
)

add_executable(
	Benchmark
	include/benchmark.h
	include/I_benchmark_prototye.h
	include/standardsort.h
	include/boostsort.h
	include/stdboostsort.h
	src/benchmark.cpp
	src/main.cpp
	src/standardsort.cpp
	src/boostsort.cpp
	src/stdboostsort.cpp
)
	TARGET_LINK_LIBRARIES(Benchmark ${OPENCL_LIBRARIES} )
	TARGET_LINK_LIBRARIES(Benchmark ${Boost_LIBRARIES})
	
	# Pass options to NVCC
set(
    CUDA_NVCC_FLAGS
    ${CUDA_NVCC_FLAGS};
   # -O3 -gencode arch=compute_22,code=sm_22
   -O3 -gencode arch=compute_30,code=sm_52
    )
	
	# todo add cmake lib to target
target_link_libraries(
	Benchmark cuda_sort
)