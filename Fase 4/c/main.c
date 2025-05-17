#include "stdio.h"
#include "stdlib.h"

#define LECTURA   "r"
#define ESCRITURA "a"
#define NOMBRE_ARCHIVO "dataMeDecimal.txt"
enum {C_0=0, C_1, C_2};
enum {SUM=0, RES, MUL, DIV};

void calculadora();
void lecturaDeMemoria(int*, int**, int**);

int main(){
    calculadora();
    return C_0;
}

void lecturaDeMemoria(int* cantidadOperaciones, int** operaciones, int** operandos){
    int i;
    FILE* memoriaDatos = fopen(NOMBRE_ARCHIVO, LECTURA);
    if(memoriaDatos == NULL){
        printf("\n\n  Error al abrir archivo \n\n");
        fclose(memoriaDatos); 
        return;
    }
    fscanf(memoriaDatos, "%d", cantidadOperaciones);
    *operaciones = (int*) malloc((*cantidadOperaciones)*sizeof(int));
    *operandos   = (int*) malloc((*cantidadOperaciones)*C_2*sizeof(int));
    for(i=C_0; i<*cantidadOperaciones; i++){
        fscanf(memoriaDatos, "%d", (*operaciones)+i);
    }
    for(i=C_0; i<(*cantidadOperaciones)*C_2; i++){
        fscanf(memoriaDatos, "%d", (*operandos)+i);
    }
    fclose(memoriaDatos);
}

void calculadora(){
    int i,j;
    int resultado, residuo;
    int cantidadOperaciones;
    int* operaciones = NULL;
    int* operandos   = NULL;
    FILE* memoriaDatos = fopen(NOMBRE_ARCHIVO, ESCRITURA);
    lecturaDeMemoria(&cantidadOperaciones, &operaciones, &operandos);
    for(i=C_0; i<cantidadOperaciones; i++){
        residuo   = C_0;
        resultado = C_0;
        switch (*(operaciones+i)){
        case SUM: resultado = *(operandos+(i*C_2)) + *(operandos+(i*C_2)+C_1); break;
        case RES: resultado = *(operandos+(i*C_2)) - *(operandos+(i*C_2)+C_1); break;
        case MUL: 
            for(j=C_0; j<*(operandos+(i*C_2)+C_1); j++){
                resultado += *(operandos+(i*C_2));
            } 
            break;
        case DIV: 
            residuo = *(operandos+(i*C_2)); 
            while(residuo > *(operandos+(i*C_2)+C_1)){
                residuo -= *(operandos+(i*C_2)+C_1);
                resultado++;
            }
            break;
        }
        fprintf(memoriaDatos, "%d\n%d\n", resultado, residuo);
    }
    free(operaciones);
    free(operandos);
    fclose(memoriaDatos);
}
