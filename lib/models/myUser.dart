
class RodinaKidsUser {
  String id;
  String name;
  String phone;
  String email;
  static const String COLLECTION_NAME='user';
  RodinaKidsUser({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });

  RodinaKidsUser.formJson(Map<String, dynamic> json)
      : this(
    id: json['id'],
    name: json['name'],
    phone: json['phone'],
    email: json['email'],
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,

      'email': email,
    };
  }
}


