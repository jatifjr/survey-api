# Repo Mapping for BAB IV, BAB V, and BAB VI

Dokumen ini membantu memetakan artefak pada repositori ke isi skripsi, terutama untuk `BAB IV`, `BAB V`, dan `BAB VI`.
Tujuannya agar penulisan tidak berhenti pada teori, tetapi langsung terhubung dengan implementasi yang sudah ada.

## BAB IV - Analisis Kondisi Awal

### Fokus BAB

BAB IV menjelaskan kondisi sistem saat ini, proses operasional yang berjalan, serta kelemahan yang menjadi dasar perlunya intervensi DevOps.

### Bahan dari Repositori

#### 1. Gambaran Sistem

Gunakan:

- `README.md`
- `compose.yml`

Poin yang dapat ditulis:

- Sistem yang diteliti adalah layanan backend berbasis FastAPI.
- Layanan dijalankan dengan Docker Compose.
- Sistem memiliki komponen API, database PostgreSQL, dan reverse proxy Nginx.
- Layanan menyediakan endpoint health check untuk memantau kondisi runtime.

Kalimat arah penulisan:

> Sistem yang menjadi objek penelitian adalah layanan API berbasis FastAPI yang dijalankan pada lingkungan container. Dalam konfigurasi runtime, sistem terdiri atas komponen API, database PostgreSQL sebagai dependensi layanan, serta reverse proxy yang menjadi titik akses utama klien.

#### 2. Alur Deployment Saat Ini

Gunakan:

- `README.md`
- `ops/reliability-runbook.md`
- pengamatan aktual dari proses deployment Anda sendiri

Poin yang dapat ditulis:

- Deployment saat ini masih mengandalkan prosedur manual atau semi-manual.
- Update layanan dilakukan dengan menarik image, menjalankan `docker compose`, lalu memverifikasi endpoint.
- Rollback masih mengandalkan operator untuk memilih tag image sebelumnya dan menjalankan ulang service.

Kalimat arah penulisan:

> Sebelum workflow DevOps diterapkan secara penuh, proses deployment masih dilakukan melalui langkah operasional manual. Operator perlu memastikan image tersedia, menjalankan pembaruan layanan secara langsung pada VM, dan memverifikasi hasil deployment menggunakan endpoint health check.

#### 3. Risiko Operasional Baseline

Gunakan:

- `README.md`
- `skripsi/baseline-manual-operations.md`
- `ops/reliability-runbook.md`

Poin yang dapat ditulis:

- Tidak semua validasi perubahan terikat langsung ke alur deployment.
- Ketika deployment gagal, waktu recovery bergantung pada kecepatan operator.
- Bukti downtime, waktu recovery, dan konsistensi deployment belum terdokumentasi secara sistematis.

Kalimat arah penulisan:

> Kondisi baseline menunjukkan bahwa reliabilitas deployment belum sepenuhnya ditopang oleh mekanisme yang terstandarisasi. Risiko utama terletak pada kemungkinan perubahan yang belum tervalidasi masuk ke tahap deployment, serta belum adanya bukti terukur mengenai durasi gangguan dan efektivitas recovery.

### TODO BAB IV

- [ ] isi `skripsi/baseline-manual-operations.md` dengan langkah aktual
- [ ] catat durasi deployment manual minimal 2 sampai 3 kali percobaan
- [ ] catat bagaimana rollback dilakukan saat ini
- [ ] ambil bukti hasil `livez` dan `readyz` pada kondisi normal dan saat DB mati

## BAB V - Perancangan Workflow DevOps

### Fokus BAB

BAB V menjelaskan rancangan solusi yang diusulkan untuk mengatasi kelemahan baseline.
Yang ditekankan adalah alur kerja dan logika kontrol, bukan sekadar daftar tools.

### Bahan dari Repositori

#### 1. Rancangan Quality Gate

Gunakan:

- `.github/workflows/quality.yml`

Poin yang dapat ditulis:

- Setiap perubahan harus melewati format check, lint, dan test.
- Quality gate berfungsi sebagai kontrol awal untuk mencegah perubahan bermasalah masuk ke proses rilis.
- Mekanisme ini memindahkan deteksi masalah ke tahap sebelum deployment.

Kalimat arah penulisan:

> Untuk mengurangi risiko rilis gagal akibat perubahan yang belum tervalidasi, workflow yang diusulkan menempatkan quality gate pada tahap awal. Setiap perubahan harus lolos pemeriksaan format, lint, dan pengujian otomatis sebelum dapat dianggap layak untuk diteruskan ke tahap distribusi artifact.

#### 2. Rancangan Standardisasi Artifact

Gunakan:

- `.github/workflows/build.yml`
- `Dockerfile`
- `README.md`

Poin yang dapat ditulis:

- Artifact deployment distandarkan dalam bentuk container image.
- Image dipublikasikan ke registry sehingga deployment tidak lagi bergantung pada source build langsung di server.
- Pendekatan ini mengurangi perbedaan hasil build antar lingkungan.

Kalimat arah penulisan:

> Workflow yang diusulkan menggunakan container image sebagai artifact deployment tunggal. Dengan demikian, hasil build yang telah lolos validasi dapat didistribusikan secara konsisten ke lingkungan target tanpa perlu membangun ulang aplikasi secara langsung di sisi server.

#### 3. Rancangan Deployment Verification

Gunakan:

- `compose.yml`
- `README.md`
- `app/api/routes/health.py`
- `app/main.py`

Poin yang dapat ditulis:

- Deployment tidak hanya dinilai sukses berdasarkan container berjalan.
- Verifikasi dilakukan melalui health endpoint.
- `/livez` digunakan untuk memastikan aplikasi tetap hidup.
- `/readyz` digunakan untuk memastikan kesiapan layanan terhadap dependensi database.

