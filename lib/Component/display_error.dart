import 'package:flutter/cupertino.dart';

class DisplayError extends StatelessWidget {
  final String imageURL;
  final String caption;

  DisplayError({@required this.imageURL, @required this.caption});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imageURL,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          caption,
          style: TextStyle(fontSize: 18.0),
        )
      ],
    );
  }
}
