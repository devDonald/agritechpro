import 'package:agritechpro/authentication/login.dart';
import 'package:agritechpro/screens/add_farmer.dart';
import 'package:agritechpro/screens/all_farmers.dart';
import 'package:agritechpro/screens/home.dart';
import 'package:agritechpro/screens/profile.dart';
import 'package:agritechpro/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

final authId = AuthService();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => authId),

        // See implementation details in next sections
      ],
      child: MyApp(),
    ),
  );

  @override
  void dispose() {
    authId.dispose();
  }
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final deviceWidth = MediaQuery.of(context).size.width;
    //final deviceHeight = MediaQuery.of(context).size.height;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //default theme

      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/home': (context) => AgentHome(),
        '/profile': (context) => ProfilePage(),
        '/farmers': (context) => AddFarmers(),
        '/allFarmers': (context) => AllFarmers(),
      },
    );
  }
}
