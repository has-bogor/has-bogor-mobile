class Katalog {
  final int id;
  final String nama;
  final double harga;
  final int kategori;
  final String deskripsi;
  final String toko;

  Katalog({
    required this.id,
    required this.nama,
    required this.harga,
    required this.kategori,
    required this.deskripsi,
    required this.toko,
  });

  // Convert JSON to Katalog object
  factory Katalog.fromJson(Map<String, dynamic> json) {
    return Katalog(
      id: json['id'] ?? 0,
      nama: json['nama'] ?? '',
      harga: json['harga']?.toDouble() ?? 0.0,
      kategori: json['kategori'] ?? 0,
      deskripsi: json['deskripsi'] ?? '',
      toko: json['toko'] ?? '',
    );
  }

  // Convert Katalog object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
      'kategori': kategori,
      'deskripsi': deskripsi,
      'toko': toko,
    };
  }
}