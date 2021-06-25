## FFMPEG
### Unir varios archivos de video en uno.

    vBusc='IEM_1ro_7Sep_2105'
    (find . -type f -name $vBusc'*' -printf "file '$PWD/%p'\n" | sort) | ffmpeg -protocol_whitelist file,pipe -f concat -safe 0 -i pipe: -vcodec copy -acodec copy $vBusc'.mp4'

### Segmentar Video Desde un punto en adelante.

    ffmpeg -i input.mp4 -ss 01:32:38 -c copy b-output1.mp4

### Segmentar Video en partes de 20 minutos.

    ffmpeg -i source.mp4 -c copy -map 0 -segment_time 00:20:00 -f segment -reset_timestamps 1 output%03d.mp4
