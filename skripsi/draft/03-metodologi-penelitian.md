# BAB III - Metodologi Penelitian

## Status

Draft awal berbasis metodologi yang sudah dikunci pada catatan `skripsi/methodology-and-experiment-design.md`.

## Arah Penulisan

BAB ini perlu menjaga keseimbangan antara penjelasan metodologis dan keterukuran eksperimen. Fokus utamanya adalah menunjukkan bahwa peningkatan yang diklaim memang diuji dengan skenario dan metrik yang jelas.

## 3.1 Jenis dan Pendekatan Penelitian

Penelitian ini menggunakan metode studi kasus dengan pendekatan perbandingan eksperimental sebelum dan sesudah intervensi. Studi kasus dipilih karena penelitian difokuskan pada satu layanan backend yang dijalankan pada lingkungan deployment tertentu. Pendekatan sebelum dan sesudah intervensi digunakan untuk membandingkan kondisi operasional awal dengan kondisi setelah workflow DevOps ringan diterapkan.

## 3.2 Objek Penelitian

Objek penelitian adalah satu layanan API berbasis FastAPI yang dijalankan menggunakan Docker pada VM. Layanan menggunakan PostgreSQL sebagai dependensi utama untuk kesiapan layanan dan reverse proxy sebagai titik akses utama. Sistem juga menyediakan endpoint health check untuk mengamati kondisi liveness dan readiness.

## 3.3 Tahapan Penelitian

1. Mengidentifikasi kondisi awal dan alur deployment manual.
2. Mendokumentasikan baseline deployment dan recovery.
3. Merancang workflow DevOps ringan.
4. Mengimplementasikan quality gate, artifact build/publish, deployment verification, dan rollback.
5. Melakukan pengujian skenario.
6. Mengumpulkan data KPI baseline dan pasca-intervensi.
7. Menganalisis hasil dan menarik kesimpulan.

## 3.4 Variabel Penelitian

### Variabel Independen

Penerapan workflow DevOps ringan yang diusulkan.

### Variabel Dependen

- availability layanan,
- MTTR,
- durasi deployment,
- durasi recovery,
- keberhasilan layanan pada skenario gangguan.

## 3.5 Skenario Pengujian

### Skenario A - Deployment Normal

Mengukur durasi deployment dan memeriksa apakah layanan berada pada kondisi sehat setelah rilis.

### Skenario B - Gangguan Dependensi

Menguji perilaku layanan saat database tidak tersedia.

### Skenario C - Regresi Kualitas

Menguji apakah perubahan yang tidak valid dapat dihentikan sebelum deployment.

### Skenario D - Rilis Gagal dan Rollback

Menguji proses pemulihan layanan menggunakan image stabil sebelumnya.

### Skenario E - Kegagalan Satu Container

Skenario opsional untuk melihat continuity layanan pada mode replica.

## 3.6 Teknik Pengumpulan Data

Data dikumpulkan dari hasil CI, waktu deployment, waktu recovery, hasil health check, serta catatan eksekusi rollback dan skenario gangguan.

## 3.7 Teknik Analisis Data

Data dianalisis dengan membandingkan KPI baseline dan KPI pasca-intervensi. Hasil perbandingan disajikan dalam bentuk tabel dan dijelaskan secara deskriptif untuk melihat apakah workflow DevOps yang diusulkan memberikan peningkatan reliabilitas deployment.

## TODO Lanjutan

- tambah rumus perhitungan availability
- tambah rumus atau definisi MTTR yang dipakai
- sesuaikan istilah metodologi dengan standar kampus
- tambahkan diagram tahapan penelitian bila diperlukan