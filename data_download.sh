#!/bin/bash

echo "Creating samples directory..."
mkdir -p samples
cd samples


URL="https://ftp.ncbi.nlm.nih.gov/geo/series/GSE197nnn/GSE197177/suppl/GSE197177_RAW.tar"
OUTFILE="GSE197177_RAW.tar"

echo "Downloading GSE197177 raw dataset..."
curl -L "$URL" -o "$OUTFILE"

echo "Download complete."

echo "Extracting TAR..."
tar -xvf "$OUTFILE"

echo "Extraction done."

echo "Organizing sample files..."

# Loop through all GSM* files
for file in GSM*.gz; do
    # Extract prefix before first underscore, e.g.: GSM5910784
    prefix=$(echo "$file" | cut -d'_' -f1)

    # Extract sample name after prefix (Case1-YF), removing extension
    sample=$(echo "$file" | cut -d'_' -f2- | sed 's/_matrix.mtx.gz//' | sed 's/_features.tsv.gz//' | sed 's/_barcodes.tsv.gz//')

    # Folder name: GSMxxxx_sample
    folder="${prefix}_${sample}"

    # Create folder if it does not exist
    mkdir -p "$folder"

    # Move file into folder
    mv "$file" "$folder/"
done

echo "Organization complete!"

echo "Sample folders created:"
ls -1