# BAB V - Perancangan Workflow DevOps

## Status

Draft awal yang sudah cukup dekat ke arah final, tetapi masih perlu disesuaikan dengan deployment path yang benar-benar dipakai.

## Arah Penulisan

BAB ini sebaiknya menjelaskan logika rancangan secara berurutan: masalah baseline, kebutuhan kontrol, alur yang diusulkan, lalu alasan setiap komponen dipilih. Fokus utamanya adalah rancangan workflow, bukan daftar tools.

## 5.1 Tujuan Perancangan

Perancangan workflow DevOps pada penelitian ini ditujukan untuk mengurangi kelemahan operasional pada kondisi baseline, khususnya inkonsistensi deployment, keterlambatan deteksi masalah, dan belum bakunya prosedur recovery. Workflow yang dirancang tidak ditujukan untuk membangun platform DevOps berskala besar, tetapi untuk menghasilkan alur kerja yang ringan, realistis, dan sesuai untuk satu layanan backend yang berjalan pada VM.

## 5.2 Arsitektur Workflow Usulan

Secara umum, workflow yang diusulkan terdiri atas beberapa tahapan utama, yaitu validasi perubahan, build artifact, distribusi image, deployment layanan, verifikasi health service, dan rollback jika diperlukan. Alur ini dirancang agar setiap perubahan melewati kontrol kualitas sebelum masuk ke tahap operasional, sementara hasil deployment diverifikasi menggunakan indikator kesehatan layanan.

Alur sederhananya dapat dituliskan sebagai berikut:

1. perubahan kode diajukan,
2. quality gate dijalankan,
3. image dibangun dan dipublikasikan,
4. layanan diperbarui pada VM,
5. kondisi layanan diverifikasi,
6. rollback dilakukan bila hasil deployment tidak memenuhi kondisi sehat.

## 5.3 Rancangan Quality Gate

Quality gate dirancang sebagai kontrol awal untuk memastikan bahwa perubahan yang akan dirilis telah melewati pemeriksaan format, lint, dan pengujian otomatis. Dengan adanya quality gate, proses identifikasi masalah dipindahkan ke tahap sebelum deployment sehingga risiko rilis gagal dapat dikurangi.

Pada penelitian ini, quality gate juga berfungsi sebagai batas yang jelas antara perubahan yang belum siap rilis dan artifact yang layak dipublikasikan. Dengan demikian, deployment tidak lagi hanya bergantung pada penilaian manual operator terhadap source code.

## 5.4 Rancangan Artifact Build dan Registry Flow

Artifact deployment pada workflow usulan distandarkan dalam bentuk container image. Pemilihan container image sebagai artifact utama dilakukan agar hasil build yang sama dapat digunakan kembali secara konsisten pada lingkungan target. Pendekatan ini juga mengurangi kebutuhan build ulang langsung di server deployment, yang berpotensi menghasilkan perbedaan konfigurasi atau hasil eksekusi.

Image yang telah dibangun dipublikasikan ke registry agar dapat diambil oleh environment target. Dengan model ini, deployment pada VM difokuskan pada penggunaan artifact yang sudah tervalidasi, bukan pada proses kompilasi atau build aplikasi secara langsung.

## 5.5 Rancangan Deployment Verification

Verifikasi deployment dirancang menggunakan dua indikator, yaitu liveness dan readiness. Pendekatan ini dipilih karena status container aktif saja belum cukup untuk menyatakan bahwa layanan siap digunakan. Liveness digunakan untuk mengamati apakah proses aplikasi masih hidup, sedangkan readiness digunakan untuk memastikan layanan benar-benar siap menerima request dengan mempertimbangkan ketersediaan dependensi.

Dengan rancangan ini, hasil deployment dapat diklasifikasikan secara lebih akurat. Aplikasi dapat tetap dinyatakan hidup walaupun dependensi database sedang tidak tersedia, tetapi sistem tetap mampu menandai bahwa layanan belum siap melayani trafik normal.

## 5.6 Rancangan Rollback Procedure

Untuk mengurangi durasi gangguan saat rilis gagal, workflow usulan menyertakan prosedur rollback berbasis image stabil sebelumnya. Rollback dirancang agar dapat dijalankan dengan langkah yang terdokumentasi dan dapat diulang. Trigger rollback dapat berasal dari hasil health check yang tidak sesuai, validasi pasca-deployment yang gagal, atau temuan operasional lain yang menunjukkan bahwa rilis baru tidak layak dipertahankan.

Keberadaan rollback procedure menjadi bagian penting dari workflow karena fokus penelitian tidak hanya pada keberhasilan deployment, tetapi juga pada kemampuan sistem untuk kembali ke kondisi stabil dalam waktu yang terukur.

## 5.7 Posisi Infrastruktur Pendukung

Penyiapan infrastruktur, termasuk Terraform jika digunakan, tidak ditempatkan sebagai inti dari workflow yang diteliti. Infrastruktur pendukung hanya berfungsi untuk menyediakan lingkungan target yang lebih rapi dan konsisten. Evaluasi utama tetap berfokus pada alur deployment, verifikasi layanan, dan efektivitas recovery.

## TODO Lanjutan

- [ ] tambahkan diagram workflow
- [ ] finalkan jalur deploy yang benar-benar akan dipakai
- [ ] tulis trigger rollback secara lebih eksplisit
- [ ] tambahkan penjelasan singkat alasan tidak memilih Kubernetes
