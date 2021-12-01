import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/Component/display_cards.dart';
import 'package:movie_tracker/Component/display_error.dart';
import 'package:movie_tracker/Screen/edit_screen.dart';
import 'Classes/editInfo.dart';
import 'Classes/query.dart';
import '../constant.dart';

class MoviesCards extends StatelessWidget {
  final QueryStmt query;
  MoviesCards({this.query});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: kMovie.orderBy('watchStatus', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final moviesData = snapshot.data.docs.map((DocumentSnapshot documents) {
          return EditInfo(
            uid: documents['uid'],
            id: documents.id,
            genre: documents['genre'],
            name: documents['name'],
            airingDt: DateTime.parse(documents['airingDt'].toDate().toString()),
            type: Type.Movie,
            wStatus: documents['watchStatus'] == "In-Progress"
                ? watchStatus.InProgress
                : watchStatus.Completed,
          );
        });
        List<DisplayCard> moviesList = [];
        if (moviesData.isEmpty) {
          return DisplayError(
            imageURL: 'images/gummy-tv-room.png',
            caption: "Nothing to binge at this moment!",
          );
        } else {
          var filterMoviesData = moviesData.where((element) =>
              element.uid == FirebaseAuth.instance.currentUser.uid);
          if (filterMoviesData.length == 0) {
            return DisplayError(
              imageURL: 'images/Nothing-Found-Illustration.png',
              caption: "No matching found",
            );
          }
          filterMoviesData = filterMoviesData.where((element) {
            if (query.wStatus == watchStatus.None) {
              if (query.genre.isNotEmpty) {
                if (query.genre.every((item) => element.genre.contains(item))) {
                  if (query.airingYear.isNotEmpty) {
                    if (query.airingYear.every(
                        (item) => element.airingDt.year.toString() == item)) {
                      return true;
                    }
                  } else {
                    return true;
                  }
                }
              } else {
                if (query.airingYear.isNotEmpty) {
                  if (query.airingYear
                      .contains(element.airingDt.year.toString())) {
                    return true;
                  }
                } else {
                  return true;
                }
              }
            } else if (query.wStatus == element.wStatus) {
              if (query.genre.isNotEmpty) {
                if (query.genre.every((item) => element.genre.contains(item))) {
                  if (query.airingYear.isNotEmpty) {
                    if (query.airingYear.every(
                        (item) => element.airingDt.year.toString() == item)) {
                      return true;
                    }
                  } else {
                    return true;
                  }
                }
              } else {
                if (query.airingYear.isNotEmpty) {
                  if (query.airingYear
                      .contains(element.airingDt.year.toString())) {
                    return true;
                  }
                } else {
                  return true;
                }
              }
            }
            return false;
          });
          if (filterMoviesData.length == 0) {
            return DisplayError(
              imageURL: 'images/Nothing-Found-Illustration.png',
              caption: 'No result found!',
            );
          }
          for (EditInfo movieInfo in filterMoviesData) {
            if (movieInfo.name != null && movieInfo.type != null) {
              final movieCard = DisplayCard(
                type: Type.Movie,
                context: context,
                info: movieInfo,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditScreen(
                                info: movieInfo,
                              )));
                },
              );
              moviesList.add(movieCard);
            } else {
              return DisplayError(
                imageURL: 'images/something-wrong.png',
                caption: "Something went wrong!",
              );
            }
          }
        }
        return ListView(
          children: moviesList,
        );
      },
    );
  }
}
