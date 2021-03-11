import 'package:agritechpro/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgentHome extends StatefulWidget {
  @override
  _AgentHomeState createState() => _AgentHomeState();
}

class _AgentHomeState extends State<AgentHome> {
  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: Colors.white,
        title: Text('Agent Home',
            style: TextStyle(
              color: Colors.green,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
        titleSpacing: 20.0,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                HomeCard(
                  icon: Icons.add,
                  title: 'Add Farmers',
                  onTap: () {
                    Navigator.of(context).pushNamed('/farmers');
                  },
                ),
                HomeCard(
                  icon: Icons.supervised_user_circle,
                  title: 'View All Farmers',
                  onTap: () {
                    Navigator.of(context).pushNamed('/allFarmers');
                  },
                ),
                HomeCard(
                  icon: Icons.person,
                  title: 'My Profile',
                  onTap: () {
                    Navigator.of(context).pushNamed('/profile');
                  },
                ),
              ],
            ),
            Row(
              children: [
                HomeCard(
                  icon: Icons.exit_to_app,
                  title: 'Logout',
                  onTap: () {
                    authBloc.signOutUser().then((value) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (r) => false);
                    });
                  },
                ),
                // HomeCard(
                //   icon: Icons.work,
                //   title: 'Market Place',
                //   onTap: () {
                //     Navigator.of(context).pushNamed('/adminMarket');
                //   },
                // ),
                // HomeCard(
                //   icon: Icons.people_alt,
                //   title: 'Membership Data',
                //   onTap: () {
                //     Navigator.of(context).pushNamed('/membership');
                //   },
                // ),
              ],
            ),
            // Row(
            //   children: [
            //     HomeCard(
            //       icon: Icons.people_rounded,
            //       title: 'First Timers',
            //       onTap: () {
            //         Navigator.of(context).pushNamed('/firstTimers');
            //       },
            //     ),
            //     HomeCard(
            //       icon: Icons.article,
            //       title: 'Articles',
            //       onTap: () {
            //         Navigator.of(context).pushNamed('/adminArticles');
            //       },
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key key,
    this.title,
    this.icon,
    this.onTap,
  }) : super(key: key);
  final IconData icon;
  final Function onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.285,
            height: MediaQuery.of(context).size.height * 0.15,
            margin:
                EdgeInsets.only(top: 17.5, bottom: 5.0, left: 7.0, right: 7.0),
            //padding: EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 2.5),
                  blurRadius: 10.5,
                ),
              ],
            ),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.red,
                      size: 35.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(
            '$title',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
