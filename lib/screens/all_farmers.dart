import 'package:agritechpro/resources/resources.dart';
import 'package:agritechpro/screens/search.dart';
import 'package:agritechpro/screens/view_user.dart';
import 'package:agritechpro/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllFarmers extends StatefulWidget {
  AllFarmers({Key key}) : super(key: key);

  @override
  _AllFarmersState createState() => _AllFarmersState();
}

class _AllFarmersState extends State<AllFarmers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: Colors.green,
        title: Text('All Farmers',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
        titleSpacing: -5.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchName(
                            tag: 'name',
                          ),
                        ));
                  });
                },
                child: Icon(Icons.search)),
          )
        ],
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: farmersRef.orderBy('name', descending: false).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading..."),
                );
              } else if (!snapshot.hasData) {
                return Center(
                  child: Text("Loading..."),
                );
              }
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot snap = snapshot.data.docs[index];

                    return FarmerCard(
                      image: snap['photo'],
                      fullName: '${snap['name']}',
                      gender: snap['gender'],
                      occupation: snap['occupation'],
                      location: snap['address'],
                      onTap: () {
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
                                fin: snap['FIN'],
                                household: snap['household'],
                                town: snap['town'],
                                state: snap['state'],
                                ward: snap['ward'],
                                marital: snap['marital'],
                                dob: snap['dob'],
                                gender: snap['gender'],
                                cooperative: snap['cooperative'],
                                crops: snap['crops'],
                              ),
                            ));
                      },
                    );
                  });
            }),
      ),
    );
  }
}
