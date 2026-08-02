mkdir -p icons

for size in 16 22 24 32 48 64 96 128 256 512; do
    magick Z7_SERVERS_LOGO2.webp -resize ${size}x${size} \
        icons/${size}x${size}.png
done
