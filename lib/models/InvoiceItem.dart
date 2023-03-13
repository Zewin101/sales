class InvoiceItem {
  int? id;
  String product;
  int quantity;
  double price;
  int code;
  double total;

  InvoiceItem(
      { this.id,
      required this.product,
      required this.quantity,
      required this.price,
      required this.code,
      this.total=0.00
      });
}
