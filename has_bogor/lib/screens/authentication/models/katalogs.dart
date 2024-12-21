class Katalog {
  final String nama;
  final int kategori;
  final String harga;
  final String deskripsi;
  final String toko;

  Katalog({

    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.toko,
  });

  factory Katalog.fromJson(Map<String, dynamic> json) {
    return Katalog(
      nama: json['nama'] as String,
      kategori: json['kategori'] as int,
      harga: json['harga'] as String,
      deskripsi: json['deskripsi'] as String,
      toko: json['toko'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'nama': nama,
    'kategori': kategori,
    'harga': harga,
    'deskripsi': deskripsi,
    'toko': toko,
  };
}