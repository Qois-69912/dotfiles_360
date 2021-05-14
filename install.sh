#!/bin/sh
# 'install.sh' adalah script primary (utama) yang nanti akan menjalankan script lainnya.
# Masing - masing script yang dijalankan mempunyai tujuan tersendiri.
# Tempat script lainnya akan berada didirectori 'script'.

main() {
    echo "Deploying / Installing dotfiles..."
    
    # Menjalankan script yang berfungsi untuk menginstall beberapa configurasi
    sh scripts/config.sh
}

main
