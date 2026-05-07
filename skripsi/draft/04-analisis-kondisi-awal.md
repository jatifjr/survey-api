# BAB IV - Analisis Kondisi Awal

## Status

Draft kerja. BAB ini sudah memiliki narasi awal, tetapi masih harus dilengkapi dengan data baseline nyata agar analisis kondisi awal tidak bersifat asumtif.

## Arah Penulisan

BAB ini harus menunjukkan alasan mengapa intervensi DevOps diperlukan. Karena itu, bagian ini perlu menonjolkan kondisi operasional aktual, titik rawan kegagalan, dan kelemahan pada proses deployment sebelum intervensi diterapkan.

## 4.1 Gambaran Sistem yang Diteliti

Sistem yang menjadi objek penelitian adalah layanan backend berbasis FastAPI yang dijalankan pada lingkungan container. Dalam konfigurasi runtime, sistem terdiri atas komponen API, database PostgreSQL sebagai dependensi layanan, serta reverse proxy yang menjadi titik akses utama klien. Pendekatan ini digunakan untuk merepresentasikan arsitektur layanan backend skala kecil yang umum dijalankan pada VM.

Layanan menyediakan endpoint health check yang dibedakan menjadi liveness dan readiness. Endpoint liveness digunakan untuk mengetahui apakah proses aplikasi masih berjalan, sedangkan endpoint readiness digunakan untuk mengamati kesiapan layanan dalam melayani request dengan mempertimbangkan kondisi dependensinya. Pemisahan ini menjadi penting karena kondisi aplikasi yang masih aktif belum tentu berarti layanan siap digunakan secara penuh.

## 4.2 Alur Deployment Saat Ini

Sebelum intervensi workflow DevOps diterapkan secara penuh, proses deployment masih dilakukan dengan langkah operasional manual atau semi-manual. Operator perlu memastikan artifact tersedia, menjalankan pembaruan service melalui Docker Compose, kemudian memverifikasi hasil deployment menggunakan endpoint health check. Pada kondisi tertentu, operator juga perlu melakukan pemilihan image yang akan dijalankan secara eksplisit.

Secara umum, alur deployment saat ini masih menempatkan operator sebagai pengendali utama pada hampir seluruh tahapan. Operator bertanggung jawab untuk menentukan kapan deployment dijalankan, bagaimana validasi dilakukan, dan kapan rollback perlu dilakukan jika terjadi masalah. Kondisi ini menunjukkan bahwa keberhasilan deployment masih sangat dipengaruhi oleh ketelitian dan pengalaman operator.

## 4.3 Risiko Operasional pada Proses Manual

Pendekatan manual menimbulkan beberapa risiko operasional. Pertama, validasi kualitas perubahan belum sepenuhnya terikat ke proses rollout sehingga terdapat kemungkinan perubahan bermasalah tetap masuk ke tahap deployment. Kedua, prosedur recovery masih berpotensi berbeda-beda tergantung keputusan operator, sehingga waktu pemulihan dapat tidak konsisten. Ketiga, bukti mengenai downtime, durasi deployment, dan MTTR belum terdokumentasi secara sistematis sehingga sulit digunakan untuk mengevaluasi reliabilitas deployment secara objektif.

Selain itu, keberhasilan deployment tidak cukup dinilai hanya dari container yang aktif. Tanpa verifikasi health yang konsisten, layanan dapat terlihat berjalan namun sebenarnya belum siap menerima request secara normal. Oleh karena itu, kondisi awal ini menunjukkan perlunya workflow yang dapat mengintegrasikan quality gate, standardisasi artifact, health verification, dan rollback ke dalam satu alur operasional yang lebih baku.

## 4.4 Hasil Pengukuran Baseline

Bagian ini diisi setelah pengukuran baseline dilakukan.

Hal yang perlu dimasukkan:

- durasi deployment manual,
- ada atau tidaknya downtime,
- langkah rollback yang dilakukan,
- hasil `livez` dan `readyz`,
- catatan gangguan jika deployment tidak berjalan mulus.

## TODO Lanjutan

- [ ] isi langkah deployment aktual dari kondisi sekarang
- [ ] tambahkan data baseline dari `skripsi/baseline-manual-operations.md`
- [ ] masukkan bukti durasi deployment dan recovery
- [ ] sesuaikan isi dengan kondisi operasional yang benar-benar Anda lakukan
