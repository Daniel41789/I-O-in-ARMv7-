# Descripción
Authors:
- Jhoan Daniel Arenas Reyes
- Karina Alcantara Segura
- Brandon Chávez Salaverría

El código en ensamblador final de este proyecto es el archivo "c.s", para llegar a este resultado el equipo se basó en los archivos, "prueba1.c" y "prueba 1.s" así como en los archivos "prueba2.c" y "prueba2.s"

El código recibe tres números ingresados por el usuario, los convierte de ASCII a enteros, almacena los valores enteros en un arreglo, suma los valores en el arreglo, convierte el resultado de entero a ASCII e imprime el resultado en la terminal.

El código tiene tres funciones: int_to_string, display, sum_array, charToInt y read_user_input.

La función int_to_string toma un número entero como parámetro y lo convierte en una cadena de caracteres, que se almacena en un arreglo. La función realiza una división para aislar los dígitos en el número y luego convierte cada dígito en un carácter ASCII sumando 48, que es el valor ASCII de '0'. La función luego almacena cada carácter en el arreglo. Finalmente, la función agrega un carácterpara indicar el final del arreglo. Dentro del bucle _loop, se va dividiendo el entero original por 10 sucesivamente y se va construyendo la cadena de caracteres. Para esto, en cada iteración, se calcula el cociente de la división (que es el dígito actual) y se lo convierte a su correspondiente valor ASCII sumándole 48 (0x30). Luego, se almacena este valor en una posición del arreglo sum y se actualiza el índice (i) para la siguiente posición

 Frame:
          24 -str       -argumento
          20 -decimal   -local
          16 -div       -local
          12 -i         -local
          8 - r7
          4 - lr
          0

La función display toma como parámetro una cadena de caracteres y muestra esa cadena en la salida estándar. Para esto, utiliza llamadas al sistema operativo a través de la instrucción svc. Se respalda del valor del primer parámetro en la pila. Luego, se carga el valor de la dirección base + 0 en el registro r1. A continuación, se mueve la dirección base a r9 para no perderla en el proceso y se mueve el valor 0x1 al registro r0, que es el valor de la llamada al sistema exit. Se mueve el valor 0x4 al registro r7, que es el valor de la llamada al sistema write, se mueve el valor 0x8 al registro r2 que es el valor de la llamada al sistema creat y se hace una llamada al sistema operativo a través de la instrucción svc.

Frame:
          12 -result     -argumento
          8 - r7
          4 - lr
          0

La función sum_array calcula la suma de los elementos de un arreglo de enteros. Toma dos argumentos: la dirección base del arreglo y el tamaño del arreglo. El arreglo se recorre utilizando un bucle while y se accede a cada elemento mediante el índice i. La suma se calcula acumulando cada elemento del arreglo en una variable result. Al final, el resultado se devuelve en el registro r0.

Frame:
          20 -size      -argumento
          16 -base      -argumento
          12 -i         -local
          8 - r7
          4 - lr
          0

La función charToInt convierte una cadena de caracteres en un valor entero. El registro r0 debe contener la dirección base de la cadena de entrada. La función comienza estableciendo el registro r2 en cero como un contador de la cantidad de caracteres en la cadena, y establece r5 y r6 en cero y uno, respectivamente, para almacenar el resultado y multiplicar cada dígito. La función entra en un bucle para recorrer la cadena de entrada. En cada iteración, se carga el byte actual de la cadena (ldrb r8, [r0]), se compara con el valor de fin de cadena (0x0a), y si son iguales, la función salta a una etiqueta _count. Si no es el final de la cadena, se aumenta el puntero de la cadena y se incrementa el contador y se salta de nuevo al bucle. La etiqueta _count decrementa el puntero de la cadena para apuntar al último dígito de la cadena. Luego, se carga el byte en el registro r8 y se le resta el valor decimal del carácter '0' (0x30) para obtener el valor decimal real del dígito.
El valor decimal del dígito se multiplica por r6, que es el multiplicador actual, para obtener su valor correspondiente en la posición correcta. El resultado se almacena en r8. Luego, se actualiza el valor de r6 multiplicando su valor actual por 10, lo que prepara el valor para la siguiente iteración en la posición decimal correcta. Finalmente, se suma el valor de r8 al resultado actual. Después de cada iteración, se decrementa el contador y se compara con cero. Si el contador es cero, la función salta a la etiqueta _leave, de lo contrario, la función salta de nuevo a _count. En la etiqueta _leave, el resultado final se almacena en r0, se ajusta el puntero de pila y se devuelve el resultado.

Frame:
          24 -str       -argumento
          20 -multi     -local
          16 -i         -local
          12 -count     -local
          8 - r7
          4 - lr
          0

La función read_user_input toma un arreglo y su tamaño como parámetros. La función lee la entrada carácter por carácter hasta que se alcanza el número máximo de caracteres. Se carga el tamaño del búfer en el registro r2 y la dirección base del búfer en el registro r1. Se establece el tipo de llamada de función en 3 en el registro r7, que corresponde a la llamada de función "read". Se realiza una llamada al sistema mediante la instrucción svc 0x0 para leer la entrada del usuario.

Frame:
          12 -input         -local
          8 - r7
          4 - lr
          0

La función main solicita al usuario que ingrese tres números, lee la entrada utilizando la función read_user_input, convierte la entrada en valores enteros utilizando la función int_to_string, suma los valores en el arreglo utilizando la función sum_array, convierte el resultado en un valor ASCII utilizando la función charToInt e imprime el resultado en la terminal utilizando la función display.

Frame: 
          24 - size        - local
          20 - a[2]        - local
          16 - a[1]        - local
          12 - a[0]        - local
          8 - i            - local
          4 - lr
          0 - r7
