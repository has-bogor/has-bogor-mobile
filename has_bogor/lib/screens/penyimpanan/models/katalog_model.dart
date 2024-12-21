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
    id: json['id'] as int? ?? 0, // Default to 0 if null
    nama: json['nama'] as String? ?? 'Unknown', // Default to 'Unknown' if null
    kategori: json['kategori'] as int? ?? 0, // Default to 0 if null
    harga: (json['harga'] as num?)?.toDouble() ?? 0.0, // Convert to double, default to 0.0 if null
    deskripsi: json['deskripsi'] as String? ?? '', // Default to empty string if null
    toko: json['toko'] as String? ?? '', // Default to empty string if null
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