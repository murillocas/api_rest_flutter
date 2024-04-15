import 'dart:convert';

List<Item> itemFromJson(String str) => List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
    int? id;
    String nameitem;
    String? price;
    int? qtd;
    String? descricao;
    String? img;
    String? category;
    int? published;

    Item({
       required this.id,
       required this.nameitem,
        this.price,
        this.qtd,
        this.descricao,
        this.img,
        this.category,
        this.published,
    });

     factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        nameitem: json["nameitem"],
        price: json["price"],
        qtd: json["qtd"],
        descricao: json["descricao"],
        img: json["img"],
        category: json["category"],
        published: json["published"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nameitem": nameitem,
        "price": price,
        "qtd": qtd,
        "descricao":descricao,
        "img": img,
        "category": category,
        "published": published,
    };

}