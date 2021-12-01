import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/Component/display_cards.dart';
import 'package:movie_tracker/Screen/edit_screen.dart';
import 'Classes/editInfo.dart';
import '../constant.dart';
import 'Classes/query.dart';
import 'display_error.dart';

class SeriesCards extends StatelessWidget {
  final QueryStmt query;
  SeriesCards({this.query});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: kSeries.orderBy('watchStatus', descending: true).snapshots(),
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
        final seriesData = snapshot.data.docs.map((DocumentSnapshot documents) {
          return EditInfo(
            uid: documents['uid'],
            id: documents.id,
            genre: documents['genre'],
            name: documents['name'],
            type: Type.Series,
            totalEpi: documents['total_epi'],
            watchedEpi: documents['epi_watched'],
            airingDt: DateTime.parse(documents['airingDt'].toDate().toString()),
            status: documents['status'] == "Ongoing"
                ? Status.Ongoing
                : Status.Completed,
            runtime:
                documents['status'] == "Ongoing" ? documents["runtime"] : [],
            wStatus: documents['watchStatus'] == "In-Progress"
                ? watchStatus.InProgress
                : watchStatus.Completed,
          );
        });
        // print(seriesData)
        List<DisplayCard> seriesList = [];
        if (seriesData.isEmpty) {
          return DisplayError(
            imageURL: 'images/gummy-tv-room.png',
            caption: "Nothing to binge at this moment!",
          );
        } else {
          var filterSeriesData = seriesData.where((element) =>
              element.uid == FirebaseAuth.instance.currentUser.uid);
          if (filterSeriesData.length == 0) {
            return DisplayError(
              imageURL: 'images/Nothing-Found-Illustration.png',
              caption: "No matching found!",
            );
          }
          filterSeriesData = filterSeriesData.where((element) {
            if (query.wStatus == watchStatus.None) {
              if (query.status == Status.None) {
                if (query.genre.isNotEmpty) {
                  if (query.genre
                      .every((item) => element.genre.contains(item))) {
                    if (query.runtime.isNotEmpty) {
                      if (query.runtime
                          .every((item) => element.runtime.contains(item))) {
                        if (query.airingYear.isNotEmpty) {
                          if (query.airingYear.every((item) =>
                              element.airingDt.year.toString() == item)) {
                            return true;
                          }
                        } else {
                          return true;
                        }
                      }
                    } else {
                      if (query.airingYear.isNotEmpty) {
                        if (query.airingYear.every((item) =>
                            element.airingDt.year.toString() == item)) {
                          return true;
                        }
                      } else {
                        return true;
                      }
                    }
                  }
                } else {
                  if (query.runtime.isNotEmpty) {
                    if (query.runtime
                        .every((item) => element.runtime.contains(item))) {
                      if (query.airingYear.isNotEmpty) {
                        if (query.airingYear.every((item) =>
                            element.airingDt.year.toString() == item)) {
                          return true;
                        }
                      } else {
                        return true;
                      }
                    }
                  } else {
                    if (query.airingYear.isNotEmpty) {
                      if (query.airingYear.every(
                          (item) => element.airingDt.year.toString() == item)) {
                        return true;
                      }
                    } else {
                      return true;
                    }
                  }
                }
              } else if (query.status == element.status) {
                if (query.genre.isNotEmpty) {
                  if (query.genre
                      .every((item) => element.genre.contains(item))) {
                    if (query.runtime.isNotEmpty) {
                      if (query.runtime
                          .every((item) => element.runtime.contains(item))) {
                        if (query.airingYear.isNotEmpty) {
                          if (query.airingYear.every((item) =>
                              element.airingDt.year.toString() == item)) {
                            return true;
                          }
                        } else {
                          return true;
                        }
                      }
                    } else {
                      if (query.airingYear.isNotEmpty) {
                        if (query.airingYear.every((item) =>
                            element.airingDt.year.toString() == item)) {
                          return true;
                        }
                      } else {
                        return true;
                      }
                    }
                  }
                } else {
                  if (query.runtime.isNotEmpty) {
                    if (query.runtime
                        .every((item) => element.runtime.contains(item))) {
                      if (query.airingYear.isNotEmpty) {
                        if (query.airingYear.every((item) =>
                            element.airingDt.year.toString() == item)) {
                          return true;
                        }
                      } else {
                        return true;
                      }
                    }
                  } else {
                    if (query.airingYear.isNotEmpty) {
                      if (query.airingYear.every(
                          (item) => element.airingDt.year.toString() == item)) {
                        return true;
                      }
                    } else {
                      return true;
                    }
                  }
                }
              }
            } else if (query.wStatus == element.wStatus) {
              if (query.status == Status.None) {
                if (query.genre.isNotEmpty) {
                  if (query.genre
                      .every((item) => element.genre.contains(item))) {
                    if (query.runtime.isNotEmpty) {
                      if (query.runtime
                          .every((item) => element.runtime.contains(item))) {
                        if (query.airingYear.isNotEmpty) {
                          if (query.airingYear.every((item) =>
                              element.airingDt.year.toString() == item)) {
                            return true;
                          }
                        } else {
                          return true;
                        }
                      }
                    } else {
                      if (query.airingYear.isNotEmpty) {
                        if (query.airingYear.every((item) =>
                            element.airingDt.year.toString() == item)) {
                          return true;
                        }
                      } else {
                        return true;
                      }
                    }
                  }
                } else {
                  if (query.runtime.isNotEmpty) {
                    if (query.runtime
                        .every((item) => element.runtime.contains(item))) {
                      if (query.airingYear.isNotEmpty) {
                        if (query.airingYear.every((item) =>
                            element.airingDt.year.toString() == item)) {
                          return true;
                        }
                      } else {
                        return true;
                      }
                    }
                  } else {
                    if (query.airingYear.isNotEmpty) {
                      if (query.airingYear.every(
                          (item) => element.airingDt.year.toString() == item)) {
                        return true;
                      }
                    } else {
                      return true;
                    }
                  }
                }
              } else if (query.status == element.status) {
                if (query.genre.isNotEmpty) {
                  if (query.genre
                      .every((item) => element.genre.contains(item))) {
                    if (query.runtime.isNotEmpty) {
                      if (query.runtime
                          .every((item) => element.runtime.contains(item))) {
                        if (query.airingYear.isNotEmpty) {
                          if (query.airingYear.every((item) =>
                              element.airingDt.year.toString() == item)) {
                            return true;
                          }
                        } else {
                          return true;
                        }
                      }
                    } else {
                      if (query.airingYear.isNotEmpty) {
                        if (query.airingYear.every((item) =>
                            element.airingDt.year.toString() == item)) {
                          return true;
                        }
                      } else {
                        return true;
                      }
                    }
                  }
                } else {
                  if (query.runtime.isNotEmpty) {
                    if (query.runtime
                        .every((item) => element.runtime.contains(item))) {
                      if (query.airingYear.isNotEmpty) {
                        if (query.airingYear.every((item) =>
                            element.airingDt.year.toString() == item)) {
                          return true;
                        }
                      } else {
                        return true;
                      }
                    }
                  } else {
                    if (query.airingYear.isNotEmpty) {
                      if (query.airingYear.every(
                          (item) => element.airingDt.year.toString() == item)) {
                        return true;
                      }
                    } else {
                      return true;
                    }
                  }
                }
              }
            }
            return false;
          });
          if (filterSeriesData.length == 0) {
            return DisplayError(
              imageURL: 'images/Nothing-Found-Illustration.png',
              caption: "No matching found!",
            );
          }
          for (EditInfo serieInfo in filterSeriesData) {
            if (serieInfo.uid == FirebaseAuth.instance.currentUser.uid) {
              if (serieInfo.name != null && serieInfo.type != null) {
                final serieCard = DisplayCard(
                  type: Type.Series,
                  context: context,
                  info: serieInfo,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditScreen(
                                  info: serieInfo,
                                )));
                  },
                );
                seriesList.add(serieCard);
              } else {
                return Expanded(
                    child: DisplayError(
                  imageURL: 'images/something-wrong.png',
                  caption: "Something went wrong!",
                ));
              }
            }
          }
        }
        return ListView(
          children: seriesList,
        );
      },
    );
  }
}
