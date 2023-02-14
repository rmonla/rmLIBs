## ¿Cómo obtener un array con las últimas palabras de las celdas en Google Sheets?

Para obtener un array con las últimas palabras de las celdas en Google Sheets, puedes utilizar la función `REGEXEXTRACT` para extraer la última palabra de cada celda en un rango.

La fórmula quedaría así:

    =ArrayFormula(REGEXEXTRACT(A1:A, "\S+$"))
    

Donde:

- `A1:A`: es el rango de celdas donde se encuentran los textos de los cuales se desea obtener la última palabra.
- `\S+$`: es una expresión regular que busca el último conjunto de caracteres que no sean espacios en blanco (es decir, la última palabra) en cada celda.

Esta fórmula se puede ingresar en la celda superior izquierda del rango donde se desea mostrar los resultados y se expandirá automáticamente a través del rango para mostrar los resultados para cada celda en el rango de entrada.

## ¿Cómo mostrar sólo las últimas palabras que cumplen una condición en Google Sheets?

Para mostrar sólo las últimas palabras que cumplen con una condición en la segunda columna del rango, se puede utilizar la función `FILTER` de Google Sheets junto con la fórmula anterior.

La fórmula quedaría así:

    =ArrayFormula(FILTER(REGEXEXTRACT(A1:A, "\S+$"), B1:B=condición))
    

Donde:

- `A1:A`: es el rango de celdas donde se encuentran los textos de los cuales se desea obtener la última palabra.
- `B1:B`: es el rango de celdas donde se encuentra la condición que se desea cumplir.
- `\S+$`: es una expresión regular que busca el último conjunto de caracteres que no sean espacios en blanco (es decir, la última palabra) en cada celda.
- `condición`: es el valor que debe cumplir la celda en la columna B para que se muestre la última palabra correspondiente.

Esta fórmula se puede ingresar en la celda superior izquierda del rango donde se desea mostrar los resultados y se expandirá automáticamente a través del rango para mostrar sólo las últimas palabras que cumplen con la condición especificada en la columna B.
