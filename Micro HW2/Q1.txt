#include <stdio.h>
#include <stdlib.h>


int** allomatmem(int size) {
    int** matrix = (int**)malloc(size * sizeof(int*));
    for (int i = 0; i < size; i++) {
        matrix[i] = (int*)malloc(size * sizeof(int));
    }
    return matrix;
}

void readmat(int** matrix, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("Element [%d][%d]: ", i, j);
            scanf("%d", &matrix[i][j]);
        }
    }
}

void displaymat(int** matrix, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}

int** dotProduct(int** matrix1, int** matrix2, int size) {
    int** result = allomatmem(size);
    if (result == NULL) {
        printf("Memory allocation failed for result matrix.\n");
        return NULL;
    }

    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            int temp = 0;
            for (int k = 0; k < size; k++) {
                int val1 = matrix1[i][k];
                int val2 = matrix2[k][j];
                _asm {
                    mov eax, val1    
                    mov ebx, val2    
                    imul ebx         
                    add temp, eax    
                }
            }
            result[i][j] = temp;  
        }
    }
    return result;
}

void freematmem(int** matrix, int size) {
    for (int i = 0; i < size; i++) {
        free(matrix[i]);
    }
    free(matrix);
}

int main() {
    int size;
    printf("Enter the size of the square matrices: ");
    scanf("%d", &size);

    int** matrix1 = allomatmem(size);
    if (matrix1 == NULL) {
        printf("Memory allocation failed for first matrix.\n");
        return 1;
    }

    int** matrix2 = allomatmem(size);
    if (matrix2 == NULL) {
        printf("Memory allocation failed for second matrix.\n");
        freematmem(matrix1, size); 
        return 1;
    }

    printf("Enter the elements of the first matrix:\n");
    readmat(matrix1, size);

    printf("Enter the elements of the second matrix:\n");
    readmat(matrix2, size);

    printf("The first matrix is:\n");
    displaymat(matrix1, size);

    printf("The second matrix is:\n");
    displaymat(matrix2, size);

    int** result = dotProduct(matrix1, matrix2, size);
    if (result == NULL) {
        freematmem(matrix1, size);
        freematmem(matrix2, size);
        return 1;
    }

    printf("The dot product matrix is:\n");
    displaymat(result, size);

    freematmem(matrix1, size);
    freematmem(matrix2, size);
    freematmem(result, size);

    return 0;
}
