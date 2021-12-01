import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../constant.dart';
import 'rounded_icon_button.dart';
import 'Classes/editInfo.dart';

class DisplayCard extends StatelessWidget {
  final EditInfo info;
  final Function onPress;
  final Type type;
  final BuildContext context;

  DisplayCard({@required this.info, this.onPress, this.context, this.type});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: displayCard(),
      actions: [
        IconSlideAction(
          caption: "Delete",
          color: Colors.red.withOpacity(0.3),
          iconWidget: Icon(
            CupertinoIcons.delete_solid,
            color: Colors.red,
          ),
          onTap: () {
            kDeleteDialog(context: context, info: info, cancelOnPress: () {});
          },
        ),
      ],
      secondaryActions: [
        info.wStatus == watchStatus.InProgress
            ? IconSlideAction(
                caption: 'Done',
                color: Colors.green.withOpacity(0.3),
                iconWidget: Icon(
                  CupertinoIcons.checkmark_alt,
                  color: Colors.green,
                ),
                onTap: () {
                  kCompleteDialog(context: context, info: info);
                },
              )
            : IconSlideAction(
                caption: 'Rewatch',
                color: Colors.green.withOpacity(0.3),
                iconWidget: Icon(
                  CupertinoIcons.restart,
                  color: Colors.green,
                ),
                onTap: () {
                  if (info.type == Type.Series) {
                    kSeries.doc(info.id).update({
                      'epi_watched': 0,
                      'status': "Completed",
                      'watchStatus': "In-Progress"
                    });
                  } else {
                    kMovie.doc(info.id).update({
                      'watchStatus': "In-Progress",
                    });
                  }
                  // Navigator.pop(context);
                },
              ),
      ],
    );
  }

  Widget displayCard() {
    return Column(
      children: <Widget>[
        TextButton(
          onPressed: onPress,
          child: Material(
            borderRadius: BorderRadius.circular(10.0),
            elevation: 5.0,
            color: Colors.white12,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Name
                          Text(
                            info.name,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),

                          //Year of release
                          Text(
                            info.airingDt.year.toString() +
                                " - " +
                                info.genre.join(', '),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),

                          //Series runtime
                          buildRuntimeText(info.status),
                        ],
                      ),
                    ),

                    // Episode update icons or completed icon
                    Expanded(
                      child: info.wStatus == watchStatus.InProgress
                          ? episodesNumber(info.type)
                          : completedIcon(),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }

  IconButton completedIcon() {
    return IconButton(
        alignment: Alignment.centerRight,
        icon: Icon(
          CupertinoIcons.refresh_circled,
          color: Colors.green.withOpacity(0.7),
          size: 35.0,
        ),
        onPressed: () {
          if (info.type == Type.Series) {
            info.watchedEpi = 0;
            info.wStatus = watchStatus.InProgress;
            kSeries.doc(info.id).update({
              'epi_watched': 0,
              'watchStatus': "In-Progress",
            });
          } else {
            info.wStatus = watchStatus.InProgress;
            kMovie.doc(info.id).update({
              'watchStatus': "In-Progress",
            });
          }
        });
  }

  Widget buildRuntimeText(Status status) {
    if (type == Type.Series) {
      String result;
      if (status == Status.Ongoing) {
        result = "Ongoing: ${kGetShortcut(info.runtime)}";
      } else {
        result = "Completed";
      }
      return Column(
        children: [
          SizedBox(
            height: 8.0,
          ),
          Text(
            result,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget episodesNumber(Type type) {
    if (type == Type.Series) {
      return Row(
        children: [
          RoundIconButton(
            icon: CupertinoIcons.minus,
            onPress: () {
              info.watchedEpi -= 1;
              if (info.watchedEpi < 0) {
                kDeleteDialog(
                    context: context,
                    info: info,
                    cancelOnPress: () {
                      if (info.type == Type.Series) {
                        kSeries.doc(info.id).update({'epi_watched': 0});
                      }
                    });
              }
              kSeries.doc(info.id).update({'epi_watched': info.watchedEpi});
            },
          ),
          Text(
            info.watchedEpi.toString(),
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          RoundIconButton(
            icon: CupertinoIcons.plus,
            onPress: () {
              info.watchedEpi += 1;
              kSeries.doc(info.id).update({'epi_watched': info.watchedEpi});
              if (info.watchedEpi == info.totalEpi) {
                if (info.status == Status.Ongoing) {
                  info.status = Status.Completed;
                }
                kCompleteDialog(context: context, info: info);
              }
            },
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
