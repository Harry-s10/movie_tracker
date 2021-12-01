import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/Component/Classes/editInfo.dart';
import 'package:movie_tracker/Component/series_selected.dart';

import '../constant.dart';

class EditScreen extends StatefulWidget {
  static const String id = "edit_screen";
  final EditInfo info;

  EditScreen({this.info});

  @override
  _EditScreenState createState() => _EditScreenState(info: info);
}

class _EditScreenState extends State<EditScreen> {
  final EditInfo info;
  _EditScreenState({this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Edit'),
        actions: [
          TextButton(
            onPressed: () {
              if (info.type == Type.Series) {
                if (info.status == Status.Ongoing) {
                  kSeries.doc(info.id).update({
                    'name': info.name,
                    'genre': info.genre,
                    'total_epi': info.totalEpi,
                    'epi_watched': info.watchedEpi,
                    'runtime': info.runtime,
                    'airingDt': info.airingDt,
                    'watchStatus': info.wStatus == watchStatus.InProgress
                        ? "In-Progress"
                        : "Completed",
                  });
                } else {
                  kSeries.doc(info.id).update({
                    'name': info.name,
                    'genre': info.genre,
                    'total_epi': info.totalEpi,
                    'epi_watched': info.watchedEpi,
                    'airingDt': info.airingDt,
                    'watchStatus': info.wStatus == watchStatus.InProgress
                        ? "In-Progress"
                        : "Completed",
                  });
                }
              } else {
                kMovie.doc(info.id).update({
                  'name': info.name,
                  'genre': info.genre,
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
                  validator: (value) {
                    return value == null
                        ? "Enter " +
                            (info.type == Type.Series
                                ? "Series Name"
                                : "Movie Name")
                        : null;
                  },
                  initialValue: info.name,
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
              //If Series will show the episode card
              SeriesSelected(
                context: context,
                pageType: 'edit',
                info: info,
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.red.withOpacity(0.1))),
                  label: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                  icon: Icon(
                    CupertinoIcons.delete_solid,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    kDeleteDialog(
                        context: context,
                        info: info,
                        cancelOnPress: () {});
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
