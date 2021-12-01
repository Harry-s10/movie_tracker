import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  final double size;

  RoundIconButton({@required this.icon, this.onPress, this.size=25.0});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(
        width: size,
        height: size,
      ),
      onPressed: onPress,
      shape: CircleBorder(),
      fillColor: Color(0xFF3B7FC8).withOpacity(0.3),
      elevation: 6.0,
      child: Icon(
        icon,
        color: Colors.blueAccent,
      ),
    );
  }
}
