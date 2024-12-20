class WishlistModels {
    final List<WishlistItem> data;

    WishlistModels({
        required this.data,
    });

    factory WishlistModels.fromJson(Map<String, dynamic> json) => WishlistModels(
        data: json["data"] == null 
            ? [] 
            : List<WishlistItem>.from(json["data"].map((x) => WishlistItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class WishlistItem {
    final int id;
    final String name;
    final String desc;
    final DateTime addedAt;

    WishlistItem({
        required this.id,
        required this.name,
        required this.desc,
        required this.addedAt,
    });

    factory WishlistItem.fromJson(Map<String, dynamic> json) => WishlistItem(
        id: json["id"],
        name: json["name"],
        desc: json["desc"],
        addedAt: DateTime.parse(json["added_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
        "added_at": addedAt.toIso8601String(),
    };
}

