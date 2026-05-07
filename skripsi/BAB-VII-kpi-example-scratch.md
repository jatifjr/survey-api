## BAB VII KPI Example (Dummy Data)

Use this as a writing reference only. Replace all numbers with your real measurements.

### Contoh Tabel 7.3 Perbandingan KPI

| KPI | Baseline | Pasca-Intervensi | Improvement |
|---|---:|---:|---:|
| Availability pada window uji (%) | 96.20 | 99.10 | +3.01% |
| MTTR (menit) | 12.40 | 4.10 | +66.94% |
| Durasi deployment (menit) | 9.30 | 3.80 | +59.14% |
| Durasi recovery rilis gagal (menit) | 11.20 | 4.60 | +58.93% |
| CI success rate (%) | 72.00 | 91.00 | +26.39% |
| Success rate saat gangguan (%) | 88.00 | 98.00 | +11.36% |

### Keterangan Rumus

- Metrik yang semakin besar semakin baik:
  - `((after - baseline) / baseline) * 100`
- Metrik yang semakin kecil semakin baik:
  - `((baseline - after) / baseline) * 100`

### Contoh Narasi Analisis Singkat

Hasil perbandingan menunjukkan adanya peningkatan pada metrik reliabilitas utama setelah workflow DevOps ringan diterapkan. Nilai availability meningkat dari 96.20% menjadi 99.10%, sementara MTTR menurun dari 12.40 menit menjadi 4.10 menit. Penurunan MTTR ini menunjukkan bahwa proses recovery pasca-kegagalan menjadi lebih cepat dan lebih konsisten dibandingkan pendekatan baseline manual.

Selain itu, durasi deployment dan durasi recovery rilis gagal juga mengalami perbaikan signifikan. Perbaikan ini didukung oleh penggunaan quality gate, standardisasi artifact image, serta prosedur verifikasi dan rollback yang lebih terstruktur.

### Cara Mapping Output Calculator ke Tabel 7.3

Gunakan output dari `skripsi/kpi-calculator-scratch.py` seperti berikut:

- `Availability improvement (%)` -> kolom **Improvement** pada baris *Availability pada window uji (%)*.
- `MTTR improvement (%)` -> kolom **Improvement** pada baris *MTTR (menit)*.
- `Deployment duration improvement (%)` -> kolom **Improvement** pada baris *Durasi deployment (menit)*.
- `Rollback recovery improvement (%)` -> kolom **Improvement** pada baris *Durasi recovery rilis gagal (menit)*.
- `CI success rate improvement (%)` -> kolom **Improvement** pada baris *CI success rate (%)*.
- `Failure scenario success-rate improvement (%)` -> kolom **Improvement** pada baris *Success rate saat gangguan (%)*.

Cara isi per baris:

1. Isi kolom **Baseline** dari hasil baseline nyata.
2. Isi kolom **Pasca-Intervensi** dari hasil setelah workflow DevOps diterapkan.
3. Isi kolom **Improvement** dari output calculator (dibulatkan 2 desimal).

Contoh format penulisan:

- Jika naik dan metrik lebih baik saat naik: `+3.01%`
- Jika turun dan metrik lebih baik saat turun (misalnya MTTR): tetap tulis sebagai peningkatan, contoh `+66.94%`.
- Jika hasil memburuk: tulis nilai negatif, contoh `-5.20%`, lalu jelaskan penyebab pada bagian analisis.
