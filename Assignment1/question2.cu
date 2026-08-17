#include <stdio.h>
#include <cuda_runtime.h>

__device__ volatile int counter = 0;
__global__ void func(int totalBlock){
    __syncthreads();
    if(threadIdx.x==0){
      atomicAdd((int*)&counter, 1);
    }
    __syncthreads();
    if(threadIdx.x == 0){
      while (counter < totalBlock){}
    }
    __syncthreads();
    printf("Thread %d, Block %d, BlockDim %d, counter: %d\n",threadIdx.x,blockIdx.x,blockDim.x,counter);
}

int main()
{
    func<<<5, 1024>>>(5);
    cudaDeviceSynchronize();
    return 0;
}
