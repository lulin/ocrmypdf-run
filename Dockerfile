# Use Alpine Linux 3.21 as the base image.
FROM alpine:3.21

# Install system dependencies:
# - python3 and py3-pip: Essential for running Python and installing Python packages.
# - ghostscript and qpdf: Required by OCRmyPDF for PDF processing.
# - tesseract-ocr with language data for English (eng) and Simplified Chinese (chi_sim): For OCR.
# - pngquant: For PNG image compression.
# - unpaper: For cleaning up scanned images.
# - build-base and git: Needed for compiling software, including jbig2enc.
RUN apk add --no-cache \
    python3 \
    py3-pip \
    ghostscript \
    qpdf \
    tesseract-ocr \
    tesseract-ocr-data-eng \
    tesseract-ocr-data-chi_sim \
    tesseract-ocr-data-chi_tra \
    pngquant \
    unpaper \
    build-base \
    git

# Install OCRmyPDF using pip.
RUN pip3 install --no-cache-dir ocrmypdf

# Clone, compile, and install jbig2enc:
# - Clones the GitHub repository.
# - Compiles the source code using 'make'.
# - Copies the resulting binary to /usr/local/bin.
# - Cleans up the temporary build directory.
RUN git clone https://github.com/agl/jbig2enc /tmp/jbig2enc && \
    cd /tmp/jbig2enc && \
    make && \
    cp jbig2enc /usr/local/bin/ && \
    cd / && \
    rm -rf /tmp/jbig2enc

# Set the default entrypoint to OCRmyPDF so that any command-line arguments passed to the container are forwarded.
ENTRYPOINT ["ocrmypdf"]

