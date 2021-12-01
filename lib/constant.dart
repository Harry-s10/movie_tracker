import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Component/Classes/editInfo.dart';

const kTextFieldDecoration = InputDecoration(
  labelText: 'Value',
  labelStyle: TextStyle(color: Colors.blueAccent, fontSize: 16.0),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.white12, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.white, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);

enum Type { Series, Movie }

enum Status { Ongoing, Completed, None }

enum watchStatus { InProgress, Completed, None }

CollectionReference kMovie = FirebaseFirestore.instance.collection('Movies');

CollectionReference kSeries = FirebaseFirestore.instance.collection('Series');

void kDeleteDialog(
    {BuildContext context, EditInfo info, Function cancelOnPress}) {
  AwesomeDialog(
      context: context,
      dialogBackgroundColor: Colors.black54,
      dialogType: DialogType.QUESTION,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Delete',
      desc: 'Are you sure?',
      btnCancelText: 'No',
      btnCancelColor: Colors.grey,
      btnCancelOnPress: cancelOnPress,
      btnOkText: 'Yes',
      btnOkColor: Colors.red,
      btnOkOnPress: () {
        if (info.type == Type.Series) {
          kSeries.doc(info.id).delete();
        } else {
          kMovie.doc(info.id).delete();
        }
      })
    ..show();
}

void kCompleteDialog({BuildContext context, EditInfo info}) {
  AwesomeDialog(
      context: context,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      dialogBackgroundColor: Colors.black54,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Completed!',
      desc: (info.type == Type.Series)
          ? 'You have completed the series.'
          : 'You have completed the movie.',
      btnCancelText: 'Rewatch',
      btnCancelIcon: CupertinoIcons.restart,
      btnCancelOnPress: () {
        if (info.type == Type.Series) {
          kSeries.doc(info.id).update({
            'epi_watched': 0,
            'status': "Completed",
            'watchStatus': "In-Progress"
          });
        }
        // Navigator.pop(context);
      },
      btnOkText: '',
      btnOkIcon: CupertinoIcons.checkmark,
      btnOkOnPress: () {
        if (info.type == Type.Series) {
          kSeries.doc(info.id).update({
            'status': "Completed",
            'watchStatus': "Completed",
            'epi_watched': info.totalEpi
          });
        } else {
          kMovie.doc(info.id).update({'watchStatus': "Completed"});
        }
        // Navigator.pop(context);
      })
    ..show();
}

String kGetShortcut(List<dynamic> list) {
  var result = [];
  list.forEach((item) {
    result.add(item.substring(0, 3));
  });
  return result.join(", ").toString();
}

String kGetYearShortcut(List<dynamic> list) {
  var result = [];
  list.forEach((element) {
    result.add(element.substring(2));
  });
  return result.join(", ").toString();
}

bool kNorOps(watchStatus wStatus, Status status) {
  if (wStatus == watchStatus.Completed && status == Status.Completed) {
    return false;
  } else if (wStatus != watchStatus.Completed && status == Status.Completed) {
    return false;
  } else if (wStatus == watchStatus.Completed && status != Status.Completed) {
    return false;
  } else {
    return true;
  }
}

List<String> kGetGenreList() {
  return [
    "Action",
    "Adult",
    "Adventure",
    "Animation",
    "Comedy",
    "Drama",
    "Family",
    "Fantasy",
    "Horror",
    "Musical",
    "Mystery",
    "Reality TV",
    "Romantic",
    "Sci-Fi",
    "Sport",
    "Suspense",
    "Thriller",
    "War",
    "Korean",
    "Japanese",
    "Chinese",
    "Hollywood",
    "Bollywood",
    "Melodrama"
  ];
}

List<String> kGetWeekList() {
  return [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
}
