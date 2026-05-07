# BAB VI - Implementasi

## Status

Draft berbasis repositori saat ini. Beberapa bagian masih perlu diperbarui setelah deployment flow final diputuskan.

## Arah Penulisan

BAB ini harus konsisten dengan BAB V. Setiap subbab implementasi sebaiknya menunjukkan hubungan langsung antara rancangan yang diusulkan dan artefak nyata yang tersedia pada repositori atau lingkungan deployment.

## 6.1 Implementasi Quality Gate

Implementasi quality gate dilakukan melalui workflow otomatis pada GitHub Actions. Workflow ini menjalankan pemeriksaan format, lint, dan test terhadap perubahan yang masuk melalui pull request maupun push pada branch tertentu. Dengan implementasi tersebut, validasi kualitas kode menjadi bagian dari alur kerja yang terstandarisasi dan tidak lagi sepenuhnya bergantung pada pemeriksaan manual.

Keberadaan quality gate berperan sebagai lapisan pengendalian awal yang mencegah perubahan bermasalah masuk ke tahap rilis. Dalam konteks penelitian ini, quality gate merupakan salah satu komponen utama yang mendukung pergeseran dari deployment manual menuju workflow yang lebih terkontrol.

## 6.2 Implementasi Build dan Publish Image

Standardisasi artifact deployment diimplementasikan melalui proses build container image dan publikasi image ke registry. Dengan pendekatan ini, artifact yang akan digunakan untuk deployment memiliki bentuk yang konsisten dan dapat digunakan ulang pada environment target.

Implementasi build dan publish image mendukung pemisahan yang lebih jelas antara proses validasi perubahan dan proses deployment. Setelah image berhasil dipublikasikan, VM target tidak perlu lagi melakukan build aplikasi dari source code, melainkan cukup menggunakan artifact yang sudah tersedia.

## 6.3 Implementasi Runtime Health Checking

Implementasi runtime health checking dilakukan melalui pemisahan endpoint liveness dan readiness. Endpoint liveness digunakan untuk memastikan aplikasi masih berjalan, sedangkan endpoint readiness digunakan untuk memeriksa kesiapan layanan berdasarkan kondisi dependensi database. Pendekatan ini penting karena aplikasi yang masih hidup belum tentu dapat melayani request secara benar apabila dependensi utama sedang bermasalah.

Pada level runtime container, konfigurasi Docker Compose juga menggunakan healthcheck untuk memantau kondisi layanan. Pendekatan ini memperkuat mekanisme observasi terhadap status aplikasi pada saat deployment maupun saat pengujian skenario gangguan.

## 6.4 Implementasi Deployment Workflow

Deployment workflow diimplementasikan menggunakan Docker Compose dengan artifact image yang dapat ditentukan melalui variabel environment. Dengan model ini, layanan dapat dijalankan menggunakan image lokal maupun image yang telah dipublikasikan ke registry. Pendekatan tersebut mendukung konsistensi antara proses validasi artifact dan proses penggunaan artifact pada environment target.

Setelah deployment dilakukan, layanan diverifikasi menggunakan endpoint health check. Verifikasi ini menjadi tahapan penting karena keberhasilan deployment tidak dinilai hanya dari container yang berhasil berjalan, tetapi juga dari kondisi layanan yang benar-benar sehat.

## 6.5 Implementasi Rollback dan Runbook

Untuk mendukung recovery yang lebih konsisten, implementasi juga dilengkapi dengan runbook operasional dan prosedur rollback. Rollback dilakukan dengan kembali menggunakan image stabil sebelumnya, kemudian service dijalankan ulang dan diverifikasi melalui health endpoint. Selain itu, tersedia skenario pengujian yang dapat digunakan untuk mengamati perilaku sistem pada saat terjadi gangguan dependensi, kegagalan satu container, maupun saat rollback dijalankan.

Keberadaan runbook membantu menjadikan proses recovery lebih terdokumentasi dan lebih mudah dievaluasi. Dalam konteks penelitian, runbook juga penting karena menyediakan acuan yang konsisten saat pengumpulan data pengujian dilakukan.

## 6.6 Implementasi Infrastruktur Pendukung

Repositori juga menyediakan komponen infrastruktur pendukung untuk menyiapkan VM target. Namun, bagian ini tidak menjadi pusat implementasi penelitian. Infrastruktur pendukung cukup dijelaskan secara singkat sebagai sarana penyiapan lingkungan deployment agar pembahasan tetap terfokus pada workflow DevOps dan reliabilitas deployment.

## TODO Lanjutan

- [ ] tambahkan kutipan konfigurasi yang benar-benar akan dipakai di skripsi
- [ ] sesuaikan subbab deployment dengan alur final
- [ ] tambahkan bukti implementasi dari file repo yang paling relevan
- [ ] tentukan mana yang perlu screenshot dan mana yang cukup dijelaskan
