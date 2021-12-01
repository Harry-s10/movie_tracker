import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class BuildDropDown extends StatelessWidget {
  final String title;
  final Function onChange;
  final String value;

  BuildDropDown({this.title, this.value, this.onChange});

  List<DropdownMenuItem> buildItems(){
    if(this.title=="Series Status"){
      return [
        DropdownMenuItem(child: Text("None"), value: Status.None,),
        DropdownMenuItem(child: Text("Ongoing"), value: Status.Ongoing,),
        DropdownMenuItem(
            child: Text("Completed"), value: Status.Completed,),
      ];
    } else{
       return [
        DropdownMenuItem(child: Text("None"), value: watchStatus.None),
        DropdownMenuItem(child: Text("In-progress"), value: watchStatus.InProgress),
        DropdownMenuItem(
            child: Text("Completed"), value: watchStatus.Completed),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton(
              onChanged: onChange,
              items: buildItems(),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.blue,
              ),
              hint: Container(
                width: 90.0,
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.grey, fontSize: 15.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
