# <h1 align="center">HasBogor(Mobile)</h1>

<p align="center">
    <img src="logo.png" alt="HasBogor" width="300"> 
</p>

## Anggota Kelompok & Pembagian Tugas
- **Akmal Nabil Fikri** - 2306152084 (Promo)
- **Rebecca Zaneta Octoria Hutajulu** - 2306275065 (Wishlist)
- **Michael Ignasius** - 2306259950 (Inventory Management)
- **Ivan Jehuda Angi** - 2306152222 (Kategori)
- **Ismail Yanuar Anwas** - 2306245781 (Ulasan)
- **Widya Mutia Ichsan** - 2306165912 (Pembayaran)

## Table of Contents
- [Deskripsi Aplikasi](#deskripsi-aplikasi)
- [Daftar Modul yang Akan Diimplementasikan](#daftar-modul-yang-akan-diimplementasikan)
- [Alur Pengintegrasian dengan Web Service](#alur-pengitegrasian-dengan-web-service)
---
## Deskripsi Aplikasi
**HasBogor** adalah sebuah aplikasi berbasis web yang bertujuan untuk memenuhi kebutuhan wisatawan dan masyarakat dalam menemukan produk oleh-oleh khas Bogor dengan lebih mudah dan efisien. Aplikasi ini menyediakan pusat informasi dan transaksi untuk oleh-oleh khas Bogor, termasuk makanan khas, kerajinan tangan, dan banyak lagi. Pengguna dapat memesan produk secara <i>online</i> serta berinteraksi dengan komunitas melalui ulasan dan rekomendasi produk. Aplikasi ini berawal ketika sekelompok pelajar yang berkunjung ke Bogor ingin mencari sesuatu untuk mengenang pengalaman mereka. Setelah sepakat untuk mencari beberapa oleh-oleh yang dapat dibawa kembali, mereka menemukan sebuah masalah, tidak ada toko terdekat yang menjual oleh-oleh di daerah mereka saat itu. Setelah berputar dan mengunjungi area sekitar, mereka akhirnya menemukan toko cendera mata yang mereka cari. Mengingat pengalaman tersebut, mereka memutuskan untuk membuat sebuah aplikasi yang akan membantu wisatawan lainnya dalam menemukan toko oleh-oleh terdekat sekaligus dapat memesan secara <i>online</i>.

### Fungsi Aplikasi
- Mendukung pengrajin lokal dalam menjual produk mereka.
- Meningkatkan akses wisatawan ke produk-produk khas Bogor.
- Mempermudah transaksi dan memperkaya pengalaman belanja oleh-oleh.
- Meningkatkan volume transaksi oleh-oleh di Kota Bogor.
---
## Daftar Modul yang Akan Diimplementasikan


| **Modul**            | **Deskripsi**                                                                            | **Pembagian Kerja**              |
|----------------------|------------------------------------------------------------------------------------------|-----------------------------------|
| Autentikasi          | Mengelola login dan registrasi pengguna, termasuk pengelolaan password.                  | Michael Ignasius & Widya Mutia               |
| Produk               | Menampilkan daftar produk, detail produk, dan fitur pencarian.                           | Michael Ignasius              |
| Wishlist             | Menyimpan produk yang ditambahkan ke keranjang.                                          | Rebecca Zaneta             |
| Ulasan               | Modul ulasan merupakan layanan untuk user memberikan feedback, deskripsi, saran, dan kritik terhadap produk yang tersedia di website..                                 | Ismail Yanuar Anwas               |
| Promo                | Mengolah dan menampilkan promo dan diskon.                                               | Akmal Nabil Fikri               |
| Katalog         | Memberikan rekomendasi berupa fitur katalog produk kepada pengguna.                                           | Ivan Jehuda              |=
| Pembayaran           | Berupa layanan yang memungkinkan pembeli melakukan pembayaran secara online (dummy data) | Widya Mutia Ichsan              |

---
## Alur Pengintegrasian dengan Web Service

### **Langkah Integrasi**

### **1. Mendefinisikan Model**
- Buat model data yang akan digunakan untuk berkomunikasi dengan layanan web.
- Pastikan model mendukung metode `toJson()` dan `fromJson()` untuk memudahkan proses serialisasi dan deserialisasi data.

### **2. Menambahkan Dependensi**
- Tambahkan pustaka untuk konektivitas HTTP, seperti `http` atau `dio` pada aplikasi berbasis Dart/Flutter.
- Perbarui file dependensi proyek (contoh: `pubspec.yaml`) untuk menyertakan pustaka yang diperlukan.
- Konfigurasikan konektivitas HTTP sesuai kebutuhan proyek Anda.

### **3. Pemanggilan API**
- Lakukan pengambilan data dari layanan API menggunakan metode seperti:
  - **GET**: Untuk membaca data.
  - **POST**: Untuk mengirim data baru.
  - **PUT**: Untuk memperbarui data.
  - **DELETE**: Untuk menghapus data.
- Gunakan tipe data **Future** dalam aplikasi Dart/Flutter untuk menangani operasi asynchronous selama pemanggilan API.

### **4. Dekode Data JSON**
- Data yang diterima dari API biasanya dalam format JSON. Gunakan pustaka bawaan seperti `dart:convert` untuk mendekode data JSON menjadi struktur data Dart.

### **5. Konversi ke Model**
- Setelah data JSON diterima, konversi ke model yang telah didefinisikan untuk memudahkan manipulasi data di dalam aplikasi.

### **6. Menampilkan Data**
- Data yang telah dikonversi menjadi model ditampilkan secara dinamis di aplikasi.
- Dalam Dart/Flutter, gunakan widget seperti **FutureBuilder** untuk merender konten secara otomatis setelah data berhasil dimuat.
---
## **Deployment**
Tautan aplikasi akan diperbarui setelah rilis:
[Tautan Deployment Aplikasi Hasbogor]
