#!/bin/bash

# ============================================================
# Prepare SLAM sequence (TUM format compatible)
#
# 1. Downscale video
# 2. Extract frames
# 3. Create rgb.txt with RELATIVE paths
#
# Usage:
# ./prepare_sequence.sh /path/to/video.mp4 WIDTH HEIGHT [FPS]
#
# Example:
# ./prepare_sequence.sh ~/Datasets/video_fixed.mp4 960 540 30
# ============================================================

set -e

INPUT_VIDEO="$1"
WIDTH="$2"
HEIGHT="$3"
FPS="${4:-30}"

# -------------------------
# Argument check
# -------------------------
if [ -z "$INPUT_VIDEO" ] || [ -z "$WIDTH" ] || [ -z "$HEIGHT" ]; then
    echo "Usage: ./prepare_sequence.sh /path/to/video.mp4 WIDTH HEIGHT [FPS]"
    exit 1
fi

if [ ! -f "$INPUT_VIDEO" ]; then
    echo "Error: Video file not found: $INPUT_VIDEO"
    exit 1
fi

# -------------------------
# Resolve absolute path
# -------------------------
INPUT_VIDEO=$(realpath "$INPUT_VIDEO")

VIDEO_DIR=$(dirname "$INPUT_VIDEO")
VIDEO_FILENAME=$(basename "$INPUT_VIDEO")
VIDEO_BASENAME="${VIDEO_FILENAME%.*}"

OUTPUT_DIR="$VIDEO_DIR/${VIDEO_BASENAME}_${WIDTH}x${HEIGHT}"
FRAMES_DIR="$OUTPUT_DIR/frames"

echo "--------------------------------------------"
echo "Input video:      $INPUT_VIDEO"
echo "Video directory:  $VIDEO_DIR"
echo "Output directory: $OUTPUT_DIR"
echo "Resolution:       ${WIDTH}x${HEIGHT}"
echo "FPS:              $FPS"
echo "--------------------------------------------"

# -------------------------
# Create output directories
# -------------------------
mkdir -p "$OUTPUT_DIR"
mkdir -p "$FRAMES_DIR"

# -------------------------
# Downscale video
# -------------------------
echo "Downscaling video..."
ffmpeg -y -i "$INPUT_VIDEO" \
    -vf "scale=${WIDTH}:${HEIGHT}" \
    "$OUTPUT_DIR/downscaled.mp4"

# -------------------------
# Extract frames
# -------------------------
echo "Extracting frames..."
ffmpeg -y -i "$OUTPUT_DIR/downscaled.mp4" \
    -r "$FPS" \
    "$FRAMES_DIR/frame_%06d.png"

# -------------------------
# Create rgb.txt (RELATIVE paths!)
# -------------------------
echo "Creating rgb.txt..."

cd "$OUTPUT_DIR"

ls frames/*.png | sort | awk -v fps="$FPS" '{
    printf("%.6f %s\n", (NR-1)/fps, $0)
}' > rgb.txt

cd - > /dev/null

echo "--------------------------------------------"
echo "Sequence preparation complete."
echo "Frames created: $(ls "$FRAMES_DIR" | wc -l)"
echo "rgb.txt location: $OUTPUT_DIR/rgb.txt"
echo "--------------------------------------------"
