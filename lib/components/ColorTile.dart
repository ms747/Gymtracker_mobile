import 'package:flutter/material.dart';

class ColorTile extends StatelessWidget {
  final Color col;
  ColorTile({@required this.col});
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Container(
        decoration: BoxDecoration(
          color: this.col,
        ),
      ),
    );
  }
}
