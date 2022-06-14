class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating,
  });

  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating? rating;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        //rating: Rating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        //"rating": rating!.toJson(),
      };
}

class Rating {
  Rating({
    this.rate,
    this.count,
  });

  double? rate;
  int? count;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}

class ProductModelFirebase {
  ProductModelFirebase({
    required this.category,
    required this.description,
    this.price,
    this.name,
    this.stock,
    this.imageUrl,
  });

  String category;
  String description;
  double? price;
  String? name;
  bool? stock;
  String? imageUrl;

  factory ProductModelFirebase.fromJson(Map<String, dynamic> json) =>
      ProductModelFirebase(
        category: json["category"],
        description: json["description"],
        price: double.parse(json["price"]),
        name: json["name"],
        stock: json["stock"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "description": description,
        "price": price,
        "name": name,
        "stock": stock,
        "imageUrl": imageUrl,
      };
}
