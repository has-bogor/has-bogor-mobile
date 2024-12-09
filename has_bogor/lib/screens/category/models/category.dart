class Category {
  final int id;
  final String namaCategory;

  Category({required this.id, required this.namaCategory});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      namaCategory: json['nama_category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_category': namaCategory,
    };
  }
}
