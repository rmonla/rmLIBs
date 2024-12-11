# FFMPEG
FFMPEG es una herramienta de línea de comandos utilizada para procesar y manipular archivos multimedia, como videos y audios. Permite realizar diversas operaciones, como la unión de archivos de video, la segmentación de videos en partes más pequeñas y la extracción de fragmentos específicos de un video. Es una herramienta muy potente y ampliamente utilizada en la edición y conversión de archivos multimedia.

## Concatenar varios archivos de video en un solo archivo MP4 utilizando FFmpeg.
```sh
dir_video="IEM_1ro_7Sep_2105/"
find . -type f -iname "${dir_video}*" -printf "file '%p'\n" | sort | \
ffmpeg -protocol_whitelist file,pipe -f concat -safe 0 -i pipe:0 -c copy "${dir_video}.mp4"
```
## Guardar la parte del video que sigue después de una marca de tiempo especificada.
```sh
tiempo_desde="01:32:38"
nom_arch_origen="origen"
nom_arch_destino="destino"
ffmpeg -ss "$tiempo_desde" -i "${nom_arch_origen}.mp4" -c copy "${nom_arch_destino}.mp4" && \
echo "Se ha creado el archivo ${nom_arch_destino}.mp4"
```    
## Recorta un archivo de video desde un punto de inicio hasta un punto de finalización especificado, y guarda el resultado en un nuevo archivo de video..
```sh
archivo_origen="2021-06-25T01_02_05Z.mp4"
tiempo_inicio="00:17:55"
tiempo_fin="00:26:30"
archivo_destino="PSS_Pedro-1.mp4"
ffmpeg -i "$archivo_origen" -ss "$tiempo_inicio" -to "$tiempo_fin" -c copy "$archivo_destino"
```

## A un archivo de video lo divide en segmentos de tiempo específicos.
```sh
archivo_origen="2021-06-25T01_02_05Z.mp4"
tiempo_segmento="00:17:55"
archivo_destino="PSS_Pedro-1.mp4"
ffmpeg -i "$archivo_origen" -c:v libx264 -preset slow -crf 23 -c:a copy -map 0 -segment_time "$tiempo_segmento" -f segment -reset_timestamps 1 "$archivo_destino"
```
