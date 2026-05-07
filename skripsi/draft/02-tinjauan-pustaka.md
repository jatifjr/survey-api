# BAB II - Tinjauan Pustaka

## Status

Kerangka draft. BAB ini belum diisi penuh karena masih menunggu pengumpulan referensi, tetapi struktur pembahasannya sudah disesuaikan dengan kebutuhan penelitian.

## Arah Penulisan

BAB ini sebaiknya tidak hanya berisi definisi istilah, tetapi juga membangun dasar argumentasi mengapa workflow DevOps ringan relevan untuk meningkatkan reliabilitas deployment layanan berbasis VM.

## 2.1 DevOps

Tuliskan definisi DevOps, tujuan utama DevOps, dan relevansinya terhadap integrasi antara proses pengembangan dan operasional. Tekankan bahwa penelitian ini membahas DevOps dalam konteks workflow ringan untuk deployment layanan backend skala kecil.

## 2.2 Continuous Integration dan Workflow Deployment

Bahas konsep Continuous Integration, quality gate, serta keterkaitan antara validasi perubahan dan kesiapan rilis. Bagian ini dapat mengarah pada argumen bahwa quality check sebelum deployment membantu menurunkan risiko rilis bermasalah.

## 2.3 Containerization dengan Docker

Bahas fungsi containerization untuk standardisasi environment dan artifact deployment. Jelaskan mengapa container image relevan sebagai artifact tunggal dalam workflow deployment.

## 2.4 Reliabilitas Layanan

Bahas konsep reliabilitas layanan, availability, downtime, failure recovery, dan MTTR. Bagian ini penting karena metrik penelitian akan banyak bertumpu pada area tersebut.

## 2.5 Health Check: Liveness dan Readiness

Bahas perbedaan liveness dan readiness serta pentingnya pemisahan keduanya dalam deployment modern. Bagian ini akan terhubung langsung dengan implementasi endpoint `/livez` dan `/readyz`.

## 2.6 Rollback dan Runbook Operasional

Bahas mengapa rollback perlu distandarisasi dan mengapa runbook penting untuk recovery yang konsisten dan terukur.

## 2.7 Penelitian Terkait

Isi dengan 3 sampai 5 penelitian yang paling dekat dengan topik ini, misalnya:

- implementasi DevOps ringan pada sistem skala kecil,
- evaluasi CI/CD untuk meningkatkan reliabilitas deployment,
- penggunaan container dan health check untuk peningkatan reliability.

## TODO Lanjutan

- cari referensi DevOps yang paling sering dipakai di kampus
- cari referensi availability dan MTTR
- cari referensi liveness vs readiness
- buat tabel perbandingan penelitian terkait