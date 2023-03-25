class CategoryProducts {
  String id;
  String nameCategory;
static const COLLECTION_NAME='Category';
  CategoryProducts({ this.id='', required this.nameCategory});

  // CategoryProducts

  static List<CategoryProducts> getCategoryProducts() {
    return [];
  }

  CategoryProducts.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          nameCategory: json['nameCategory']
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameCategory': nameCategory,

    };
  }
}
