# Hack My Win — Life Hack Windows untuk Laptop Low‑Spec

Cerita dan kumpulan skrip optimasi Windows yang saya pakai sejak era laptop Intel Celeron dan dilanjutkan i3 gen 7 untuk kebutuhan programming. Repositori ini mendokumentasikan pendekatan "aman" (direkomendasikan) dan menyimpan jejak eksperimen "ekstrem" masa lalu untuk keperluan referensi.

> PERINGATAN: Beberapa skrip (profil ekstrem) mematikan Windows Update/Defender, memblokir domain Microsoft, bahkan me-rename DLL sistem. Gunakan hanya di VM/lab. Risiko: hilang update keamanan, kerentanan, sistem tidak stabil, sulit rollback. Backup dulu.

## Profil

1. Profil Aman (Direkomendasikan)

- [W10_dev_performance_safe.bat](file:///c:/Hack~MyWin/scripts/W10_dev_performance_safe.bat)
- Fokus: tweak konservatif yang reversible untuk developer
- Menjaga: Windows Update, Defender, Windows Search
- Tweak: power plan High Performance, tampilkan file extensions/hidden files, telemetry Basic, disable CEIP tasks, kurangi suggestion/ads

2. Profil Ekstrem (Warisan/Eksperimen)

- [W10b0sstT0MM11Y.bat](file:///c:/Hack~MyWin/W10b0sstT0MM11Y.bat)
- Fokus: memeras performa di hardware sangat lemah (disable layanan/tasks, hapus bloat, blokir domain update, utak‑atik registry)
- Dampak: terasa lebih enteng, tetapi mematikan update/Defender, rename DLL `wu*`, memblokir domain Microsoft, dan menonaktifkan layanan penting (Themes/Spooler/Search). Tidak disarankan untuk penggunaan harian di 2025

## Struktur Repo (Ringkas)

- scripts/ — kumpulan skrip PowerShell/batch pendukung (lihat daftar di bawah)
- [W10b0sstT0MM11Y.bat](file:///c:/Hack~MyWin/W10b0sstT0MM11Y.bat) — entrypoint profil ekstrem
- [W10_dev_performance_safe.bat](file:///c:/Hack~MyWin/scripts/W10_dev_performance_safe.bat) — entrypoint profil aman
- Activation/ — arsip alat aktivasi (opsional). Lihat: [ActivationW~OfficeT0mm11y.zip](file:///c:/Hack~MyWin/Activation/ActivationW~OfficeT0mm11y.zip)
  - Catatan penting: folder ini disediakan apa adanya untuk lingkungan lab/arsip. Beberapa alat pihak ketiga dapat digunakan untuk mengelola/menyelesaikan aktivasi Windows dan Office. Gunakan hanya untuk lisensi yang sah dan patuhi hukum setempat. Tidak ada instruksi aktivasi di README ini, dan penggunaan untuk membajak perangkat lunak tidak didukung

## Skrip dan Fungsi

- [block-telemetry.ps1](file:///c:/Hack~MyWin/scripts/block-telemetry.ps1) — Blokir domain telemetry via hosts dan IP via firewall. Dapat mengganggu Store/Skype/DRM
- [disable-services.ps1](file:///c:/Hack~MyWin/scripts/disable-services.ps1) — Nonaktifkan layanan tidak penting (DiagTrack, dmwappushservice, Xbox, dll.). Hemat RAM/CPU, perlu seleksi
- [disable-windows-defender.ps1](file:///c:/Hack~MyWin/scripts/disable-windows-defender.ps1) — Mematikan Defender (tasks + services). Risiko keamanan tinggi
- [experimental_unfuckery.ps1](file:///c:/Hack~MyWin/scripts/experimental_unfuckery.ps1) — Hapus komponen sistem tertentu. Sangat berisiko. Untuk eksperimen saja
- [fix-privacy-settings.ps1](file:///c:/Hack~MyWin/scripts/fix-privacy-settings.ps1) — Setelan privasi: matikan web search, advertising ID, background access apps, dsb
- [optimize-user-interface.ps1](file:///c:/Hack~MyWin/scripts/optimize-user-interface.ps1) — UI/UX ringan: MarkC mouse fix, nonaktif Game DVR, folder options, kecilkan notifikasi
- [optimize-windows-update.ps1](file:///c:/Hack~MyWin/scripts/optimize-windows-update.ps1) — Jadikan Windows Update lebih jinak (notify/DO). Tidak mematikan update
- [remove-default-apps.ps1](file:///c:/Hack~MyWin/scripts/remove-default-apps.ps1) — Hapus aplikasi bawaan/Store tertentu. Hemat bloat, gunakan whitelist
- [remove-onedrive.ps1](file:///c:/Hack~MyWin/scripts/remove-onedrive.ps1) — Copot OneDrive + hilangkan integrasi Explorer. Kurangi background sync

## Cara Pakai (Singkat)

Sebelum menjalankan skrip PowerShell, aktifkan eksekusi skrip (user scope) dan unblock modul di repo ini:

```powershell
PS> Set-ExecutionPolicy Unrestricted -Scope CurrentUser
```

```powershell
PS> ls -Recurse *.ps*1 | Unblock-File
```

- Jalankan terminal sebagai Administrator
- Mulai dari skrip aman: [W10_dev_performance_safe.bat](file:///c:/Hack~MyWin/scripts/W10_dev_performance_safe.bat)
- Hindari menjalankan skrip ekstrem di mesin utama. Jika perlu uji, pakai VM dan snapshot dulu

## Rollback dan Recovery

- Profil Aman: perubahan ringan dan reversible (Explorer/ContentDelivery/telemetry Basic). Bisa kembalikan manual atau via Policy Editor
- Profil Ekstrem: rollback sulit. Opsi: System Restore (jika aktif), SFC/DISM (`sfc /scannow`, `DISM /Online /Cleanup-Image /RestoreHealth`), cek layanan penting ( Themes, Spooler, WSearch, BITS, wuauserv) dan set kembali StartupType ke Automatic/Manual, pulihkan file/hosts asli. Sangat disarankan di VM

## Kompatibilitas

Diuji pada Windows 10 Pro 21H1 (Build 19043). Variasi build dapat memberi hasil berbeda

## Lisensi

MIT. Gunakan dengan risiko Anda sendiri. Tidak ada garansi
