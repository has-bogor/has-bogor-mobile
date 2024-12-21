class Katalog {
  final String nama;
  final int kategori;
  final String harga;
  final String deskripsi;
  final String toko;
  final String categoryName;

  Katalog({
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.toko,
    required this.categoryName
  });

  factory Katalog.fromJson(Map<String, dynamic> json) {
    return Katalog(
      nama: json['nama'] as String,
      kategori: json['kategori'] as int,
      harga: json['harga'] as String,
      deskripsi: json['deskripsi'] as String,
      toko: json['toko'] as String,
      categoryName: json['category_name'] ?? 'Unknown', // Default category name if not found

    );
  }

  Map<String, dynamic> toJson() => {
    'nama': nama,
    'kategori': kategori,
    'harga': harga,
    'deskripsi': deskripsi,
    'toko': toko,
    'categoryName' : categoryName
  };
}