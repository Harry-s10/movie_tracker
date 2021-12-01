import 'package:filter_list/filter_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant.dart';
import 'Classes/editInfo.dart';
import 'build_episodetab.dart';
import 'build_textbutton.dart';

class SeriesSelected extends StatefulWidget {
  final BuildContext context;
  final EditInfo info;
  final String pageType;

  SeriesSelected({
    @required this.context,
    @required this.pageType,
    @required this.info,
  });

  @override
  _SeriesSelectedState createState() => _SeriesSelectedState();
}

class _SeriesSelectedState extends State<SeriesSelected> {
  List<String> genreList = kGetGenreList();
  List<String> weekList = kGetWeekList();

  List<String> selectedGenreList = [];
  List<String> selectedYearsList = [];
  List<String> selectedRuntime = [];

  void _genreFilter() async {
    await FilterListDialog.display(
      context,
      listData: genreList,
      selectedListData: widget.info.genre,
      choiceChipLabel: (item) {
        return item;
      },
      validateSelectedItem: (list, val) {
        return list.contains(val);
      },
      onItemSearch: (list, text) {
        if (list.any(
            (element) => element.toLowerCase().contains(text.toLowerCase()))) {
          return list
              .where((element) =>
                  element.toLowerCase().contains(text.toLowerCase()))
              .toList();
        } else {
          return [];
        }
      },
      onApplyButtonClick: (list) {
        if (list != null) {
          setState(() {
            widget.info.genre = [];
            for (var i in list) {
              widget.info.genre.add(i);
            }
          });
        }
        Navigator.pop(context);
      },
      headlineText: "Select Genres",
      headerTextColor: Colors.white,
      backgroundColor: Colors.black,
      controlContainerDecoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      controlButtonTextStyle: TextStyle(color: Colors.white),
      applyButonTextBackgroundColor: Colors.green.withOpacity(0.3),
      applyButtonTextStyle: TextStyle(color: Colors.green),
      height: 620.0,
      closeIconColor: Colors.red.withOpacity(0.8),
      unselectedTextbackGroundColor: Colors.white10,
      selectedTextBackgroundColor: Colors.blueAccent.withOpacity(0.5),
      unselectedChipTextStyle: TextStyle(color: Colors.white),
      buttonRadius: 10.0,
      searchFieldHintText: "Search here",
      searchFieldBackgroundColor: Colors.white12,
      searchFieldTextStyle: TextStyle(color: Colors.white),
    );
  }

  void _runtimeFilter() async {
    await FilterListDialog.display(context,
        listData: weekList,
        selectedListData: widget.info.runtime, choiceChipLabel: (item) {
      return item;
    }, validateSelectedItem: (list, val) {
      return list.contains(val);
    }, onItemSearch: (list, text) {
      if (list.any(
          (element) => element.toLowerCase().contains(text.toLowerCase()))) {
        return list
            .where(
                (element) => element.toLowerCase().contains(text.toLowerCase()))
            .toList();
      } else {
        return [];
      }
    }, onApplyButtonClick: (list) {
      if (list != null) {
        setState(() {
          widget.info.runtime = [];
          widget.info.runtime = List.from(list);
        });
      }
      Navigator.pop(context);
    },
        headlineText: "Select Weekdays",
        headerTextColor: Colors.white,
        backgroundColor: Colors.black,
        controlContainerDecoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        controlButtonTextStyle: TextStyle(color: Colors.white),
        applyButonTextBackgroundColor: Colors.green.withOpacity(0.3),
        applyButtonTextStyle: TextStyle(color: Colors.green),
        hideSearchField: true,
        height: 300.0,
        closeIconColor: Colors.red.withOpacity(0.8),
        unselectedTextbackGroundColor: Colors.white10,
        selectedTextBackgroundColor: Colors.blueAccent.withOpacity(0.5),
        unselectedChipTextStyle: TextStyle(color: Colors.white),
        buttonRadius: 10.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Series Status
        widget.info.type == Type.Series && widget.pageType == 'input'
            ? BuildTextButton(
                onPress: () {
                  setState(() {
                    widget.info.toggleStatus();
                  });
                },
                value: widget.info.status == Status.Ongoing
                    ? "Ongoing"
                    : "Completed",
                title: "Series Status")
            : Container(),

        //Watching Status
        BuildTextButton(
          onPress: () {
            setState(() {
              widget.info.toggleWatchStatus();
              if (widget.info.wStatus == watchStatus.Completed) {
                widget.info.status = Status.Completed;
              } else {
                widget.info.status = Status.Ongoing;
              }
            });
          },
          value: widget.info.wStatus == watchStatus.InProgress
              ? "In-Progress"
              : "Completed",
          title: "Watching Status",
        ),

        // Series/Movie Genre
        BuildTextButton(
            onPress: _genreFilter,
            value: widget.info.genre.length == 0
                ? "None"
                : kGetShortcut(widget.info.genre),
            title: "Genre"),

        // Total Episodes
        widget.info.type == Type.Series
            ? BuildEpisodeTab(
                title: 'Total Episodes',
                minusEpi: () {
                  setState(() {
                    widget.info.totalEpi -= 1;
                    if (widget.info.totalEpi < 0) {
                      widget.info.totalEpi = 0;
                    }
                    if (widget.info.watchedEpi > widget.info.totalEpi &&
                        widget.info.watchedEpi >= 1) {
                      widget.info.watchedEpi = 0;
                    }
                  });
                },
                plusEpi: () {
                  setState(() {
                    widget.info.totalEpi += 1;
                  });
                },
                value: widget.info.totalEpi.toString(),
              )
            : Container(),

        //Watched Episode
        widget.info.type == Type.Series
            ? BuildEpisodeTab(
                minusEpi: () {
                  setState(() {
                    widget.info.watchedEpi -= 1;
                    if (widget.info.watchedEpi < 0) {
                      widget.info.watchedEpi = 0;
                    }
                  });
                },
                plusEpi: () {
                  setState(() {
                    if (widget.info.watchedEpi < widget.info.totalEpi) {
                      widget.info.watchedEpi += 1;
                    }
                  });
                },
                title: "Episodes Watched",
                value: widget.info.watchedEpi.toString(),
              )
            : Container(),

        //Airing Date
        BuildTextButton(
            onPress: () async {
              final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: widget.info.airingDt,
                  firstDate: DateTime(2000, 1),
                  lastDate: DateTime(2101));
              setState(() {
                if (picked != null && picked != widget.info.airingDt) {
                  widget.info.airingDt = picked;
                  if (widget.info.type == Type.Series) {
                    if (widget.info.airingDt.isAfter(DateTime.now())) {
                      widget.info.status = Status.Ongoing;
                      widget.info.watchedEpi = 0;
                    } else if (widget.info.airingDt
                        .isBefore(DateTime(DateTime.now().year))) {
                      widget.info.status = Status.Completed;
                    }
                  }
                }
              });
            },
            value:
                DateFormat('dd-MMM-y').format(widget.info.airingDt).toString(),
            title: 'Airing Date'),

        // Runtime
        widget.info.type == Type.Series && widget.info.status == Status.Ongoing
            ? BuildTextButton(
                onPress: _runtimeFilter,
                title: "Runtime",
                value: widget.info.runtime.length == 0
                    ? "None"
                    : kGetShortcut(widget.info.runtime),
              )
            : Container(),
      ],
    );
  }
}
