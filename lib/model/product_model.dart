class Product {
  int? totalSize;
  int? typeId;
  int? offset;
  late List<ProductModel>? _products;
  List<ProductModel>? get products  => _products;

  Product({this.totalSize, this.typeId, this.offset, required products});

  Product.fromJson(Map<String, dynamic> json){
    totalSize = json["total_size"];
    typeId = json["type_id"];
    offset = json["offset"];

    if (json['products'] != null) {
      _products = <ProductModel>[];
      json["products"].forEach((e){
        _products!.add(ProductModel.fromJson(e));
      });
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["total_size"] = this.totalSize;
    data["offset"] = this.offset;
    data["type_id"] = this.typeId;

    if(this._products != null){
      data["products"] = this._products!.map((e) => e.toJson()).toList();
    }

    return data;
  }

}

class ProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? updatedAt;
  String? createdAt;
  int? typeId;

  ProductModel.fromJson(Map<String, dynamic> json){
    id = json["id"];
    name = json["name"];
    description = json["description"];
    price = json["price"];
    stars = json["stars"];
    img = json["img"];
    location = json["location"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    typeId = json["type_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['stars'] = this.stars;
    data['img'] = this.img;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type_id'] = this.typeId;
    return data;
  }
}
