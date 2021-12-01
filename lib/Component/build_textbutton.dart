import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BuildTextButton extends StatelessWidget {
  const BuildTextButton({
    Key key,
    @required this.onPress,
    @required this.value,
    @required this.title,
  }) : super(key: key);

  final Function onPress;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          Row(
            children: [
              SizedBox(
                width: 170.0,
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.end,
                ),
              ),
              Icon(Icons.keyboard_arrow_right_rounded),
            ],
          )
        ],
      ),
    );
  }
}
