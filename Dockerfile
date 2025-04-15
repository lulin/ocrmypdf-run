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
    ocrmypdf \
    python3 \
    ghostscript \
    qpdf \
    tesseract-ocr \
    tesseract-ocr-data-eng \
    tesseract-ocr-data-chi_sim \
    tesseract-ocr-data-chi_tra \
    pngquant \
    unpaper \
    build-base \
    jbig2enc

# Install OCRmyPDF using pip.
# RUN pip3 install --no-cache-dir ocrmypdf


# Set the default entrypoint to OCRmyPDF so that any command-line arguments passed to the container are forwarded.
ENTRYPOINT ["ocrmypdf"]

