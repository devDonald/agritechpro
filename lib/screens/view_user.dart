import 'dart:io';

import 'package:agritechpro/authentication/login.dart';
import 'package:agritechpro/screens/edit_farmer.dart';
import 'package:agritechpro/screens/view_profle.dart';
import 'package:agritechpro/services/auth_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

class ViewFarmer extends StatefulWidget {
  static const String id = 'ViewFarmer';
  final String userId, name;
  final String email, phone, gender, photo, state, ward, marital;
  final String dob, address, cooperative, household;
  final String crops, town, occupation;

  const ViewFarmer({
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
    this.occupation,
    this.town,
  }) : super(key: key);

  @override
  _ViewFarmerState createState() => _ViewFarmerState();
}

var isLargeScreen = false;

class _ViewFarmerState extends State<ViewFarmer> {
  File pickedImage;

  final _picker = ImagePicker();
  getImageFile(ImageSource source) async {
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

  Future<void> sendImage() async {
    try {
      User _currentUser = await FirebaseAuth.instance.currentUser;
      String uid = _currentUser.uid;
      if (pickedImage != null) {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('farmers/$uid/${Path.basename(pickedImage.path)}}');
        UploadTask uploadTask = storageReference.putFile(pickedImage);
        await uploadTask;
        print('File Uploaded');
        storageReference.getDownloadURL().then((fileURL) async {
          String _uploadedImageURL = fileURL;
          DocumentReference _docRef = farmersRef.doc(widget.userId);
          await _docRef.update({
            'photo': _uploadedImageURL,
          }).then((doc) async {
            Fluttertoast.showToast(
                msg: "photo successfully updated",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
          }).catchError((onError) async {
            Fluttertoast.showToast(
                msg: "photo update Failed",
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
  }

  @override
  void initState() {
    print('UserId: ${widget.userId}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
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
        title: Text('${widget.name}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
        titleSpacing: -5.0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 17.5, bottom: 5.0, left: 7.0, right: 7.0),
        //padding: EdgeInsets.only(left: 15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 2.5),
              blurRadius: 10.5,
            ),
          ],
        ),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: new Stack(fit: StackFit.loose, children: <Widget>[
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewAttachedImage(
                                      image: CachedNetworkImageProvider(
                                          widget.photo),
                                      text: '${widget.name}',
                                      url: widget.photo,
                                    )));
                      },
                      child: new Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              image:
                                  new CachedNetworkImageProvider(widget.photo),
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 90.0, right: 100.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            await getImageFile(ImageSource.gallery);
                            sendImage();
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
                  AuthTextFeildLocal(
                    label: 'Full Name ',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AuthTextFeildLocal(
                    label: 'Email Address ',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.email,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //Marital Status
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AuthTextFeildLocal(
                    label: 'Marital Status',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.marital,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //Occupation
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AuthTextFeildLocal(
                    label: 'Occupation ',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.occupation,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            // address
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AuthTextFeildLocal(
                    label: 'Home Address ',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.address,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AuthTextFeildLocal(
                    label: 'Town ',
                  ),
                  Text(
                    widget.town,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
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
                        AuthTextFeildLocal(
                          label: 'Ward ',
                        ),
                        Text(
                          widget.ward,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
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
                        AuthTextFeildLocal(
                          label: 'State ',
                        ),
                        Text(
                          widget.state,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
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
                        AuthTextFeildLocal(
                          label: 'Date of Birth',
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                widget.dob,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
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
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AuthTextFeildLocal(
                    label: 'Gender',
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: Text(
                      widget.gender,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
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
                  AuthTextFeildLocal(
                    label: 'Name of Cooperative',
                  ),
                  Text(
                    widget.cooperative,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
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
                  AuthTextFeildLocal(
                    label: 'Number of Household',
                  ),
                  Text(
                    widget.household,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
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
                  AuthTextFeildLocal(
                    label: 'Crops Cultivated',
                  ),
                  Text(
                    widget.crops,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
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
                  AuthTextFeildLocal(
                    label: 'Phone Number',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.phone,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            SizedBox(
              height: 30,
            ),

            PrimaryButton(
                buttonTitle: 'Delete Farmer\'s Record',
                width: double.infinity,
                height: 45.0,
                color: Colors.red,
                blurRadius: 7.0,
                roundedEdge: 2.5,
                onTap: () {
                  showDeleteDialog(context, widget.userId);
                }),
            SizedBox(
              height: 20,
            ),
            PrimaryButton(
              buttonTitle: 'Edit Profile',
              width: double.infinity,
              height: 45.0,
              color: Colors.lightBlueAccent,
              blurRadius: 7.0,
              roundedEdge: 2.5,
              onTap: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditFarmer(
                                userId: widget.userId,
                                name: widget.name,
                                email: widget.email,
                                address: widget.address,
                                phone: widget.phone,
                                gender: widget.gender,
                                occupation: widget.occupation,
                                state: widget.state,
                                dob: widget.dob,
                                marital: widget.marital,
                                ward: widget.ward,
                                cooperative: widget.cooperative,
                                household: widget.household,
                                town: widget.town,
                                crops: widget.crops,
                              )));
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  showDeleteDialog(BuildContext context, String requestId) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("yes"),
      onPressed: () async {
        await farmersRef.doc(requestId).get().then((doc) {
          if (doc.exists) {
            doc.reference.delete();
          }
        }).then((value) async {
          Fluttertoast.showToast(
              msg: "Farmer Deleted",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
        });
      },
    );
    Widget continueButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Farmer"),
      content: Text("Would you like to remove this Farmer?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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

class AuthTextFeildLocal extends StatelessWidget {
  const AuthTextFeildLocal({
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
            color: Colors.green,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}
