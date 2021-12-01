import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_tracker/Component/Classes/editInfo.dart';
import 'package:movie_tracker/Component/build_textbutton.dart';
import 'package:movie_tracker/Component/series_selected.dart';
import 'package:movie_tracker/constant.dart';

class InputScreen extends StatefulWidget {
  static const String id = "input_screen";
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  EditInfo info = EditInfo(
    runtime: [],
    genre: [],
    airingDt: DateTime.now(),
  );
  var currUsedID = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add'),
        actions: [
          TextButton(
            onPressed: () {
              if (info.type == Type.Series) {
                kSeries.add({
                  'name': info.name,
                  'genre': info.genre,
                  'runtime': info.runtime,
                  //TODO change it to Ongoing and Completed
                  'status':
                      info.status == Status.Ongoing ? "Ongoing" : "Completed",
                  'total_epi': info.totalEpi,
                  'epi_watched': info.watchedEpi,
                  'uid': currUsedID,
                  'airingDt': info.airingDt,
                  'watchStatus': info.wStatus == watchStatus.InProgress
                      ? "In-Progress"
                      : "Completed",
                });
              } else {
                kMovie.add({
                  'name': info.name,
                  'genre': info.genre,
                  'uid': currUsedID,
                  'airingDt': info.airingDt,
                  'watchStatus': info.wStatus == watchStatus.InProgress
                      ? "In-Progress"
                      : "Completed",
                });
              }
              Navigator.pop(context);
            },
            child: Text(
              "Save",
              style: TextStyle(color: Colors.blue, fontSize: 20.0),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                  // validator: (value) {
                  //   return value == null
                  //       ? "Enter " +
                  //       (info.type == Type.Series
                  //           ? "Series Name"
                  //           : "Movie Name")
                  //       : null;
                  // },
                  onChanged: (value) {
                    setState(() {
                      info.name = value;
                    });
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: info.type == Type.Series
                          ? "Series Name"
                          : "Movie Name")),
              SizedBox(
                height: 16.0,
              ),
              //Radio Button
              BuildTextButton(onPress: (){
                setState(() {
                  info.toggleType();
                });
              }, value: info.type==Type.Series?"Series":"Movie", title: "Type"),
              //If Series will show the episode card

              SeriesSelected(
                context: context,
                pageType: 'input',
                info: info,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
