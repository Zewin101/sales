// class MyUser {
//   String id;
//   String firstName;
//   String lastName;
//   String userName;
//   String phone;
//   String email;
// static const String COLLECTION_NAME='user';
//   MyUser({
//     required this.id,
//     required this.phone,
//     required this.firstName,
//     required this.lastName,
//     required this.userName,
//     required this.email,
//   });
//
//   MyUser.formJson(Map<String, dynamic> json)
//       : this(
//           id: json['id'],
//           firstName: json['firstName'],
//           lastName: json['lastName'],
//           userName: json['userName'],
//           email: json['email'],
//           phone: json['phone'],
//         );
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'firstName': firstName,
//       'lastName': lastName,
//       'userName': userName,
//       'email': email,
//       'phone':phone,
//     };
//    }
// }
