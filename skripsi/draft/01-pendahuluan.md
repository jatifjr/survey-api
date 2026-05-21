# BAB I - Pendahuluan

## Status

Draft awal dengan isi yang sudah dapat dikembangkan menjadi versi penulisan formal.

## Judul Penelitian

**Perancangan dan Evaluasi Workflow DevOps Ringan untuk Meningkatkan Reliabilitas Layanan FastAPI pada Deployment Berbasis Docker**

## 1.1 Latar Belakang

Perkembangan layanan backend berbasis API mendorong kebutuhan akan proses deployment yang semakin andal, konsisten, dan mudah dipulihkan ketika terjadi gangguan. Pada praktiknya, banyak sistem skala kecil hingga menengah masih dioperasikan pada virtual machine dengan proses deployment yang dilakukan secara manual atau semi-manual. Pendekatan ini umumnya masih bergantung pada ketelitian operator untuk melakukan validasi perubahan, pembaruan layanan, pemeriksaan kondisi sistem, serta rollback ketika deployment mengalami kegagalan.

Ketergantungan pada langkah manual dapat menimbulkan sejumlah permasalahan operasional. Proses deployment yang tidak terstandarisasi berpotensi menyebabkan inkonsistensi antar rilis, meningkatkan risiko kesalahan operasional, dan memperpanjang waktu pemulihan layanan. Selain itu, ketika terjadi gangguan pada dependensi atau rilis bermasalah, proses recovery sering kali tidak memiliki prosedur baku yang terdokumentasi dengan baik. Akibatnya, klaim mengenai peningkatan reliabilitas layanan menjadi sulit dibuktikan secara objektif.

Dalam konteks tersebut, pendekatan DevOps dapat digunakan untuk meningkatkan kualitas dan konsistensi proses deployment. Melalui quality gate otomatis, standardisasi artifact berbasis container image, verifikasi health service, serta prosedur rollback yang terdokumentasi, proses deployment dapat dibuat lebih terukur dan lebih siap menghadapi gangguan operasional. Untuk layanan berbasis VM dengan skala yang relatif sederhana, pendekatan workflow DevOps ringan menjadi relevan karena dapat diterapkan tanpa memerlukan platform orkestrasi yang kompleks.

Penelitian ini menggunakan layanan FastAPI sebagai objek kajian. Layanan dijalankan menggunakan Docker pada VM dan dilengkapi dengan mekanisme health check untuk membedakan kondisi liveness dan readiness. Fokus penelitian diarahkan pada perancangan dan evaluasi workflow DevOps ringan untuk meningkatkan reliabilitas deployment dan konsistensi recovery. Dengan demikian, hasil penelitian diharapkan dapat memberikan kontribusi praktis bagi penerapan DevOps pada layanan backend skala kecil yang masih mengandalkan lingkungan VM.

## 1.2 Rumusan Masalah

1. Bagaimana merancang workflow DevOps ringan untuk layanan FastAPI berbasis VM agar mendukung proses deployment dan recovery yang lebih andal?
2. Bagaimana pengaruh workflow DevOps yang diusulkan terhadap reliabilitas operasional dibandingkan dengan pendekatan deployment manual sebelumnya?
3. Seberapa efektif workflow yang diusulkan ketika dievaluasi melalui skenario gangguan terkontrol, seperti outage dependensi, rilis gagal, dan interupsi layanan?

## 1.3 Tujuan Penelitian

1. Merancang workflow DevOps ringan yang mencakup validasi perubahan, distribusi image, deployment, verifikasi health service, dan rollback.
2. Mengimplementasikan workflow tersebut pada satu layanan FastAPI yang dideploy menggunakan Docker pada VM.
3. Mengevaluasi workflow menggunakan indikator reliabilitas terukur seperti availability, durasi gangguan, dan MTTR.

## 1.4 Manfaat Penelitian

### Manfaat Teoritis

- Menambah referensi mengenai penerapan DevOps ringan pada layanan backend berbasis VM.
- Memberikan gambaran evaluasi reliabilitas deployment dengan pendekatan before-vs-after.

### Manfaat Praktis

- Menyediakan workflow deployment yang lebih terstandarisasi.
- Membantu memperjelas proses validasi, deployment, dan rollback pada layanan yang diteliti.
- Menyediakan bukti terukur mengenai peningkatan reliabilitas operasional.

## 1.5 Batasan Masalah

- Penelitian difokuskan pada satu layanan mikro berbasis FastAPI.
- Deployment dijalankan pada satu VM menggunakan Docker/Compose.
- Fokus utama adalah reliabilitas deployment dan konsistensi recovery.
- Terraform atau provisioning infrastruktur hanya menjadi cakupan pendukung.
- Penelitian tidak membahas Kubernetes, arsitektur multi-region, dan compliance/security tingkat lanjut sebagai fokus utama.

## 1.6 Sistematika Penulisan

- BAB I Pendahuluan
- BAB II Tinjauan Pustaka
- BAB III Metodologi Penelitian
- BAB IV Analisis Kondisi Awal
- BAB V Perancangan Workflow DevOps
- BAB VI Implementasi
- BAB VII Pengujian dan Evaluasi
- BAB VIII Kesimpulan dan Saran

## TODO Lanjutan

- sesuaikan latar belakang dengan gaya bahasa kampus
- tambahkan konteks organisasi atau proyek jika perlu
- pastikan istilah asing mengikuti aturan penulisan kampus
