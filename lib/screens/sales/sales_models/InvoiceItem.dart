class InvoiceItem {
  static const String COLLECTION = 'INVOICE';
  int? id;
  String product;
  int quantity;
  double price;
  int code;
  double total;

  InvoiceItem({ this.id,
    required this.product,
    required this.quantity,
    required this.price,
    required this.code,
    this.total = 0.00
  });

  InvoiceItem item({
    String? product,
    int? quantity,
    double? price,
    int? code,
  }) {
    return InvoiceItem(product: product ?? this.product,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        code: code ?? this.code);
  }

  InvoiceItem.fromJson(Map<String, dynamic> json) :this(
    id: json['id'],
    product: json['product'],
    quantity: json['quantity'],
    price: json['price'],
    code: json['code'],
    total: json['total'],
  );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'product': product,
        'quantity': quantity,
        'price': price,
        'code': code,
        'total': total,
      };



  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is InvoiceItem &&
              runtimeType == other.runtimeType &&
              product == other.product &&
              quantity == other.quantity &&
              code == other.code &&
              price == other.price;

  @override
  // TODO: implement hashCode
  int get hashCode =>  product.hashCode^quantity.hashCode^code.hashCode^price.hashCode;



}
