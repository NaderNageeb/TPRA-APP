// ignore_for_file: prefer_const_constructors
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tpra/app/auth/login.dart';
import 'package:tpra/app/auth/register.dart';
import 'package:tpra/app/comments.dart';
import 'package:tpra/app/home.dart';
import 'package:tpra/app/likedPost.dart';
import 'package:tpra/app/myPosts.dart';
import 'package:tpra/app/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/add_posts.dart';
import 'app/profile.dart';
import 'app/reports.dart';

late SharedPreferences sharedPref;

void main() async {
  // ican retch to sharedprefrance in any were inside the app

  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TPRA',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.black,
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        // textTheme: textTheme,
      ),

      initialRoute: sharedPref.getString("user_id") == null ? "/" : "home",
      //  initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        'home': (context) => Home(),
        'login': (context) => Login(),
        'signup': (context) => Register(),
        'addposts': (context) => AddPosts(),
        'comments': (context) => Comments(),
        'profile': (context) => Profile(),
        'reports': (context) => Reports(),
        'likedPost': (context) => LikedPosts(),
        'myposts': (context) => MyPosts(),

        
      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
