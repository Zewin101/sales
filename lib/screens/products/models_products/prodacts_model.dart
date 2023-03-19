class Products_Model {
  static const String COLLECTION_NAME='product';
  String id;
  String productName;
  String code;
  String category;
  int sellingPrice;
  int priceBuy;
  int quantity;
  String productImage;

  Products_Model(
      {this.id = '',
      required this.productName,
      required this.code,
      required this.category,
      required this.sellingPrice,
      required this.priceBuy,
      required this.quantity,
      this.productImage = ''});

  Products_Model.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          code: json['code'],
          productName: json['productName'],
          quantity: json['quantity'],
          category: json['category'],
          priceBuy: json['priceBuy'],
          sellingPrice: json['sellingPrice'],
          productImage: json['productImage'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'productName': productName,
      'quantity': quantity,
      'category': category,
      'priceBuy': priceBuy,
      'sellingPrice': sellingPrice,
      'productImage': productImage,
    };
  }
}
