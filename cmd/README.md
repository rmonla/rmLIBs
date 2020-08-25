## FFMPEG
### Unir varios archivos de video en uno.

    vBusc="Epistemologia_21-08-2020_" | (find . -type f -name $vBusc'*' -printf "file '$PWD/%p'\n" | sort) | ffmpeg -protocol_whitelist file,pipe -f concat -safe 0 -i pipe: -vcodec copy -acodec copy "resultado.mp4"

