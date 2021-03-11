import 'dart:io';

import 'package:agritechpro/authentication/login.dart';
import 'package:agritechpro/resources/resources.dart';
import 'package:agritechpro/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class AddFarmers extends StatefulWidget {
  static const String id = 'AddFarmers';

  const AddFarmers({
    Key key,
  }) : super(key: key);

  @override
  _AddFarmersState createState() => _AddFarmersState();
}

var isLargeScreen = false;

class _AddFarmersState extends State<AddFarmers> {
  bool loading = false;
  ProgressDialog pr;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _ward = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _occupation = TextEditingController();
  final TextEditingController _marital = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _cooperative = TextEditingController();
  final TextEditingController _year = TextEditingController();
  final TextEditingController _household = TextEditingController();
  final TextEditingController _bankName = TextEditingController();
  final TextEditingController _accountName = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _bvn = TextEditingController();
  final TextEditingController _month = TextEditingController();
  final TextEditingController _day = TextEditingController();
  final TextEditingController _town = TextEditingController();
  final TextEditingController _crops = TextEditingController();

  String selectedState, selectedGender, category;

  String error = '';

  bool isPicked = false;

  File pickedImage;

  final _picker = ImagePicker();
  getImageFile(ImageSource source) async {
    //Clicking or Picking from Gallery

    var image = await _picker.getImage(source: source);

    //Cropping the image

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      maxWidth: 512,
      maxHeight: 512,
    );

