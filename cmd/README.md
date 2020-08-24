## FFMPEG
### Unir varios archivos de video en uno.

    ffmpeg -safe 0 -f concat -i <(find . -type f -name 'TSME_08-05-2020_Parte*' -printf "file '$PWD/%p'\n" | sort) -c copy output.mkv
    (find . -type f -name 'TSME_08-05-2020_Parte*' -printf "file '$PWD/%p'\n" | sort) | ffmpeg -protocol_whitelist file,pipe -f concat -safe 0 -i pipe: -vcodec copy -acodec copy "result2.mp4"
