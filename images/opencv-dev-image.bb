SUMMARY = "An opencv  development image for the overo"

require console-dev-image.bb

OPENCV_DEV = " \
    libopencv-core \
    libopencv-core-dev \
    libopencv-features2d \
    libopencv-features2d-dev \
    libopencv-imgproc \
    libopencv-imgproc-dev \
    libopencv-shape \
    libopencv-shape-dev \
"

IMAGE_INSTALL += " \
    ${OPENCV_DEV} \
"

export IMAGE_BASENAME = "opencv-dev-image"
