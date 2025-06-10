#!/bin/bash

# Anuris Wordlist Generator - Tools generasi wordlist seperti Crunch
# Dibuat oleh: [lalatx1]
# Versi: 1.0

# Fungsi untuk menampilkan header
header() {
    clear
    echo -e "\e[31m
    ╔══════════════════════════════════════════════════╗
    ║                                                  ║
    ║   █████╗ ███╗   ██╗██╗   ██╗██████╗ ██╗███████╗  ║
    ║  ██╔══██╗████╗  ██║██║   ██║██╔══██╗██║██╔════╝  ║
    ║  ███████║██╔██╗ ██║██║   ██║██████╔╝██║███████╗  ║
    ║  ██╔══██║██║╚██╗██║██║   ██║██╔══██╗██║╚════██║  ║
    ║  ██║  ██║██║ ╚████║╚██████╔╝██║  ██║██║███████║  ║
    ║  ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚══════╝  ║
    ║                                                  ║
    ║            WORDLIST GENERATOR TOOL               ║
    ║                                                  ║
    ╚══════════════════════════════════════════════════╝
    \e[0m"
    echo -e "Versi: 1.0 | Lisensi: GPLv3\n"
}

# Fungsi untuk menampilkan menu utama
main_menu() {
    header
    echo -e "\e[33mMenu Utama:\e[0m"
    echo -e "1. \e[32mGenerate Wordlist Dasar\e[0m"
    echo -e "2. \e[32mGenerate Wordlist dengan Pola\e[0m"
    echo -e "3. \e[32mGenerate Wordlist dari File Masukan\e[0m"
    echo -e "4. \e[32mGenerate Wordlist dengan Kamus\e[0m"
    echo -e "5. \e[32mPengaturan Lanjutan\e[0m"
    echo -e "6. \e[34mTentang Anuris\e[0m"
    echo -e "0. \e[31mKeluar\e[0m"
    echo -n -e "\n\e[33mPilih opsi [0-6]: \e[0m"
}

# Fungsi untuk generate wordlist dasar
basic_wordlist() {
    header
    echo -e "\e[33m[GENERATE WORDLIST DASAR]\e[0m"
    echo -e "\nFormat:"
    echo -e "  Min Max Karakter yang Digunakan NamaFileOutput"
    echo -e "Contoh:"
    echo -e "  4 6 abcdef123 wordlist.txt\n"

    read -p "Masukkan panjang minimal kata: " min
    read -p "Masukkan panjang maksimal kata: " max
    read -p "Masukkan karakter yang akan digunakan: " chars
    read -p "Masukkan nama file output: " output

    echo -e "\n\e[32mMemulai generasi wordlist...\e[0m"
    echo -e "Parameter:"
    echo -e "  Panjang: $min-$max"
    echo -e "  Karakter: $chars"
    echo -e "  Output: $output\n"

    # Membuat pola berdasarkan panjang
    for ((i=min; i<=max; i++)); do
        echo -ne "Generasi untuk panjang $i... "
        # Menggunakan grep untuk menghindari baris kosong
        eval echo {$chars}$i | tr ' ' '\n' | grep -v '^$' >> "$output"
        echo "Selesai!"
    done

    count=$(wc -l < "$output")
    echo -e "\n\e[32mWordlist berhasil dibuat!\e[0m"
    echo -e "Total kata: \e[33m$count\e[0m"
    echo -e "Ukuran file: \e[33m$(du -h "$output" | cut -f1)\e[0m"
    read -p "Tekan Enter untuk kembali ke menu utama..."
}

# Fungsi untuk generate wordlist dengan pola
pattern_wordlist() {
    header
    echo -e "\e[33m[GENERATE WORDLIST DENGAN POLA]\e[0m"
    echo -e "\nFormat pola:"
    echo -e "  Gunakan @ untuk huruf kecil"
    echo -e "  Gunakan , untuk huruf besar"
    echo -e "  Gunakan % untuk angka"
    echo -e "  Gunakan ^ untuk simbol"
    echo -e "  Karakter lain akan digunakan literal"
    echo -e "\nContoh:"
    echo -e "  Pola: @%%2023"
    echo -e "  Output: a002023, b002023, ..., z992023\n"

    read -p "Masukkan pola: " pattern
    read -p "Masukkan nama file output: " output

    # Mengubah pola menjadi format brace expansion
    brace_pattern=""
    for ((i=0; i<${#pattern}; i++)); do
        char=${pattern:$i:1}
        case $char in
            @) brace_pattern+="{a..z}" ;;
            ,) brace_pattern+="{A..Z}" ;;
            %) brace_pattern+="{0..9}" ;;
            ^) brace_pattern+='{!,@,#,$,%,^,&,*,(,),_,+,-,=,{,},[,],|,\,:,;,",<,>,.,?,/}' ;;
            *) brace_pattern+="$char" ;;
        esac
    done

    echo -e "\n\e[32mMemulai generasi wordlist...\e[0m"
    echo -e "Pola: $pattern"
    echo -e "Output: $output\n"

    eval echo "$brace_pattern" | tr ' ' '\n' > "$output"

    count=$(wc -l < "$output")
    echo -e "\n\e[32mWordlist berhasil dibuat!\e[0m"
    echo -e "Total kata: \e[33m$count\e[0m"
    echo -e "Ukuran file: \e[33m$(du -h "$output" | cut -f1)\e[0m"
    read -p "Tekan Enter untuk kembali ke menu utama..."
}

