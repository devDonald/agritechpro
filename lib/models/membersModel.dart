import 'package:cloud_firestore/cloud_firestore.dart';

class FarmersModel {
  String userId;
  String name;
  String email;
  String phone;
  String gender;
  String state;
  String city, marital;
  String dob, address, affiliation, churchYears;
  String photo, title, units, name1, phone1, name2, phone2, name3, phone3;
  int year, month, day;
  String country, occupation;

  FarmersModel(
      {this.userId,
      this.name,
      this.email,
      this.address,
      this.phone,
      this.gender,
      this.occupation,
      this.state,
      this.city,
      this.title,
      this.dob,
      this.photo,
      this.country,
      this.marital,
      this.year,
      this.month,
      this.day,
      this.phone1,
      this.name1,
      this.affiliation,
      this.churchYears,
      this.units,
      this.name2,
      this.phone2,
      this.name3,
      this.phone3});

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "email": email,
      'name': name,
      'address': address,
      'gender': gender,
      'occupation': occupation,
      'state': state,
      'dob': dob,
      'phone': phone,
      'country': country,
      'profile': photo,
      'city': city,
      'marital': marital,
      'year': year,
      'month': month,
      'title': title,
      'day': day,
      'phone1': phone1,
      'name1': name1,
      'affiliation': affiliation,
      'churchYears': churchYears,
      'units': units,
      'phone2': phone2,
      'name2': name2,
      'phone3': phone3,
      'name3': name3,
    };
  }

  FarmersModel.fromFirestore(Map<String, dynamic> snapshot)
      : userId = snapshot['userId'] ?? '',
        name = snapshot['name'] ?? '',
        email = snapshot['email'] ?? '',
        address = snapshot['address'] ?? '',
        phone = snapshot['phone'] ?? '',
        gender = snapshot['gender'] ?? '',
        occupation = snapshot['occupation'] ?? '',
        state = snapshot['state'] ?? '',
        city = snapshot['city'] ?? '',
        dob = snapshot['dob'] ?? '',
        photo = snapshot['photo'] ?? '',
        marital = snapshot['marital'] ?? '',
        year = snapshot['year'] ?? '',
        month = snapshot['month'] ?? '',
        day = snapshot['day'] ?? '',
        title = snapshot['title'] ?? '',
        churchYears = snapshot['churchYears'] ?? '',
        units = snapshot['units'] ?? '',
        affiliation = snapshot['affiliation'] ?? '',
        phone1 = snapshot['phone1'] ?? '',
        name1 = snapshot['name1'] ?? '',
        phone2 = snapshot['phone2'] ?? '',
        name2 = snapshot['name2'] ?? '',
        phone3 = snapshot['phone3'] ?? '',
        name3 = snapshot['name3'] ?? '',
        country = snapshot['country'] ?? '';

  toJson() {
    return {
      "userId": userId,
      "email": email,
      'name': name,
      'address': address,
      'gender': gender,
      'occupation': occupation,
      'state': state,
      'dob': dob,
      'phone': phone,
      'country': country,
      'photo': photo,
      'city': city,
      'title': title,
      'marital': marital,
      'month': month,
      'year': year,
      'day': day,
      'phone1': phone1,
      'name1': name1,
      'affiliation': affiliation,
      'churchYears': churchYears,
      'units': units,
      'phone2': phone2,
      'name2': name2,
      'phone3': phone3,
      'name3': name3,
    };
  }

  FarmersModel.fromSnapshot(DocumentSnapshot snapshot) {
    this.userId = snapshot['userId'];
    this.name = snapshot['name'];
    this.email = snapshot['email'];
    this.address = snapshot['address'];
    this.phone = snapshot['phone'];
    this.gender = snapshot['gender'];
    this.occupation = snapshot['occupation'];
    this.state = snapshot['state'];
    this.city = snapshot['city'];
    this.dob = snapshot['dob'];
    this.photo = snapshot['photo'];
    this.marital = snapshot['marital'];
    this.year = snapshot['year'];
    this.month = snapshot['month'];
    this.day = snapshot['day'];
    this.title = snapshot['title'];
    this.country = snapshot['country'];
    this.churchYears = snapshot['churchYears'];
    this.units = snapshot['units'];
    this.affiliation = snapshot['affiliation'];
    this.phone1 = snapshot['phone1'];
    this.name1 = snapshot['name1'];
    this.phone2 = snapshot['phone2'];
    this.name2 = snapshot['name2'];
    this.phone3 = snapshot['phone3'];
    this.name3 = snapshot['name3'];
  }
}
