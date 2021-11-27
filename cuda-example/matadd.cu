#include<stdio.h>
#include<cuda.h>
#include<cuda_runtime.h>

#define N 512

__global__ void MatAdd(float *A, float *B, float *C)
{
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    int j = blockIdx.y * blockDim.y + threadIdx.y;

    // C = A + B
    if(i < N && j < N){
        C[i*N+j] = A[i*N+j] + B[i*N+j];
    }

}

int main()
{

    float *h_A, *h_B, *h_C;
    float *d_A, *d_B, *d_C;

    int i;

    // allocate the host memory
    h_A = (float*)malloc(N * N * sizeof(float));
    h_B = (float*)malloc(N * N * sizeof(float));
    h_C = (float*)malloc(N * N * sizeof(float));

    // init host data
    for(i = 0; i < (N * N); i++)
    {
	    h_A[i] = 1.0;
	    h_B[i] = 2.0;
	    h_C[i] = 0.0;
    }

    // allocate device memory
    cudaMalloc((void**)&d_A,  N * N * sizeof(float));
    cudaMalloc((void**)&d_B,  N * N * sizeof(float));
    cudaMalloc((void**)&d_C,  N * N * sizeof(float));
    
    // transfer host data to device
    cudaMemcpy(d_A, h_A, N * N * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_B, N * N * sizeof(float), cudaMemcpyHostToDevice);

    // fill in correct thread/blocks
    unsigned int x_size = 32;
    unsigned int y_size = 32;
    unsigned int grid_rows = (N + x_size - 1) / x_size;
    unsigned int grid_cols = (N + y_size - 1) / y_size;
    dim3 dimGrid(grid_cols, grid_rows);
    dim3 dimBlock(x_size, y_size);

    // Launch MatAdd kernel
    MatAdd<<<dimGrid, dimBlock>>>(d_A, d_B, d_C);

    // transfer device data back to host
    cudaMemcpy(h_C, d_C, N * N * sizeof(float), cudaMemcpyDeviceToHost);

    int all_ok = 1;
    for(i = 0; i < (N * N); i++)
    {
        if(h_C[i]!= 3.0)
        {
	        all_ok = 0;
	    }
    }

    if(all_ok)
    {
        printf("all results are correct!!!\n");
    }
    else
    {
        printf("incorrect results\n");
    }

    // free memory
    free(h_A);
    free(h_B);
    free(h_C);
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);

    return 0;
}
