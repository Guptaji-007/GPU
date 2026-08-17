#include <stdio.h>
#include <cuda_runtime.h>

__device__ int counter = 0;
__global__ void func(int totalBlock){
    //__syncthreads();
    if(threadIdx.x==0)atomicAdd(&counter, 1);
    __syncthreads();
    while(counter<totalBlock){
      printf("waiting for block %d\n", 1 - blockIdx.x);
    }
    printf("Thread %d, Block %d, BlockDim %d, counter: %d\n",threadIdx.x,blockIdx.x,blockDim.x,counter);
    //__syncthreads();
}

int main()
{
    func<<<2, 10>>>(2);
    cudaDeviceSynchronize();
    return 0;
}
