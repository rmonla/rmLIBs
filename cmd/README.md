## FFMPEG
### Unir varios archivos de video en uno.

    vBusc='IEM_1ro_7Sep_2105'
    (find . -type f -name $vBusc'*' -printf "file '$PWD/%p'\n" | sort) | ffmpeg -protocol_whitelist file,pipe -f concat -safe 0 -i pipe: -vcodec copy -acodec copy $vBusc'.mp4'

