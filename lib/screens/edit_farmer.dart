import 'package:agritechpro/authentication/login.dart';
import 'package:agritechpro/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class EditFarmer extends StatefulWidget {
  static const String id = 'EditFarmer';
  final String userId, name;
  final String email, phone, gender, photo, state, ward, marital;
  final String dob, address, cooperative, household;
  final String crops, town, occupation, receivedItems;

  const EditFarmer({
    Key key,
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.photo,
    this.state,
    this.ward,
    this.marital,
    this.dob,
    this.address,
    this.cooperative,
    this.household,
    this.crops,
    this.town,
    this.occupation,
    this.receivedItems,
  }) : super(key: key);

  @override
  _EditFarmerState createState() => _EditFarmerState();
}

var isLargeScreen = false;

class _EditFarmerState extends State<EditFarmer> {
  bool loading = false;
  ProgressDialog pr;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _ward = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _occupation = TextEditingController();
  final TextEditingController _marital = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _cooperative = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _household = TextEditingController();
  final TextEditingController _town = TextEditingController();
  final TextEditingController _crops = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _received = TextEditingController();

  String selectedState;

  String error = '';

  @override
  void initState() {
    _email.text = widget.email;
    _fullName.text = widget.name;
    _phoneNumber.text = widget.phone;
    _ward.text = widget.ward;
    _address.text = widget.address;
    _occupation.text = widget.occupation;
    _marital.text = widget.marital;
    _state.text = widget.state;
    _cooperative.text = widget.cooperative;
    _dob.text = widget.dob;
    _household.text = widget.household;
    _town.text = widget.town;
    _crops.text = widget.crops;
    _gender.text = widget.gender;
    _received.text = widget.receivedItems;
    super.initState();
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
        title: Text('Edit Farmer',
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
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AuthTextFeildLabel(
                                label: 'Full Name ',
                              ),
                              AuthTextField(
                                width: double.infinity,
                                formField: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _fullName,
                                  decoration: InputDecoration(
                                    hintText: 'surname first',
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
                                      label: 'Age',
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
                                              controller: _dob,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                hintText: '30',
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
                              AuthTextField(
                                width: double.infinity,
                                formField: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: _gender,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'enter gender';
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
                                label: 'Cluster Name',
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
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AuthTextFeildLabel(
                                      label: 'Received Items',
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 4,
                                          child: AuthTextField(
                                            formField: TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              controller: _received,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter received items';
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
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),

                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              PrimaryButton(
                                height: 45.0,
                                width: double.infinity,
                                color: Colors.green,
                                buttonTitle: 'Submit Details',
                                blurRadius: 7.0,
                                roundedEdge: 2.5,
                                onTap: () async {
                                  if (_fullName.text != '' &&
                                      _gender.text != '' &&
                                      _marital.text != '' &&
                                      _phoneNumber.text != '' &&
                                      _occupation.text != '') {
                                    try {
                                      DocumentReference _docRef =
                                          farmersRef.doc(widget.userId);
                                      await _docRef.update({
                                        'email': _email.text,
                                        'phone': _phoneNumber.text,
                                        'gender': _gender.text,
                                        'state': _state.text,
                                        'occupation': _occupation.text,
                                        'address': _address.text,
                                        'marital': _marital.text,
                                        'ward': _ward.text,
                                        'name': _fullName.text,
                                        'receivedItems': _received.text,
                                        'cooperative': _cooperative.text,
                                        'dob': _dob.text,
                                        'household': _household.text,
                                        'crops': _crops.text,
                                        'town': _town.text,
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

                                        Navigator.of(context).pop();
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
