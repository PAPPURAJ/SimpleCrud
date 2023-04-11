class ProductModel {
  int? id;
  String? name;
  String? barcode;
  String? description;
  SubCategory? subCategory;
  Category? brand;
  Quantity? quantity;
  ProductPrice? productPrice;
  String? image;

  ProductModel(
      {this.id,
        this.name,
        this.barcode,
        this.description,
        this.subCategory,
        this.brand,
        this.quantity,
        this.productPrice,
        this.image});

  ProductModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    barcode = json['barcode'];
    description = json['description'];
    subCategory = json['subCategory'] != null
        ? new SubCategory.fromJson(json['subCategory'])
        : null;
    brand = json['brand'] != null ? new Category.fromJson(json['brand']) : null;
    quantity = json['quantity'] != null
        ? new Quantity.fromJson(json['quantity'])
        : null;
    productPrice = json['productPrice'] != null
        ? new ProductPrice.fromJson(json['productPrice'])
        : null;
    image = json['image'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['barcode'] = this.barcode;
    data['description'] = this.description;
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory!.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.quantity != null) {
      data['quantity'] = this.quantity!.toJson();
    }
    if (this.productPrice != null) {
      data['productPrice'] = this.productPrice!.toJson();
    }
    data['image'] = this.image;
    return data;
  }
}

class SubCategory {
  int? id;
  String? name;
  String? image;
  String? description;
  Category? category;

  SubCategory(
      {this.id, this.name, this.image, this.description, this.category});

  SubCategory.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? image;
  String? description;

  Category({this.id, this.name, this.image, this.description});

  Category.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}

class Quantity {
  int? id;
  int? quantity;
  String? unit;
  double? unitValue;
  int? pastQuantity;

  Quantity(
      {this.id, this.quantity, this.unit, this.unitValue, this.pastQuantity});

  Quantity.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    unit = json['unit'];
    unitValue = json['unitValue'];
    pastQuantity = json['pastQuantity'] as int;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['unitValue'] = this.unitValue;
    data['pastQuantity'] = this.pastQuantity;
    return data;
  }
}

class ProductPrice {
  int? id;
  double? price;
  double? unitPrice;
  double? mrp;

  ProductPrice({this.id, this.price, this.unitPrice, this.mrp});

  ProductPrice.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    price = json['price'];
    unitPrice = json['unitPrice'];
    mrp = json['mrp'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['unitPrice'] = this.unitPrice;
    data['mrp'] = this.mrp;
    return data;
  }
}