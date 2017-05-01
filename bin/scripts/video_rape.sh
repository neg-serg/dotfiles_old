ffmpeg -t 30 -i $1 -c:v libx264 -preset slow -crf 32 -ac 1 -pix_fmt yuv420p -ar 22050 -bufsize 1024k -profile:v high10 $2
