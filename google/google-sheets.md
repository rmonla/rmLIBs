## Ejemplo de fórmula en Google Sheets para obtener un array con las últimas palabras de las celdas que cumplen con una determinada condición

En Google Sheets, puedes utilizar la función `FILTER` para filtrar las celdas que cumplen con una determinada condición, y luego aplicar la función `REGEXEXTRACT` para obtener las últimas palabras de esas celdas en un array.

La fórmula es la siguiente:

    =ArrayFormula(REGEXEXTRACT(FILTER(A1:A; B1:B = "condición"); "\S+$"))

Donde:

- `A1:A`: es el rango de celdas donde se encuentran los textos de los cuales se desea obtener la última palabra.
- `B1:B`: es el rango de celdas adyacente que contiene la condición que se desea aplicar.
- `"condición"`: es el valor de la condición que se desea aplicar. Por ejemplo, si se desea filtrar las celdas que contienen la palabra "hola", se debe ingresar "hola" en lugar de "condición".

Esta fórmula se puede ingresar en la celda superior izquierda del rango donde se desea mostrar los resultados y se expandirá automáticamente a través del rango para mostrar los resultados para cada celda que cumpla con la condición en el rango adyacente.

Espero que este ejemplo te sea de ayuda. Si tienes alguna otra pregunta o necesitas más ayuda, no dudes en preguntar.
