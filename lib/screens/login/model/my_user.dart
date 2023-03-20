class MyUser {
  String id;

  String email;
static const String COLLECTION_NAME='user';
  MyUser({
    required this.id,

    required this.email,
  });

  MyUser.formJson(Map<String, dynamic> json)
      : this(
          id: json['id'],

          email: json['email'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
    };
   }
}
