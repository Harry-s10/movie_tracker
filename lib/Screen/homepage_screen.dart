import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/Component/Classes/query.dart';
import 'package:movie_tracker/Component/movie_cards.dart';
import 'package:movie_tracker/Component/series_cards.dart';
import 'package:movie_tracker/Screen/input_screen.dart';
import 'package:movie_tracker/constant.dart';
import 'filter_screen.dart';

class HomepageScreen extends StatefulWidget {
  static const String id = "homepage_screen";
  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final List<Tab> trackerTab = [Tab(text: "Series"), Tab(text: "Movies")];
  QueryStmt query = QueryStmt(
      genre: [],
      runtime: [],
      airingYear: [],
      wStatus: watchStatus.InProgress,
      status: Status.None);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('Binge Tracker 🎬'),
              actions: [
                Container(
                  child: IconButton(
                    onPressed: () async {
                      query = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FilterScreen(query: query)));
                      setState(() {
                        MoviesCards(
                          query: query,
                        );
                        SeriesCards(
                          query: query,
                        );
                      });
                    },
                    icon: Icon(
                      CupertinoIcons.sort_down,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, InputScreen.id);
                    },
                    icon: Icon(
                      CupertinoIcons.add_circled,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
              bottom: TabBar(
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: Colors.blueAccent)),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: trackerTab,
              ),
            ),
            body: TabBarView(children: [
              SeriesCards(
                query: query,
              ),
              MoviesCards(
                query: query,
              ),
            ])),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to logout?'),
              actions: [
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No'),
                ),
                SizedBox(height: 16),
                new GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Yes"),
                )
              ],
            ));
  }
}