    setState(() {
      pickedImage = croppedFile;
      print(pickedImage.lengthSync());
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);

    pr = new ProgressDialog(context);
    pr.style(message: 'Please wait, Adding Farmer');

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    if (deviceHeight >= 800.0) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }
    if (deviceWidth >= 420.0) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: Colors.green,
        title: Text('Add Farmer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
        titleSpacing: -5.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              //height: deviceHeight,
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: pickedImage != null
                                            ? FileImage(pickedImage)
                                            : AssetImage('images/user.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 90.0, right: 100.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () async {
                                        await getImageFile(ImageSource.camera);
                                      },
                                      child: new CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 25.0,
                                        child: new Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AuthTextFeildLabel(
                                label: 'Surname ',
                              ),
                              AuthTextField(
                                width: double.infinity,
                                formField: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _surname,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                  keyboardType: TextInputType.name,
                                  textCapitalization: TextCapitalization.words,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your full name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AuthTextFeildLabel(
                                label: 'First Name, Other Names',
                              ),
                              AuthTextField(
                                width: double.infinity,
                                formField: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _firstName,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                  keyboardType: TextInputType.name,
                                  textCapitalization: TextCapitalization.words,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter title';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AuthTextFeildLabel(
                                label: 'Email Address ',
                              ),
                              AuthTextField(
                                width: double.infinity,
                                formField: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _email,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) => val.trim().isEmpty
                                      ? 'Enter Email Address'
                                      : !val.trim().contains('@') ||
                                              !val.trim().contains('.')
                                          ? 'enter a valid email address'
                                          : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Marital Status
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AuthTextFeildLabel(
                                label: 'Marital Status',
                              ),
                              AuthTextField(
                                width: double.infinity,
                                formField: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: _marital,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'enter marital status';
                                      }
                                      return null;
                                    }),
                              ),
                            ],
                          ),
                        ),

                        //Occupation
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AuthTextFeildLabel(
                                label: 'Occupation ',
                              ),
                              AuthTextField(
                                width: double.infinity,
                                formField: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: _occupation,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'enter occupation';
                                      }
                                      return null;
                                    }),
                              ),
                            ],
                          ),
                        ),
                        // address

                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AuthTextFeildLabel(
                                label: 'Home Address ',
                              ),
                              AuthTextField(
                                width: double.infinity,
                                formField: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: _address,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'enter address';
                                      }
                                      return null;
                                    }),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AuthTextFeildLabel(
                                label: 'Town',
                              ),
                              AuthTextField(
                                width: double.infinity,
                                formField: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: _town,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'enter town';
                                      }
                                      return null;
                                    }),
                              ),
                            ],
                          ),
                        ),

                        // City and State
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AuthTextFeildLabel(
                                      label: 'Ward',
                                    ),
                                    AuthTextField(
                                      width: MediaQuery.of(context).size.width /
                                              2.3 +
                                          1,
                                      formField: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: _ward,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'ward cannot be enter';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //State
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AuthTextFeildLabel(
                                      label: 'State',
                                    ),
                                    AuthTextField(
                                      width: MediaQuery.of(context).size.width /
                                              2.3 +
                                          1,
                                      formField: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: _state,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'state cannot be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Date of Birth and Gender
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AuthTextFeildLabel(
                                      label: 'Date of Birth',
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AuthTextField(
                                            width: 80,
                                            formField: TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              controller: _day,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                hintText: 'DD',
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'day cannot be empty';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Text(
                                            '-',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          AuthTextField(
                                            width: 80,
                                            formField: TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              controller: _month,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                hintText: 'MM',
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'month cannot be empty';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Text(
                                            '-',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          AuthTextField(
                                            width: 80,
                                            formField: TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              controller: _year,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                hintText: 'YYYY',
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'month cannot be empty';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Gender
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AuthTextFeildLabel(
                                label: 'Gender',
                              ),
                              Container(
                                child: DropdownButtonFormField<String>(
                                  hint: Text('Select Gender'),
                                  value: selectedGender,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 25.0,
                                  elevation: 0,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      selectedGender = newValue;
                                      print(selectedGender);
                                    });
                                  },
                                  items: gender.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AuthTextFeildLabel(
                                label: 'Name of Cooperative',
                              ),
                              AuthTextField(
                                width: double.infinity,
                                formField: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: _cooperative,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'enter name of cooperative';
                                      }
                                      return null;
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AuthTextFeildLabel(
                                label: 'Number of Household',
                              ),
                              AuthTextField(
                                width: double.infinity,
                                formField: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: _household,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'enter number of household';
                                      }
                                      return null;
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AuthTextFeildLabel(
                                label: 'Crops Cultivated',
                              ),
                              AuthTextField(
                                width: double.infinity,
                                formField: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: _crops,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'enter crops cultivated';
                                      }
                                      return null;
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AuthTextFeildLabel(
                                label: 'Phone Number',
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 4,
                                    child: AuthTextField(
                                      formField: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: _phoneNumber,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter phone number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldsText(
                                label: 'Bank Details',
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          AuthTextFeildLabel(
                                            label: 'Bank Name ',
                                          ),
                                          AuthTextField(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.3 +
                                                1,
                                            formField: TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              controller: _bankName,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'enter bank name';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //State
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          AuthTextFeildLabel(
                                            label: 'Account Name',
                                          ),
                                          AuthTextField(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.3 +
                                                1,
                                            formField: TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              controller: _accountName,
                                              keyboardType:
                                                  TextInputType.number,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'account name cannot be empty';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          AuthTextFeildLabel(
                                            label: 'Account Number',
                                          ),
                                          AuthTextField(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.3 +
                                                1,
                                            formField: TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              controller: _accountNumber,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'account no cannot be empty';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //State
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          AuthTextFeildLabel(
                                            label: 'BVN',
                                          ),
                                          AuthTextField(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.3 +
                                                1,
                                            formField: TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              controller: _bvn,
                                              keyboardType:
                                                  TextInputType.number,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'BVN cannot be empty';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              PrimaryButton(
                                height: 45.0,
                                width: double.infinity,
                                color: Colors.green,
                                buttonTitle: 'Add Farmer',
                                blurRadius: 7.0,
                                roundedEdge: 2.5,
                                onTap: () async {
                                  if (_surname.text != '' &&
                                      selectedGender != '' &&
                                      _firstName.text != '' &&
                                      _bvn.text != '' &&
                                      _occupation.text != '') {
                                    try {
                                      User _currentUser =
                                          FirebaseAuth.instance.currentUser;
                                      String uid = _currentUser.uid;
                                      if (pickedImage != null) {
                                        pr.show();
                                        Reference storageReference =
                                            FirebaseStorage.instance.ref().child(
                                                'farmers/$uid/${Path.basename(pickedImage.path)}}');
                                        UploadTask uploadTask = storageReference
                                            .putFile(pickedImage);
                                        await uploadTask;
                                        print('File Uploaded');
                                        storageReference
                                            .getDownloadURL()
                                            .then((fileURL) async {
                                          String photo = fileURL;
                                          DocumentReference _docRef =
                                              farmersRef.doc();
                                          await _docRef.set({
                                            'email': _email.text,
                                            'phone': _phoneNumber.text,
                                            'gender': selectedGender,
                                            'state': _state.text,
                                            'occupation': _occupation.text,
                                            'address': _address.text,
                                            'day': _day.text,
                                            'month': _month.text,
                                            'firstName': _firstName.text,
                                            'farmerId': _docRef.id,
                                            'FIN': _docRef.id.toUpperCase(),
                                            'marital': _marital.text,
                                            'ward': _ward.text,
                                            'surname': _surname.text,
                                            'cooperative': _cooperative.text,
                                            'dob':
                                                '${_day.text}-${_month.text}-${_year.text}',
                                            'year': _year.text,
                                            'household': _household.text,
                                            'accountNo': _accountNumber.text,
                                            'BVN': _bvn.text,
                                            'crops': _crops.text,
                                            'bankName': _bankName.text,
                                            'accountName': _accountName.text,
                                            'town': _town.text,
                                            'photo': photo
                                          }).then((value) async {
                                            pr.hide();

                                            Fluttertoast.showToast(
                                                msg: "Successful",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            if (mounted) {
                                              setState(() {
                                                _email.clear();
                                                _surname.clear();
                                                _phoneNumber.clear();
                                                _ward.clear();
                                                _address.clear();
                                                _occupation.clear();
                                                _marital.clear();
                                                _state.clear();
                                                _firstName.clear();
                                                _cooperative.clear();
                                                _year.clear();
                                                _household.clear();
                                                _bankName.clear();
                                                _accountName.clear();
                                                _accountNumber.clear();
                                                _bvn.clear();
                                                _crops.clear();
                                                _day.clear();
                                                _month.clear();
                                              });
                                            }
                                            Navigator.of(context);
                                          }).catchError((onError) async {
                                            pr.hide();
                                            Fluttertoast.showToast(
                                                msg: "failed try again",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          });
                                        });
                                      }
                                    } catch (e) {}
                                  } else {
                                    setState(() {
                                      error = 'complete all required fields';
                                    });
                                  }
                                },
                              ),
                              SizedBox(height: 25.0),
                              Center(
                                child: Text(
                                  error,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              SizedBox(
                                height: 23.5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DoBPicker extends StatelessWidget {
  const DoBPicker({
    Key key,
    this.onTap,
    this.dob,
  }) : super(key: key);
  final Function onTap;
  final String dob;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 0.5,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date of Birth'),
              SizedBox(height: 8),
              Text(dob),
            ],
          ),
        ),
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key key,
    this.onTap,
    this.info,
    this.icon,
  }) : super(key: key);
  final Function onTap;
  final String info;
  final IconData icon;
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        // width: 80,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(
          left: 5,
          right: 5,
          top: 8,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black26,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(widget.info),
            SizedBox(width: 3),
            Container(
              child: Icon(widget.icon, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldsText extends StatelessWidget {
  const TextFieldsText({
    Key key,
    this.label,
    this.controller,
    this.onChanged,
  }) : super(key: key);
  final String label;
  final TextEditingController controller;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: RichText(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
          children: <TextSpan>[],
        ),
      ),
    );
  }
}
