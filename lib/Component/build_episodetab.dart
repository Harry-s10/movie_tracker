import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/Component/rounded_icon_button.dart';

class BuildEpisodeTab extends StatelessWidget {
  const BuildEpisodeTab({
    Key key,
    @required this.minusEpi,
    @required this.plusEpi,
    @required this.title,
    @required this.value,
  }) : super(key: key);

  final Function minusEpi;
  final Function plusEpi;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundIconButton(
                icon: CupertinoIcons.minus,
                size: 32.0,
                onPress: minusEpi,
              ),
              Text(
                value,
                style: TextStyle(fontSize: 22.0),
              ),
              RoundIconButton(
                icon: CupertinoIcons.plus,
                size: 32.0,
                onPress: plusEpi,
              ),
            ],
          ),
        ],
      ),
    );
  }
}