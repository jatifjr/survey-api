# BAB VII - Pengujian dan Evaluasi

## Status

Template draft. BAB ini sengaja belum ditulis penuh karena harus menunggu data pengujian nyata.

## Arah Penulisan

BAB ini harus berbasis data. Bagian evaluasi sebaiknya menekankan perbandingan baseline dan pasca-intervensi, bukan sekadar menceritakan bahwa pengujian telah dilakukan.

## 7.1 Skenario Pengujian

Skenario pengujian yang direncanakan meliputi:

1. deployment normal,
2. gangguan dependensi database,
3. regresi kualitas sebelum rollout,
4. rilis gagal dan rollback,
5. kegagalan satu container pada mode replica sebagai skenario opsional.

## 7.2 Hasil Pengujian Baseline

Bagian ini diisi setelah baseline diukur.

Yang perlu dimasukkan:

- durasi deployment manual,
- hasil verifikasi layanan,
- durasi recovery,
- ada atau tidaknya downtime,
- catatan inkonsistensi proses.

## 7.3 Hasil Pengujian Setelah Intervensi

Bagian ini diisi setelah workflow DevOps final dijalankan.

Yang perlu dimasukkan:

- hasil quality gate,
- hasil build/publish image,
- durasi deployment,
- hasil verifikasi `livez` dan `readyz`,
- durasi rollback,
- nilai availability dan MTTR.

## 7.4 Perbandingan KPI

Gunakan tabel perbandingan antara baseline dan pasca-intervensi.

Contoh isi:

- availability,
- MTTR,
- durasi deployment,
- durasi recovery rilis gagal,
- tingkat keberhasilan skenario gangguan.

## 7.5 Analisis Hasil

Jelaskan:

- apakah workflow DevOps benar-benar mengurangi risiko deployment,
- apakah waktu recovery menjadi lebih baik,
- apakah deteksi masalah berpindah lebih awal ke tahap CI,
- bagian mana yang masih menjadi keterbatasan.

## 7.6 Ancaman terhadap Validitas

Tuliskan kemungkinan keterbatasan seperti:

- hanya satu layanan,
- hanya satu lingkungan deployment,
- jumlah skenario terbatas,
- hasil mungkin tidak langsung berlaku untuk sistem yang lebih besar.

## TODO Lanjutan

- [ ] isi dari `skripsi/reliability-evidence-template.md`
- [ ] buat tabel KPI final
- [ ] tulis analisis berbasis angka, bukan opini saja
- [ ] tulis keterbatasan secara jujur
