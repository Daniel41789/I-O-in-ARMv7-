#include <stdio.h>

int const arraySize = 3;

int sum_array(int *array)
{
    int sum = 0;
    for (int i = 0; i < arraySize; i++)
        sum += array[i];
    return sum;
}

int charToInt(char c)
{
    int i = c - '0';
    return i;
}

int main()
{
    int str1[arraySize];
    char ch;
    for (int i = 0; i < arraySize; i++)
    {
        //Lectura desde la terminal
        int val = charToInt(ch);
        str1[i] = val;
    }

    int num = sum_array(str1);
    //Salida en la terminal del resultado de la suma de los valores del arreglo
    return 0;
}
