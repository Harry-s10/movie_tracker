import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/Screen/filter_screen.dart';
import 'package:movie_tracker/Screen/welcome_screen.dart';
import 'Screen/edit_screen.dart';
import 'Screen/homepage_screen.dart';
import 'Screen/input_screen.dart';
import 'Screen/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MovieTracker());
}

class MovieTracker extends StatefulWidget {
  @override
  _MovieTrackerState createState() => _MovieTrackerState();
}

class _MovieTrackerState extends State<MovieTracker> {
  // final QueryStmt query = QueryStmt(
  //   genre: [],
  //   runtime: [],
  //   airingYear: [],
  //   status: Status.Ongoing,
  //   wStatus: watchStatus.InProgress,
  // );
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          // if(snapshot.hasError){
          //   return SomethingWentWrong();
          // }
          // else {
          return buildMaterialApp();
          // }
        });
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? HomepageScreen.id
          : WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        HomepageScreen.id: (context) => HomepageScreen(),
        InputScreen.id: (context) => InputScreen(),
        EditScreen.id: (context) => EditScreen(),
        FilterScreen.id: (context) => FilterScreen(),
      },
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black54,
        accentColor: Colors.blueAccent,
        accentColorBrightness: Brightness.light,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black.withOpacity(0)
        )
      ),
    );
  }
}
