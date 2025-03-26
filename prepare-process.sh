# Yaklaşık olarak aşağıdaki işlemlerden geçti.

# Freq 150'dan küçük olanları sil
#awk '$2 >= 10' file.txt > file-min-1500.txt

# Tekrarlayan satırları temizle
# awk '!seen[$0]++' file.txt > temp_file && mv temp_file file.txt

# temiz metinleri topla
# grep -E '^[a-zA-ZçÇğĞıİöÖşŞüÜ_-]+ [0-9]+$' file.txt > file.clean.txt

# kirli metinleri topla (incelemek için)
# grep -Ev '^[a-zA-ZçÇğĞıİöÖşŞüÜ_-]+ [0-9]+$' file.txt > file.dirty.txt
