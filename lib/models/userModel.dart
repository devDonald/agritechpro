import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  String userId;
  String name;
  String email;
  String phone;
  String gender;
  String state, photo;
  String city, address, marital;
  String occupation;

  UsersModel({
    this.userId,
    this.name,
    this.email,
    this.address,
    this.phone,
    this.gender,
    this.occupation,
    this.state,
    this.city,
    this.marital,
    this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "email": email,
      'name': name,
      'address': address,
      'gender': gender,
      'occupation': occupation,
      'state': state,
      'phone': phone,
      'profile': photo,
      'inGroup': false,
      'isAdmin': false,
      'city': city,
      'marital': marital,
    };
  }

  UsersModel.fromFirestore(Map<String, dynamic> snapshot)
      : userId = snapshot['userId'] ?? '',
        name = snapshot['name'] ?? '',
        email = snapshot['email'] ?? '',
        address = snapshot['address'] ?? '',
        phone = snapshot['phone'] ?? '',
        gender = snapshot['gender'] ?? '',
        occupation = snapshot['occupation'] ?? '',
        state = snapshot['state'] ?? '',
        city = snapshot['city'] ?? '',
        photo = snapshot['photo'] ?? '',
        marital = snapshot['marital'] ?? '';

  toJson() {
    return {
      "userId": userId,
      "email": email,
      'name': name,
      'address': address,
      'gender': gender,
      'occupation': occupation,
      'state': state,
      'phone': phone,
      'photo': photo,
      'city': city,
      'marital': marital,
    };
  }

  UsersModel.fromSnapshot(DocumentSnapshot snapshot) {
    this.userId = snapshot['userId'];
    this.name = snapshot['name'];
    this.email = snapshot['email'];
    this.address = snapshot['address'];
    this.phone = snapshot['phone'];
    this.gender = snapshot['gender'];
    this.occupation = snapshot['occupation'];
    this.state = snapshot['state'];
    this.city = snapshot['city'];
    this.photo = snapshot['photo'];
    this.marital = snapshot['marital'];
  }
}
