// To parse this JSON data, do
//
//     final ulasanJson = ulasanJsonFromJson(jsonString);


class UlasanJson {
    int id;
    String ulasanMakananSouvenirNama;
    int ulasanMakananSouvenirId;
    int rating;
    String pesanUlasan;

    UlasanJson({
        required this.id,
        required this.ulasanMakananSouvenirNama,
        required this.ulasanMakananSouvenirId,
        required this.rating,
        required this.pesanUlasan,
    });

    factory UlasanJson.fromJson(Map<String, dynamic> json) => UlasanJson(
        id: json["id"],
        ulasanMakananSouvenirNama: json["ulasan_makanan_souvenir__nama"],
        ulasanMakananSouvenirId: json["ulasan_makanan_souvenir__id"],
        rating: json["rating"],
        pesanUlasan: json["pesan_ulasan"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ulasan_makanan_souvenir__nama": ulasanMakananSouvenirNama,
        "ulasan_makanan_souvenir__id" : ulasanMakananSouvenirId,
        "rating": rating,
        "pesan_ulasan": pesanUlasan,
    };
}
