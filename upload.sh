#!/bin/sh

FILE="$1"

if [ -z "$FILE" ] || [ ! -f "$FILE" ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

RESPONSE=$(curl --progress-bar -X POST https://upload.gofile.io/uploadfile \
    -F "file=@${FILE}")

DOWNLOAD_URL=$(echo "$RESPONSE" | sed -n 's/.*"downloadPage":"\([^"]*\)".*/\1/p')

[ -n "$DOWNLOAD_URL" ] && echo "$DOWNLOAD_URL" || echo "Upload failed"