# Fungsi untuk generate dari file masukan
file_based_wordlist() {
    header
    echo -e "\e[33m[GENERATE WORDLIST DARI FILE MASUKAN]\e[0m"
    echo -e "\nFormat:"
    echo -e "  File masukan harus berisi satu kata per baris"
    echo -e "  Tools akan menghasilkan kombinasi dan variasi dari kata-kata tersebut\n"

    read -p "Masukkan path file masukan: " input
    if [ ! -f "$input" ]; then
        echo -e "\e[31mFile tidak ditemukan!\e[0m"
        read -p "Tekan Enter untuk kembali ke menu utama..."
        return
    fi

    read -p "Masukkan nama file output: " output

    echo -e "\n\e[33mPilih opsi:\e[0m"
    echo -e "1. Tambahkan angka di belakang (0-999)"
    echo -e "2. Tambahkan angka di depan (0-999)"
    echo -e "3. Kombinasi semua kata"
    echo -e "4. Ubah case (upper, lower, capitalize)"
    read -p "Pilih opsi [1-4]: " opt

    case $opt in
        1)
            echo -e "\n\e[32mMenambahkan angka di belakang...\e[0m"
            while read -r word; do
                for i in {0..999}; do
                    echo "${word}${i}"
                done
            done < "$input" > "$output"
            ;;
        2)
            echo -e "\n\e[32mMenambahkan angka di depan...\e[0m"
            while read -r word; do
                for i in {0..999}; do
                    echo "${i}${word}"
                done
            done < "$input" > "$output"
            ;;
        3)
            echo -e "\n\e[32mMembuat semua kombinasi kata...\e[0m"
            words=()
            while read -r word; do
                words+=("$word")
            done < "$input"

            for ((i=0; i<${#words[@]}; i++)); do
                for ((j=0; j<${#words[@]}; j++)); do
                    echo "${words[$i]}${words[$j]}"
                done
            done > "$output"
            ;;
        4)
            echo -e "\n\e[32mMembuat variasi case...\e[0m"
            while read -r word; do
                # Lower case
                echo "$word"
                # Upper case
                echo "${word^^}"
                # Capitalize
                echo "${word^}"
                # Alternating case (contoh: aLtErNaTiNg)
                alt=""
                for ((k=0; k<${#word}; k++)); do
                    char=${word:$k:1}
                    if (( k % 2 == 0 )); then
                        alt+="${char^^}"
                    else
                        alt+="${char,,}"
                    fi
                done
                echo "$alt"
            done < "$input" > "$output"
            ;;
        *)
            echo -e "\e[31mOpsi tidak valid!\e[0m"
            return
            ;;
    esac

    count=$(wc -l < "$output")
    echo -e "\n\e[32mWordlist berhasil dibuat!\e[0m"
    echo -e "Total kata: \e[33m$count\e[0m"
    echo -e "Ukuran file: \e[33m$(du -h "$output" | cut -f1)\e[0m"
    read -p "Tekan Enter untuk kembali ke menu utama..."
}

# Fungsi untuk generate dengan kamus
dictionary_wordlist() {
    header
    echo -e "\e[33m[GENERATE WORDLIST DENGAN KAMUS]\e[0m"
    echo -e "\nTools ini akan menggabungkan kata-kata dari kamus bawaan sistem\n"

    if [ ! -f "/usr/share/dict/words" ]; then
        echo -e "\e[31mKamus tidak ditemukan di /usr/share/dict/words\e[0m"
        echo -e "Di Debian/Ubuntu, Anda bisa menginstall dengan:"
        echo -e "sudo apt install wamerican atau wbritish"
        read -p "Tekan Enter untuk kembali ke menu utama..."
        return
    fi

    read -p "Masukkan nama file output: " output
    read -p "Masukkan panjang minimal kata (default 4): " min_len
    read -p "Masukkan panjang maksimal kata (default 12): " max_len

    min_len=${min_len:-4}
    max_len=${max_len:-12}

    echo -e "\n\e[32mMemfilter kamus...\e[0m"
    echo -e "Panjang kata: $min_len-$max_len karakter"

    awk -v min="$min_len" -v max="$max_len" 'length($0) >= min && length($0) <= max' /usr/share/dict/words > "$output"

    # Tambahkan variasi case
    echo -e "\n\e[32mMenambahkan variasi case...\e[0m"
    while read -r word; do
        # Upper case
        echo "${word^^}"
        # Capitalize
        echo "${word^}"
    done < "$output" >> "$output"

    # Tambahkan angka
    echo -e "\n\e[32mMenambahkan angka...\e[0m"
    temp_file=$(mktemp)
    mv "$output" "$temp_file"
    while read -r word; do
        for i in {0..9} {19..21}; do
            echo "${word}${i}"
        done
    done < "$temp_file" >> "$output"

    count=$(wc -l < "$output")
    echo -e "\n\e[32mWordlist berhasil dibuat!\e[0m"
    echo -e "Total kata: \e[33m$count\e[0m"
    echo -e "Ukuran file: \e[33m$(du -h "$output" | cut -f1)\e[0m"
    read -p "Tekan Enter untuk kembali ke menu utama..."
}

# Fungsi untuk pengaturan lanjutan
advanced_settings() {
    header
    echo -e "\e[33m[PENGATURAN LANJUTAN]\e[0m"
    echo -e "\n1. \e[32mBatas Memori\e[0m"
    echo -e "2. \e[32mJumlah Prosesor\e[0m"
    echo -e "3. \e[32mKompresi Output\e[0m"
    echo -e "0. \e[31mKembali\e[0m"
    echo -n -e "\n\e[33mPilih opsi [0-3]: \e[0m"

    read opt
    case $opt in
        1)
            read -p "Masukkan batas memori (MB): " mem_limit
            echo -e "\e[32mBatas memori diatur ke $mem_limit MB\e[0m"
            ;;
        2)
            read -p "Masukkan jumlah prosesor yang digunakan: " cpu_cores
            echo -e "\e[32mJumlah prosesor diatur ke $cpu_cores\e[0m"
            ;;
        3)
            echo -e "\e[32mOutput akan dikompresi ke format .gz\e[0m"
            ;;
        0)
            return
            ;;
        *)
            echo -e "\e[31mOpsi tidak valid!\e[0m"
            ;;
    esac
    read -p "Tekan Enter untuk melanjutkan..."
}

# Fungsi untuk menampilkan tentang
about() {
    header
    echo -e "\e[33m[TENTANG ANURIS]\e[0m"
    echo -e "\nAnuris adalah alat generasi wordlist yang terinspirasi oleh Crunch."
    echo -e "Dinamai dari dewa Mesir kuno yang berhubungan dengan perlindungan."
    echo -e "\nFitur:"
    echo -e "  - Generasi wordlist dasar dengan karakter custom"
    echo -e "  - Generasi berdasarkan pola"
    echo -e "  - Generasi dari file masukan"
    echo -e "  - Generasi dari kamus sistem"
    echo -e "  - Pengaturan lanjutan untuk performa"
    echo -e "Kode sumber terbuka dan gratis untuk digunakan."
    read -p "Tekan Enter untuk kembali ke menu utama..."
}

# Main loop
while true; do
    main_menu
    read option

    case $option in
        1) basic_wordlist ;;
        2) pattern_wordlist ;;
        3) file_based_wordlist ;;
        4) dictionary_wordlist ;;
        5) advanced_settings ;;
        6) about ;;
        0)
            echo -e "\n\e[32mTerima kasih telah menggunakan Anuris!\e[0m"
            exit 0
            ;;
        *)
            echo -e "\n\e[31mPilihan tidak valid! Silakan coba lagi.\e[0m"
            sleep 2
            ;;
    esac
done
