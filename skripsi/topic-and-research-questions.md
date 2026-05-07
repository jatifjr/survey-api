# Topic and Research Questions

## Locked Title

**Perancangan dan Evaluasi Workflow DevOps Ringan untuk Meningkatkan Reliabilitas Deployment Layanan FastAPI pada VM Berbasis Docker**

## Short English Working Title

**Design and Evaluation of a Lightweight DevOps Workflow to Improve Deployment Reliability of a Docker-Based FastAPI Service on a VM**

## Positioning of the Topic

Topik skripsi ini **tidak** diarahkan pada transformasi SDLC secara menyeluruh dan **tidak** menempatkan Terraform sebagai kontribusi utama.
Fokus utama penelitian adalah **workflow DevOps ringan** yang ditujukan untuk meningkatkan reliabilitas deployment dan konsistensi proses pemulihan layanan pada satu sistem backend.

Terraform atau tooling infrastruktur lain tetap dapat digunakan, namun hanya diposisikan sebagai **cakupan pendukung** untuk menyiapkan lingkungan VM target.

## Draft Background

Banyak tim pengembang skala kecil masih melakukan deployment layanan backend ke virtual machine menggunakan langkah-langkah operasional yang bersifat manual.
Pada pendekatan tersebut, proses validasi kode, distribusi image, pembaruan layanan, verifikasi kesehatan layanan, dan rollback sering kali bergantung pada ketelitian operator, bukan pada alur kerja yang terstandarisasi.
Kondisi ini berpotensi menimbulkan inkonsistensi deployment, memperpanjang waktu pemulihan saat terjadi gangguan, serta menyulitkan pembuktian peningkatan reliabilitas secara objektif.

Penerapan praktik DevOps seperti quality gate otomatis, standardisasi artifact berbasis container image, verifikasi runtime berbasis health check, dan prosedur rollback yang terdokumentasi dapat meningkatkan konsistensi operasional tanpa memerlukan orkestrasi yang kompleks seperti Kubernetes.
Untuk layanan skala kecil yang dijalankan pada satu VM, pendekatan workflow DevOps ringan dinilai lebih realistis, terjangkau, dan mudah dievaluasi.

## Problem Formulation

- Proses deployment dan pemulihan layanan pada VM masih rentan terhadap inkonsistensi karena bergantung pada langkah manual.
- Proses validasi sebelum deployment belum sepenuhnya terintegrasi dengan alur operasional deployment, sehingga meningkatkan risiko rilis gagal.
- Prosedur rollback dan recovery dapat dilakukan, tetapi belum terdokumentasi secara baku dan belum diukur efektivitasnya.
- Klaim peningkatan reliabilitas perlu didukung oleh bukti terukur, seperti availability, durasi gangguan, dan Mean Time to Restore (MTTR).

## Research Questions

1. Bagaimana merancang workflow DevOps ringan untuk layanan FastAPI berbasis VM agar mendukung proses deployment dan recovery yang lebih andal?
2. Bagaimana pengaruh workflow DevOps yang diusulkan terhadap reliabilitas operasional dibandingkan dengan pendekatan deployment manual sebelumnya?
3. Seberapa efektif workflow yang diusulkan ketika dievaluasi melalui skenario gangguan terkontrol, seperti outage dependensi, rilis gagal, dan interupsi layanan?

## Research Objectives

- Merancang workflow DevOps ringan yang mencakup validasi perubahan, distribusi image, deployment, verifikasi health service, dan rollback.
- Mengimplementasikan workflow tersebut pada satu layanan FastAPI yang dideploy menggunakan Docker pada VM.
- Mengevaluasi workflow menggunakan indikator reliabilitas terukur seperti availability, durasi gangguan, dan MTTR.

## Intended Contribution

Kontribusi yang ditargetkan dalam penelitian ini adalah:

1. menghasilkan workflow DevOps praktis yang sesuai untuk layanan skala kecil berbasis VM,
2. menyusun prosedur deployment dan rollback yang terstandarisasi, dan
3. menyajikan evaluasi berbasis bukti terhadap peningkatan reliabilitas setelah workflow diterapkan.

## Scope Boundaries

- Penelitian difokuskan pada satu layanan mikro berbasis FastAPI.
- Target deployment dibatasi pada satu VM dengan runtime Docker/Compose.
- Fokus utama penelitian adalah reliabilitas deployment dan konsistensi proses recovery.
- Intervensi utama meliputi quality check CI, build/publish image, validasi runtime berbasis health endpoint, serta prosedur rollback.
- Terraform atau provisioning infrastruktur hanya diposisikan sebagai cakupan pendukung.
- Penelitian tidak mencakup Kubernetes, arsitektur multi-region, full GitOps, maupun program keamanan/compliance tingkat lanjut sebagai fokus utama.
