class InvoiceItem {
  String id;
  String product;
  int quantity;
  double price;
  int code;

  InvoiceItem(
      { this.id='',
      required this.product,
      required this.quantity,
      required this.price,
      required this.code});
}
