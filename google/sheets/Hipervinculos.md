# Hipervínculos

![Estado: Investigando](https://img.shields.io/badge/Estado-Investigando-brightgreen)
![Versión: 1.3](https://img.shields.io/badge/Versión-1.3-blue)
[![Autor: Lic. Ricardo MONLA](https://img.shields.io/badge/Autor-Lic.%20Ricardo%20MONLA-orange)](mailto:rmonla@frlr.utn.edu.ar)
--------------  

## Índice

1. [Descripción](#descripción)
2. [Sintaxis de la función](#sintaxis-de-la-función)
   1. [Ejemplo de uso](#ejemplo-de-uso)
3. [Fuentes consultadas](#fuentes-consultadas)

   
## Descripción:
La función Hipervínculo en Google Sheets permite crear enlaces interactivos dentro de las hojas de cálculo. Estos enlaces pueden ser utilizados para navegar entre diferentes hojas en el mismo libro, acceder a recursos externos en línea o organizar datos complejos en una hoja separada.

Algunas de las formas en las que la función Hipervínculo puede ser útil son:

1. Navegación interna: Puedes crear enlaces que te permitan saltar rápidamente entre diferentes hojas dentro del mismo libro.

2. Enlaces externos: Es posible crear enlaces a páginas web externas, lo que facilita el acceso a recursos en línea, como documentación o sitios web de referencia.

3. Organización de datos: Los hipervínculos pueden ser utilizados para organizar datos complejos en una hoja separada, lo que ayuda a mantener la hoja principal más legible y organizada.

4. Menús e índices: Puedes crear menús interactivos o índices que permitan una navegación más fácil dentro del documento.

5. Informes y presentaciones: Los hipervínculos son útiles para generar informes o presentaciones en Google Sheets, ya que permiten acceder rápidamente a información adicional o recursos externos.

6. Mejora de la usabilidad: La función Hipervínculo hace que una hoja de cálculo sea más fácil de usar y navegar, especialmente en documentos extensos con gran cantidad de datos.

7. Compartir recursos: Al compartir hojas de cálculo con otros colaboradores, los hipervínculos permiten compartir recursos importantes y relevantes sin tener que copiar y pegar enlaces.

En resumen, la función Hipervínculo en Google Sheets es una herramienta valiosa que mejora la experiencia de usuario, facilita la organización de datos y permite un acceso rápido a recursos externos, convirtiéndola en una función poderosa dentro de la suite de Google Sheets.

<p align="right">
  <a href="#índice">
    <img src="https://img.shields.io/badge/Volver_al_-Índice-lightgrey" alt="Volver al Índice">
  </a>
</p>

## Sintaxis de la función:
La función Hipervínculo en Google Sheets tiene la siguiente sintaxis:
```python
=HIPERVINCULO(enlace, [etiqueta])
```
### Donde:

- `enlace`: Es el enlace o dirección URL al que se desea dirigir el hipervínculo. Puede ser una URL completa, una referencia de celda que contenga la URL o un texto que represente la dirección web.

- `[etiqueta] (opcional)`: Es el texto que se mostrará como el hipervínculo en la celda. Si no se proporciona este argumento, la función mostrará el enlace completo.

### Ejemplo de uso:

Supongamos que en la celda `A1` tenemos la `URL` "https://www.google.com" y en la celda `B1` queremos crear un hipervínculo que dirija a esa dirección web y se muestre como "Visitar Google". La función Hipervínculo se usaría de la siguiente manera:
```python
=HIPERVINCULO(A1, "Visitar Google")
```
Una vez que se aplique esta fórmula en la celda `B1`, se creará un hipervínculo que redirigirá al enlace "https://www.google.com" y se mostrará el texto "Visitar Google" como el enlace.

Recuerda que la función `Hipervínculo` puede usarse en cualquier celda de la hoja de cálculo para crear enlaces interactivos que faciliten la navegación y el acceso a recursos externos o internos.

<p align="right">
  <a href="#índice">
    <img src="https://img.shields.io/badge/Volver_al_-Índice-lightgrey" alt="Volver al Índice">
  </a>
</p>

## Fuentes consultadas:
- [Función Hipervinculo 8 formas de uso](https://sites.google.com/view/ofimaticaparaemprendedores/Hojas-de-Calculo/funci%C3%B3n-hiperv%C3%ADnculo-8-formas-de-uso)
- [HIPERVINCULO (HYPERLINK)](https://support.google.com/docs/answer/3093313?hl=es-419)
- [Cómo copiar una hoja de cálculo](http://gapps.upaep.mx/inicio/googledocs/tips-de-google-docs/cmo-copiar-una-hoja-de-clculo)
- [[GOOGLE SHEETS] GENERAR LINK DE DESCARGA DE UNA HOJA ESPECÍFICA DE UNA PLANILLA DE GOOGLE](https://www.youtube.com/watch?v=bi_j1XWRf9w)
- [Extraer la URL o el texto de un enlace desde una celda de Hojas de Cálculo de Google](https://www.youtube.com/watch?v=9RSPFD07tzg)
- [Creando y gestionando Hipervinculos y enlaces en Google Sheets](https://www.youtube.com/watch?v=l__n4u2_VuA)
- [Cómo obtener la URL para compartir cualquier hoja de Google Sheets](https://botize.com/es/app/gspreadsheet/share-sheet-url)

<p align="right">
  <a href="#índice">
    <img src="https://img.shields.io/badge/Volver_al_-Índice-lightgrey" alt="Volver al Índice">
  </a>
</p>
