import 'package:agritechpro/screens/view_user.dart';
import 'package:agritechpro/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchName extends StatefulWidget {
  static const String id = 'SearchName';
  final String tag;

  const SearchName({Key key, this.tag}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _SearchState();
  }
}

class _SearchState extends State<SearchName> {
  TextEditingController searchController = new TextEditingController();
  String filter;

  @override
  initState() {
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 3.0,
          titleSpacing: -15.0,
          backgroundColor: Colors.red,
          title: new TextFormField(
            textCapitalization: TextCapitalization.sentences,
            controller: searchController,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
              hintText: 'Search by name ...',
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                searchController.clear();
              },
              icon: Icon(Icons.clear),
              tooltip: 'clear',
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: farmersRef.orderBy('name', descending: false).snapshots(),
            builder: (context, snapshot) {
              return new ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot snap = snapshot.data.docs[index];
                  //String date = timeago.format(snap['timestamp'].toDate());
                  return filter == null || filter == ""
                      ? ListTile(
                          contentPadding: EdgeInsets.all(0.5),
                          title: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text('${snap['name']}'),
                          ),
                          subtitle: Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text('${snap['town']}'),
                          ),
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewFarmer(
                                      userId: snap['farmerId'],
                                      name: snap['name'],
                                      occupation: snap['occupation'],
                                      address: snap['address'],
                                      phone: snap['phone'],
                                      email: snap['email'],
                                      photo: snap['photo'],
                                      household: snap['household'],
                                      town: snap['town'],
                                      state: snap['state'],
                                      ward: snap['ward'],
                                      marital: snap['marital'],
                                      dob: snap['dob'],
                                      fin: snap['FIN'],
                                      gender: snap['gender'],
                                      cooperative: snap['cooperative'],
                                      crops: snap['crops'],
                                    ),
                                  ));
                            });
                          })
                      : '${snap['name']}  ${snap['town']}'
                              .toLowerCase()
                              .contains(filter.toLowerCase())
                          ? ListTile(
                              contentPadding: EdgeInsets.all(0.5),
                              title: Container(
                                padding: EdgeInsets.all(10.0),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '${snap['name'].substring(0, filter.length)}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text:
                                            '${snap['name'].substring(filter.length)}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              subtitle: Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  '${snap['town']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewFarmer(
                                          userId: snap['farmerId'],
                                          name: snap['name'],
                                          occupation: snap['occupation'],
                                          address: snap['address'],
                                          phone: snap['phone'],
                                          email: snap['email'],
                                          photo: snap['photo'],
                                          household: snap['household'],
                                          town: snap['town'],
                                          state: snap['state'],
                                          ward: snap['ward'],
                                          marital: snap['marital'],
                                          dob: snap['dob'],
                                          fin: snap['FIN'],
                                          gender: snap['gender'],
                                          cooperative: snap['cooperative'],
                                          crops: snap['crops'],
                                        ),
                                      ));
                                });
                              })
                          : new Container();
                },
              );
            }));
  }
}

class SearchItem {
  final String address;
  final String name;
  final String route;

  const SearchItem({this.address, this.name, this.route});
}
