# BAB Outline

## BAB I - Pendahuluan

### Tujuan

Menjelaskan mengapa deployment layanan pada VM secara manual menimbulkan risiko operasional dan mengapa workflow DevOps ringan layak untuk dirancang serta dievaluasi.

### Subsections

1. Latar Belakang
2. Rumusan Masalah
3. Tujuan Penelitian
4. Manfaat Penelitian
5. Batasan Masalah
6. Sistematika Penulisan

### Catatan Penulisan

- Tekankan adanya inkonsistensi operasional, risiko deployment gagal, dan belum adanya bukti recovery yang terukur.
- Hindari pembahasan SDLC yang terlalu luas.
- Posisikan penelitian pada reliabilitas deployment dan konsistensi recovery.

### TODO

- [ ] write a concise real-world background paragraph
- [ ] define the manual-process pain points from this repo/project
- [ ] keep the scope to one service and one VM target

## BAB II - Tinjauan Pustaka

### Tujuan

Menyusun landasan teori yang mendukung rancangan intervensi dan proses evaluasi penelitian.

### Topik yang Disarankan

1. Konsep dan tujuan DevOps
2. Konsep Continuous Integration dan workflow deployment
3. Containerization dengan Docker
4. Reliabilitas layanan, availability, dan MTTR
5. Health check: liveness dan readiness
6. Rollback dan runbook operasional
7. Penelitian terkait DevOps ringan pada sistem skala kecil

### Catatan Penulisan

- Pastikan pustaka yang dipilih relevan dengan implementasi nyata pada repositori.
- Jangan memberi porsi berlebih pada Terraform jika bukan kontribusi utama.
- Prioritaskan referensi yang mendukung evaluasi reliabilitas dan workflow deployment.

### TODO

- [ ] collect references for DevOps, CI, MTTR, availability, and health probes
- [ ] find 3 to 5 related studies close to VM/Docker/small-service deployment
- [ ] prepare a comparison table of related work

## BAB III - Metodologi Penelitian

### Tujuan

Menjelaskan bagaimana penelitian dilakukan dan bagaimana peningkatan yang dihasilkan akan diukur.

### Subsections

1. Jenis dan pendekatan penelitian
2. Objek penelitian
3. Tahapan penelitian
4. Variabel penelitian
5. Skenario pengujian
6. Teknik pengumpulan data
7. Teknik analisis data

### Catatan Penulisan

- Gunakan pendekatan studi kasus dengan perbandingan sebelum dan sesudah intervensi.
- Definisikan kondisi baseline dan intervensi secara jelas.
- Tunjukkan keterkaitan antara setiap skenario pengujian dengan pertanyaan penelitian.

### TODO

- [ ] finalize baseline description
- [ ] finalize intervention workflow description
- [ ] finalize KPI definitions and formulas
- [ ] define evidence sources for each scenario

## BAB IV - Analisis Kondisi Awal

### Tujuan

Menjelaskan kondisi sistem saat ini, alur operasional manual, serta kelemahan baseline sebelum workflow DevOps diterapkan.

### Subsections

1. Gambaran sistem yang diteliti
2. Alur deployment saat ini
3. Risiko operasional pada proses manual
4. Hasil pengukuran baseline

### Catatan Penulisan

- BAB ini harus membuat masalah penelitian terlihat konkret.
- Gunakan catatan baseline, durasi aktual, dan pain point yang benar-benar terjadi.
- Jelaskan titik rawan kegagalan dan alasan penanganannya masih belum konsisten.

### TODO

- [ ] document current deployment/update sequence
- [ ] record baseline downtime and recovery behavior
- [ ] identify which steps depend heavily on operator judgment

## BAB V - Perancangan Workflow DevOps

### Tujuan

Menyajikan rancangan solusi yang diusulkan untuk mengatasi kelemahan pada kondisi baseline.

### Subsections

1. Tujuan perancangan
2. Arsitektur workflow usulan
3. Rancangan quality gate
4. Rancangan artifact build and registry flow
5. Rancangan deployment verification
6. Rancangan rollback procedure

### Catatan Penulisan

- Fokuskan pembahasan pada logika workflow, bukan sekadar daftar tools.
- Jelaskan fungsi setiap komponen dan bagaimana komponen tersebut mengurangi risiko operasional.
- Terraform cukup disebut sebagai penyiapan lingkungan pendukung bila diperlukan.

### TODO

- [ ] draw the proposed workflow diagram
- [ ] define the release/deploy sequence
- [ ] define post-deploy validation checks
- [ ] define rollback trigger and rollback steps

## BAB VI - Implementasi

### Tujuan

Menunjukkan bagaimana rancangan pada BAB V diwujudkan pada repositori dan lingkungan deployment.

### Subsections

1. Implementasi quality gate
2. Implementasi image build and registry publication
3. Implementasi runtime health checking
4. Implementasi deployment workflow
5. Implementasi rollback/runbook
6. Implementasi supporting environment setup

### Catatan Penulisan

- Hubungkan setiap implementasi dengan rancangan pada BAB V.
- Jaga penjelasan tetap konkret dan berbasis artefak di repositori.
- Penyiapan infrastruktur pendukung tetap bersifat sekunder.

### TODO

- [ ] confirm final deployment implementation path
- [ ] collect screenshots/log snippets only if needed
- [ ] record which files/artifacts prove each implementation piece

## BAB VII - Pengujian dan Evaluasi

### Tujuan

Menunjukkan apakah intervensi yang diusulkan benar-benar meningkatkan reliabilitas deployment dan perilaku recovery.

### Subsections

1. Skenario pengujian
2. Hasil pengujian baseline
3. Hasil pengujian setelah intervensi
4. Perbandingan KPI
5. Analisis hasil
6. Ancaman terhadap validitas

### Catatan Penulisan

- Utamakan bukti objektif dan tabel perbandingan.
- Bahas peningkatan yang diperoleh sekaligus keterbatasan yang masih tersisa.
- Jadikan pengujian replica opsional sebagai bukti pendukung, bukan hasil utama.

### TODO

- [ ] execute all required scenarios
- [ ] fill KPI comparison tables
- [ ] explain why each metric improved or did not improve
- [ ] write threats to validity honestly

## BAB VIII - Kesimpulan dan Saran

### Tujuan

Menjawab pertanyaan penelitian secara langsung dan merangkum nilai praktis dari hasil penelitian.

### Subsections

1. Kesimpulan
2. Keterbatasan
3. Saran pengembangan

### Catatan Penulisan

- Setiap kesimpulan harus mengarah kembali ke pertanyaan penelitian.
- Jangan membuat klaim yang melampaui bukti yang tersedia.
- Jaga saran pengembangan tetap realistis dan tidak memperluas ruang lingkup penelitian.

### TODO

- [ ] answer each research question in one direct paragraph
- [ ] list the main limitations of scale and environment
- [ ] write future work without expanding the thesis scope
