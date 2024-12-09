// To parse this JSON data, do
//
//     final katalogJson = katalogJsonFromJson(jsonString);

class KatalogJson {
  final int id;
  final String nama;

  KatalogJson({
    required this.id,
    required this.nama,
  });

  factory KatalogJson.fromJson(Map<String, dynamic> json) => KatalogJson(
        id: json["id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KatalogJson && id == other.id && nama == other.nama);

  @override
  int get hashCode => id.hashCode ^ nama.hashCode;
}
