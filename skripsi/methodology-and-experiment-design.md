# Methodology and Experiment Design

## Metode Penelitian

Metode yang digunakan adalah **studi kasus dengan perbandingan eksperimental sebelum dan sesudah intervensi**.

- **Fase baseline**: mengamati alur deployment dan recovery yang dilakukan secara manual pada VM.
- **Fase intervensi**: menerapkan workflow DevOps ringan yang diusulkan.
- **Fase evaluasi**: membandingkan hasil baseline dan pasca-intervensi menggunakan metrik reliabilitas yang telah ditetapkan.

## Objek Penelitian

Objek penelitian berupa satu layanan FastAPI yang dijalankan menggunakan Docker pada VM dengan karakteristik sebagai berikut:

- layanan diakses melalui reverse proxy,
- memiliki dependensi PostgreSQL untuk kebutuhan readiness,
- menyediakan endpoint `/livez` untuk liveness,
- menyediakan endpoint `/readyz` untuk readiness berbasis status dependensi.

## Komponen Utama Intervensi

1. **Quality gate sebelum deployment**
   - validasi format kode,
   - validasi lint,
   - pengujian otomatis.
2. **Standardisasi artifact container**
   - build image,
   - publish image ke registry,
   - penggunaan artifact yang konsisten pada proses deployment.
3. **Standardisasi workflow deployment**
   - prosedur update layanan dari image ke service aktif,
   - verifikasi health service setelah deployment.
4. **Standardisasi recovery**
   - prosedur rollback menggunakan image stabil sebelumnya,
   - runbook operasional sebagai acuan pemulihan.
5. **Dukungan reliabilitas runtime**
   - pemisahan liveness dan readiness,
   - toleransi saat dependensi database tidak tersedia,
   - skenario continuity berbasis replica sebagai bukti pendukung opsional.

## Variabel Penelitian

### Variabel Independen

Penerapan workflow DevOps ringan yang diusulkan.

### Variabel Dependen

- availability layanan pada periode pengamatan,
- Mean Time to Restore (MTTR),
- durasi deployment dan recovery,
- tingkat keberhasilan layanan pada skenario gangguan,
- titik deteksi masalah, apakah sebelum deployment atau setelah deployment.

## Kondisi Baseline

Kondisi baseline merepresentasikan pendekatan operasional sebelum intervensi, yaitu:

- proses update atau restart layanan dilakukan secara manual,
- verifikasi dilakukan setelah deployment tanpa gate otomatis yang mengikat,
- tidak terdapat alur baku yang memaksa validasi kualitas sebelum rilis,
- rollback bergantung pada keputusan dan tindakan operator.

## Kondisi Intervensi

Kondisi intervensi merepresentasikan workflow DevOps yang diusulkan, yaitu:

- perubahan harus melewati quality gate sebelum dilanjutkan ke proses rilis,
- image dibangun dan dipublikasikan secara terstandarisasi,
- deployment mengikuti langkah operasional yang terdokumentasi,
- health service diverifikasi setelah rollout,
- rollback dilakukan menggunakan runbook yang telah ditetapkan.

## Skenario Pengujian

### Skenario A: Deployment Normal

Tujuan:
Mengukur alur deployment, durasi deployment, dan hasil validasi pada kondisi normal.

Ekspektasi hasil:
- deployment selesai dengan sukses,
- `/livez` mengembalikan status `200`,
- `/readyz` mengembalikan status `200`.

### Skenario B: Gangguan Dependensi

Tujuan:
Mengevaluasi perilaku layanan ketika database tidak tersedia.

Ekspektasi hasil:
- proses layanan tetap berjalan,
- `/livez` mengembalikan status `200`,
- `/readyz` mengembalikan status `503`,
- kegagalan readiness tidak menyebabkan layanan dihentikan secara keliru.

### Skenario C: Regresi Kualitas Sebelum Rollout

Tujuan:
Membuktikan bahwa perubahan yang tidak valid dapat dihentikan sebelum deployment.

Ekspektasi hasil:
- quality gate CI gagal,
- proses image/deployment tidak dilanjutkan,
- masalah terdeteksi lebih awal dibandingkan pendekatan manual.

### Skenario D: Rilis Gagal dan Rollback

Tujuan:
Mengukur efektivitas proses recovery setelah dilakukan deployment rilis yang bermasalah secara terkontrol.

Ekspektasi hasil:
- rilis gagal dapat dideteksi melalui health check atau validasi pasca-deployment,
- prosedur rollback dapat dijalankan,
- layanan kembali sehat dalam batas waktu yang dapat diukur.

### Skenario E: Kegagalan Satu Container (Opsional)

Tujuan:
Mengamati continuity layanan saat salah satu container API dihentikan pada mode replica.

Ekspektasi hasil:
- endpoint melalui proxy tetap dapat diakses,
- tingkat keberhasilan request lebih baik dibandingkan mode satu instance.

## Teknik Pengumpulan Data

Data penelitian dikumpulkan dari:

- hasil dan durasi eksekusi CI,
- timestamp build dan publish image,
- waktu mulai dan selesai deployment,
- hasil pemeriksaan endpoint kesehatan setelah deployment,
- durasi downtime pada setiap skenario gangguan,
- waktu eksekusi rollback,
- MTTR sejak gangguan terdeteksi hingga layanan kembali stabil,
- tingkat keberhasilan request pada simulasi gangguan.

## Teknik Analisis Data

- Membandingkan nilai baseline dan pasca-intervensi untuk setiap KPI.
- Menyajikan hasil dalam bentuk tabel perbandingan.
- Menafsirkan apakah workflow yang diusulkan meningkatkan reliabilitas deployment dan konsistensi recovery.
- Menjelaskan ancaman terhadap validitas, terutama karena ruang lingkup penelitian terbatas pada satu layanan dan satu lingkungan deployment.
