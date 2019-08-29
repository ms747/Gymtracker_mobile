import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _key = new GlobalKey<ScaffoldState>();

  void _showBottomMenu() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        context: _key.currentContext,
        builder: (_) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
              ),
            ),
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          "Welcome, Mayur Shah",
                          style: Theme.of(_key.currentContext).textTheme.title,
                        ),
                      ),
                      Avatar(
                        radius: 60,
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  indent: 30,
                  endIndent: 30,
                ),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text("Logout"),
                  onTap: () {},
                ),
                Divider(
                  color: Colors.black,
                  indent: 30.0,
                  endIndent: 30.0,
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Tracker',
      home: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text('🏋 Gym Tracker'),
          actions: <Widget>[
            FlatButton(
              child: Avatar(
                radius: 20,
              ),
              onPressed: () {
                _showBottomMenu();
              },
            ),
          ],
        ),
        body: Center(
          child: Container(
            child: GridView(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              children: <Widget>[
                ColorTile(col: Colors.red),
                ColorTile(col: Colors.blue),
                ColorTile(col: Colors.amber),
                ColorTile(col: Colors.green),
                ColorTile(col: Colors.red),
                ColorTile(col: Colors.blue),
                ColorTile(col: Colors.amber),
                ColorTile(col: Colors.green),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  final double radius;
  Avatar({@required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: this.radius,
      backgroundImage: NetworkImage(
        "https://lh4.googleusercontent.com/-5kR9LOpxYqA/AAAAAAAAAAI/AAAAAAAABFU/ihjSdIP-dss/photo.jpg",
      ),
    );
  }
}

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
