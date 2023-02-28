#include <stdio.h>

int sum_array(int *array){
    int sum = 0;
    for(int i=0; i<3; i++)
        sum += array[i];
    return sum;
}

int ascii_to_int(char *str) {
    int num = 0;
    while (*str != '\0') {
        if (*str >= '0' && *str <= '9') {
            num = num * 10 + (*str - '0');
        }
        else {
            return 0; // la cadena no contiene un número válido
        }
        str++;
    }
    return num;
}

int main() {
    char str1[4];
    int num = ascii_to_int(str1);
    return 0;
}
