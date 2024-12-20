class Promo {
  final String? id;  
  final int kode;
  final int potongan;
  final int masaBerlaku;
  final int minimalTransaksi;
  final List<Map<String, dynamic>> tokoTerkait;  // Ubah ke List<Map>

  Promo({
    this.id,
    required this.kode,
    required this.potongan,
    required this.masaBerlaku,
    required this.minimalTransaksi,
    List<Map<String, dynamic>>? tokoTerkait,
  }) : this.tokoTerkait = tokoTerkait ?? [];

  factory Promo.fromJson(Map<String, dynamic> json) {
    var tokoTerkaitData = json['fields']['toko_terkait'];
    List<Map<String, dynamic>> tokoTerkaitList = [];

    if (tokoTerkaitData != null) {
      tokoTerkaitList = List<Map<String, dynamic>>.from(tokoTerkaitData);
    }

    return Promo(
      id: json['pk'],
      kode: int.parse(json['fields']['kode'].toString()),
      potongan: int.parse(json['fields']['potongan'].toString()),
      masaBerlaku: int.parse(json['fields']['masa_berlaku'].toString()),
      minimalTransaksi: int.parse(json['fields']['minimal_transaksi'].toString()),
      tokoTerkait: tokoTerkaitList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode': kode.toString(),
      'potongan': potongan.toString(),
      'masa_berlaku': masaBerlaku.toString(),
      'minimal_transaksi': minimalTransaksi.toString(),
      'toko_terkait': tokoTerkait,
    };
  }
}