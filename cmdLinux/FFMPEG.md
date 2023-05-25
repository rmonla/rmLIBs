# FFMPEG
FFMPEG es una herramienta de línea de comandos utilizada para procesar y manipular archivos multimedia, como videos y audios. Permite realizar diversas operaciones, como la unión de archivos de video, la segmentación de videos en partes más pequeñas y la extracción de fragmentos específicos de un video. Es una herramienta muy potente y ampliamente utilizada en la edición y conversión de archivos multimedia.

## Concatenar varios archivos de video en un solo archivo MP4 utilizando FFmpeg.
```sh
video_folder='IEM_1ro_7Sep_2105/' && \
(find . -type f -iname '$video_folder*' -printf "file '$PWD/%p'\n" | sort) | ffmpeg -protocol_whitelist file,pipe -f concat -safe 0 -i pipe: -c copy "${video_folder}.mp4"
```

## Segmentar video desde un punto en adelante.
```sh
ffmpeg -i input.mp4 -ss 01:32:38 -c copy b-output1.mp4
```
    
## Segmentar video desde y hasta.
```sh
ffmpeg -i 2021-06-25T01_02_05Z.mp4 -ss 00:17:55 -to 00:26:30 -c copy PSS_Pedro-1.mp4
```

## Segmentar video en partes de 20 minutos.
```sh
ffmpeg -i source.mp4 -c copy -map 0 -segment_time 00:20:00 -f segment -reset_timestamps 1 output%03d.mp4
```
