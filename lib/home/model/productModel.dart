class ProductDetailsModel {
  int? id;
  String? title;
  int? price;
  String? description;
  List<String>? images;
  DateTime? creationAt;
  DateTime? updatedAt;
  Category? category;

  ProductDetailsModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.images,
    this.creationAt,
    this.updatedAt,
    this.category,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      images: List<String>.from(json['images'] ?? []),
      creationAt: json['creationAt'] != null
          ? DateTime.parse(json['creationAt'])
          : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'images': images,
      'creationAt': creationAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class CardDetailsModel {
  int? id;
  String? title;
  int? price;
  String? description;
  String? images;
  int? totalPrice;
  int? totalPice;

  CardDetailsModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.images,
      this.totalPrice,
      this.totalPice});

  factory CardDetailsModel.fromJson(Map<String, dynamic> json) {
    return CardDetailsModel(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        images: json['images'],
        totalPrice: json['total_price'],
        totalPice: json['total_pice']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'images': images,
      'total_price': totalPrice,
      'total_pice': totalPice
    };

    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? image;
  DateTime? creationAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.image,
    this.creationAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      creationAt: json['creationAt'] != null
          ? DateTime.parse(json['creationAt'])
          : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'image': image,
      'creationAt': creationAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
    return data;
  }
}

class CategoryModel {
  int? id;
  String? name;
  String? image;
  String? creationAt;
  String? updatedAt;

  CategoryModel(
      {this.id, this.name, this.image, this.creationAt, this.updatedAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['creationAt'] = creationAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
