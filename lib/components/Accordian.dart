import 'package:flutter/material.dart';

import 'ColorTile.dart';

class MyAccordian extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Exercise Name",
                    style: Theme.of(context).textTheme.title,
                  ),
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      List<PopupMenuEntry> choices = [
                        _buildPopupMenuItem(value: "edit", icon: Icons.edit, label: "Edit"),
                        _buildPopupMenuItem(value: "delete", icon: Icons.delete, label: "Delete"),
                      ];
                      return choices;
                    },
                    onSelected: (x) {
                      print(x);
                    },
                  )
                ],
              ),
              Padding(padding: EdgeInsets.all(5)),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
                children: <Widget>[
                  ColorTile(
                    col: Colors.red,
                  ),
                  ColorTile(
                    col: Colors.blue,
                  ),
                  ColorTile(
                    col: Colors.red,
                  ),
                  ColorTile(
                    col: Colors.blue,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem({@required value, @required IconData icon, @required String label}) {
    return PopupMenuItem(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(icon),
          Text(label),
        ],
      ),
    );
  }
}
