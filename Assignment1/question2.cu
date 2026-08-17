#include <stdio.h>
#include <cuda_runtime.h>

__device__ int counter = 0;
__global__ void func(int totalBlock){
    //__syncthreads();
    if(threadIdx.x==0)atomicAdd(&counter, 1);
    __syncthreads();
    while(counter<totalBlock){
      printf("waiting for other block/s \n");
    }
    printf("Thread %d, Block %d, BlockDim %d, counter: %d\n",threadIdx.x,blockIdx.x,blockDim.x,counter);
    //__syncthreads();
}

int main()
{
    func<<<10, 1024>>>(2);
    cudaDeviceSynchronize();
    return 0;
}
