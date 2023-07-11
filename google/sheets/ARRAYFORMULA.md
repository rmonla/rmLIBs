# =ARRAYFORMULA(fórmula)

![Estado: Estable](https://img.shields.io/badge/Estado-Estable-brightgreen)
![Versión: 1.1](https://img.shields.io/badge/Versión-1.3-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)
--------------  

## Descripción
La función ARRAYFORMULA en Google Sheets permite aplicar una fórmula a un rango de celdas en forma de matriz, lo que significa que la fórmula se aplicará automáticamente a todas las celdas dentro del rango especificado.

La sintaxis básica de ARRAYFORMULA es la siguiente:

```scss

=ARRAYFORMULA(fórmula)
```
Donde "fórmula" representa la fórmula que deseas aplicar al rango de celdas.

Por ejemplo, supongamos que tienes una columna de números en A1:A5 y deseas aplicar una fórmula que multiplique cada número por 2. Puedes usar ARRAYFORMULA de la siguiente manera:

```scss

=ARRAYFORMULA(A1:A5 * 2)
```
Esta fórmula multiplicará cada número en la columna A por 2 y mostrará los resultados en las celdas correspondientes.

Es importante tener en cuenta que ARRAYFORMULA solo funciona con ciertas funciones y operaciones que admiten cálculos en matrices. No todas las fórmulas y funciones son compatibles con ARRAYFORMULA. Por lo tanto, es posible que debas verificar la compatibilidad de la fórmula que deseas utilizar antes de aplicarla con ARRAYFORMULA.

Recuerda ajustar el rango de celdas y la fórmula según tus necesidades y los datos de tu hoja de cálculo específica.

## ARRAYFORMULA en 2(dos) dimensiones
### Ejemplo1
La función ARRAYFORMULA en Google Sheets permite aplicar una fórmula a un rango de celdas en una dimensión específica. Si deseas utilizar ARRAYFORMULA en dos dimensiones, puedes combinarla con otras funciones para lograrlo.

Por ejemplo, supongamos que tienes una fórmula que deseas aplicar a una matriz de 3x3 en las celdas A1:C3. Puedes utilizar ARRAYFORMULA junto con la función ROW y COLUMN para generar las referencias de celda en dos dimensiones:

```scss

=ARRAYFORMULA(TU_FORMULA(ROW(A1:C3), COLUMN(A1:C3)))
```
En esta fórmula, TU_FORMULA representa la fórmula que deseas aplicar a cada celda de la matriz. ROW(A1:C3) genera los números de fila correspondientes a la matriz y COLUMN(A1:C3) genera los números de columna correspondientes. Al combinarlos en TU_FORMULA, puedes lograr la aplicación de la fórmula en dos dimensiones.

Recuerda ajustar la fórmula TU_FORMULA según tus necesidades y los rangos de celdas en tu hoja de cálculo específica.

### Ejemplo2
La función `ARRAYFORMULA` en Google Sheets se utiliza normalmente para aplicar una fórmula a un rango de celdas en una dimensión, es decir, a lo largo de una columna o una fila. Sin embargo, no es posible utilizar `ARRAYFORMULA` directamente en una matriz bidimensional.

Para aplicar `ARRAYFORMULA` en una matriz bidimensional, una posible solución es utilizar una combinación de otras funciones como `IF`, `ROW` y `COLUMN` para iterar a través de las filas y columnas de la matriz y aplicar la fórmula deseada.

Aquí tienes un ejemplo de cómo podrías utilizar `ARRAYFORMULA` en una matriz bidimensional de 3x3:

```
=ARRAYFORMULA(IF(ROW(A1:C3) <= 3, COLUMN(A1:C3), ""))
```

En este ejemplo, la fórmula `IF(ROW(A1:C3) <= 3, COLUMN(A1:C3), "")` se utiliza para iterar a través de las filas y columnas de la matriz y devuelve el número de columna si la fila es menor o igual a 3, y una cadena vacía si no cumple esa condición.

Ten en cuenta que este es solo un ejemplo simple y puede variar dependiendo de la fórmula que desees aplicar en tu matriz bidimensional específica. Puedes adaptar el ejemplo según tus necesidades y la lógica que deseas implementar en tu hoja de cálculo.