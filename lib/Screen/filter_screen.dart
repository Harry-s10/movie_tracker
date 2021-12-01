import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/Component/build_dropdown.dart';
import 'package:movie_tracker/Component/build_textbutton.dart';
import 'package:filter_list/filter_list.dart';
import 'package:movie_tracker/Component/Classes/query.dart';
import 'package:movie_tracker/constant.dart';

class FilterScreen extends StatefulWidget {
  static const String id = "filter_screen";
  final QueryStmt query;
  FilterScreen({this.query});
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> genreList = kGetGenreList();
  List<String> weekList = kGetWeekList();
  List<String> yearList = List.generate(DateTime.now().year.toInt() - 2000 + 1,
      (index) => (2000 + index).toString());
  List<String> selectedGenreList = [];
  List<String> selectedRuntime = [];

  void _genreFilter() async {
    await FilterListDialog.display(
      context,
      listData: genreList,
      selectedListData: widget.query.genre,
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
            widget.query.genre = List.from(list);
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
        selectedListData: widget.query.runtime, choiceChipLabel: (item) {
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
          widget.query.runtime = List.from(list);
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

  void _airingYearFilter() async {
    await FilterListDialog.display(
      context,
      listData: yearList,
      selectedListData: widget.query.airingYear,
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
            widget.query.airingYear = List.from(list);
          });
        }
        Navigator.pop(context);
      },
      headlineText: "Select Airing Year",
      headerTextColor: Colors.white,
      backgroundColor: Colors.black,
      controlContainerDecoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      controlButtonTextStyle: TextStyle(color: Colors.white),
      applyButonTextBackgroundColor: Colors.green.withOpacity(0.3),
      applyButtonTextStyle: TextStyle(color: Colors.green),
      height: 550.0,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, widget.query),
          ),
          title: Text("Filter"),
        ),
        body: WillPopScope(
          onWillPop: (){
            Navigator.pop(context, widget.query);
            return new Future(()=>false);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Column(
              children: [
                BuildDropDown(
                  title: "Series Status",
                  value: widget.query.getStatus(),
                  onChange: (value) {
                    setState(() {
                        widget.query.status = value;
                    });
                  },
                ),
                BuildDropDown(
                  onChange: (value) {
                    setState(() {
                      widget.query.wStatus = value;
                      if(widget.query.wStatus==watchStatus.Completed){
                        widget.query.status=Status.None;
                      }
                    });
                  },
                  value: widget.query.getWatchStatus(),
                  title: "Watching Status",
                ),
                BuildTextButton(
                  onPress: _genreFilter,
                  value: widget.query.getGenre(),
                  title: "Genre",
                ),
                BuildTextButton(
                  onPress:
                      kNorOps(widget.query.wStatus, widget.query.status) == true
                          ? _runtimeFilter
                          : null,
                  value: widget.query.getRuntime(),
                  title: "Runtime",
                ),
                BuildTextButton(
                  onPress: _airingYearFilter,
                  value: widget.query.getAiringYear(),
                  title: 'Airing Year',
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              widget.query.reset();
                            });
                          },
                          icon: Icon(
                            CupertinoIcons.refresh_bold,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Reset",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.grey.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.pop(context, widget.query);
                          },
                          icon: Icon(
                            CupertinoIcons.line_horizontal_3_decrease,
                            color: Colors.green,
                          ),
                          label: Text(
                            "Apply",
                            style: TextStyle(color: Colors.green),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.green.withOpacity(0.3))),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