Kalimat arah penulisan:

> Verifikasi deployment pada workflow usulan tidak berhenti pada status container, tetapi dilakukan melalui health endpoint. Pendekatan ini dipilih agar sistem dapat membedakan kondisi aplikasi yang masih berjalan dari kondisi layanan yang benar-benar siap menerima trafik produksi.

#### 4. Rancangan Rollback

Gunakan:

- `README.md`
- `ops/reliability-runbook.md`

Poin yang dapat ditulis:

- Rollback dirancang menggunakan image stabil sebelumnya.
- Trigger rollback dapat berasal dari health check gagal atau hasil validasi pasca-deployment yang tidak sesuai.
- Langkah rollback harus terdokumentasi dan dapat diulang.

Kalimat arah penulisan:

> Untuk menekan durasi gangguan saat rilis bermasalah, workflow usulan menyertakan prosedur rollback yang menggunakan image stabil sebelumnya sebagai titik pemulihan. Prosedur ini dirancang agar dapat dieksekusi secara konsisten dan dievaluasi waktu pemulihannya.

#### 5. Posisi Terraform

Gunakan:

- `infra/README.md`
- `README.md`

Poin yang dapat ditulis:

- Terraform tidak diposisikan sebagai inti solusi.
- Terraform hanya berperan sebagai opsi untuk menyiapkan VM target secara lebih rapi dan terulang.
- Evaluasi utama tetap berada pada deployment workflow dan reliability outcome.

Kalimat arah penulisan:

> Pada penelitian ini, provisioning infrastruktur tidak diposisikan sebagai kontribusi utama. Apabila digunakan, Terraform hanya berperan sebagai sarana pendukung untuk membantu penyiapan lingkungan target secara lebih terstruktur.

### TODO BAB V

- [ ] buat diagram workflow: commit -> CI -> build image -> deploy -> verify -> rollback bila gagal
- [ ] definisikan pemicu rollback secara eksplisit
- [ ] tentukan apakah branch `main` menjadi jalur evaluasi utama
- [ ] tentukan bentuk final deployment: manual-assisted atau semi-automated

## BAB VI - Implementasi

### Fokus BAB

BAB VI menjelaskan bagaimana rancangan pada BAB V direalisasikan dalam repositori ini.

### Bahan dari Repositori

#### 1. Implementasi Quality Gate

Gunakan:

- `.github/workflows/quality.yml`

Poin yang dapat ditulis:

- Workflow `Quality` dijalankan pada pull request dan push ke branch tertentu.
- Tahapan quality gate meliputi instalasi dependency, pemeriksaan format, lint, dan eksekusi test.
- Implementasi ini menjadi bukti bahwa validasi dilakukan sebelum rilis.

#### 2. Implementasi Build dan Publish Image

Gunakan:

- `.github/workflows/build.yml`

Poin yang dapat ditulis:

- Workflow `Build` melakukan build image dan push ke GitHub Container Registry.
- Nama image diturunkan dari repository.
- Publish image membuat artifact deployment dapat dipakai ulang pada environment target.

#### 3. Implementasi Runtime Reliability

Gunakan:

- `compose.yml`
- `app/api/routes/health.py`
- `app/main.py`
- `README.md`

Poin yang dapat ditulis:

- `compose.yml` mendefinisikan service API, database, dan proxy.
- API memiliki healthcheck internal berbasis `/v1/livez`.
- Aplikasi tetap dapat start walaupun konfigurasi database belum lengkap, namun readiness tetap menunjukkan kegagalan dependensi.
- Pendekatan ini mendukung pembedaan antara liveness dan readiness.

#### 4. Implementasi Prosedur Deployment

Gunakan:

- `README.md`
- `compose.yml`

Poin yang dapat ditulis:

- Deployment dilakukan menggunakan image yang telah tersedia.
- Variabel `API_IMAGE` dapat digunakan untuk memilih image registry.
- Deployment memanfaatkan `docker compose pull` dan `docker compose up -d`.
- Verifikasi pasca-deployment dilakukan melalui `curl` ke `livez` dan `readyz`.

#### 5. Implementasi Runbook dan Rollback

Gunakan:

- `ops/reliability-runbook.md`
- `ops/reliability-check.sh`
- `README.md`

Poin yang dapat ditulis:

- Runbook mendokumentasikan skenario gangguan utama.
- Rollback dilakukan dengan mengganti `API_IMAGE` ke tag stabil sebelumnya.
- `ops/reliability-check.sh` dapat digunakan sebagai alat bantu untuk mengukur tingkat keberhasilan request selama pengujian.

#### 6. Implementasi Pendukung Infrastruktur

Gunakan:

- `infra/README.md`
- `infra/main.tf`
- `.github/workflows/infra.yml`

Poin yang dapat ditulis:

- Implementasi provisioning infrastruktur tersedia sebagai komponen pendukung.
- Validasi Terraform dilakukan melalui workflow terpisah.
- Bagian ini cukup dijelaskan singkat karena bukan fokus utama penelitian.

### TODO BAB VI

- [ ] ambil potongan konfigurasi inti untuk dijadikan gambar atau cuplikan kode di skripsi
- [ ] tentukan artefak mana yang akan dijelaskan detail dan mana yang cukup diringkas
- [ ] siapkan urutan penjelasan implementasi agar konsisten dengan BAB V

## Recommended Writing Order

Agar pengerjaan lebih mudah, urutan penulisan yang disarankan adalah:

1. selesaikan `BAB IV` setelah baseline benar-benar diukur,
2. tulis `BAB V` berdasarkan workflow final yang ingin dipertahankan,
3. tulis `BAB VI` setelah implementasi deployment dan rollback sudah stabil.
