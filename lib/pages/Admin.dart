import 'package:flutter/material.dart';
import 'package:gymtrackerandroid/bloc/Direction.dart';
import 'package:gymtrackerandroid/bloc/User.dart';
import 'package:gymtrackerandroid/components/Data.dart';
import 'package:gymtrackerandroid/components/Modal.dart';
import 'package:gymtrackerandroid/helper/Auth.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  final directionBloc = DirectionBloc();
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserBloc>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: buildAppBar(user, context),
      body: user.loading
          ? Center(child: CircularProgressIndicator())
          : buildBody(user, context, directionBloc),
      floatingActionButton: FAB(directionBloc),
    );
  }

  Widget buildAppBar(UserBloc user, BuildContext context) {
    return AppBar(
      title: Text("Dashboard"),
      actions: <Widget>[buildProfileIcon(user, context)],
    );
  }

  Widget buildProfileIcon(UserBloc user, BuildContext context) {
    return InkWell(
      onTap: () {
        doLogout(user, context);
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(user.user.photoUrl),
        ),
      ),
    );
  }

  Widget buildBody(
      UserBloc user, BuildContext context, DirectionBloc directionBloc) {
    return Center(child: FirestoreData(directionBloc));
  }

  void doLogout(UserBloc user, BuildContext context) {
    logout().then((_) {
      user.changeLogin(null);
      Navigator.pushReplacementNamed(context, "/");
    });
  }
}

class FAB extends StatefulWidget {
  final DirectionBloc directionBloc;

  FAB(this.directionBloc);

  @override
  _FABState createState() => _FABState();
}

class _FABState extends State<FAB> {
  @override
  Widget build(BuildContext context) {
    return Stack(overflow: Overflow.visible, children: [
      ChangeNotifierProvider.value(
        value: widget.directionBloc,
        //builder: (_) => widget.directionBloc,
        child: Consumer<DirectionBloc>(
          builder: (ctx, data, _) {
            return AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              bottom: data.visible ? 0 : -200,
              right: 0,
              child: FloatingActionButton(
                child: Icon(Icons.add),
                tooltip: "Add Exercise",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return Modal();
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    ]);
  }
}
