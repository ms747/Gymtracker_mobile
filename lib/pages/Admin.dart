import 'package:flutter/material.dart';
import 'package:gymtrackerandroid/bloc/User.dart';
import 'package:gymtrackerandroid/components/Data.dart';
import 'package:gymtrackerandroid/components/Modal.dart';
import 'package:gymtrackerandroid/helper/Auth.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserBloc>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: buildAppBar(user, context),
      body: user.loading ? Center(child:CircularProgressIndicator()): buildBody(user, context),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  Widget buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      tooltip: "Add Exercise",
      onPressed: () {
        _showModal(context);
      },
    );
  }

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Modal();
      },
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

  Widget buildBody(UserBloc user, BuildContext context) {
    return Center(child: FirestoreData());
  }

  void doLogout(UserBloc user, BuildContext context) {
    logout().then((_) {
      user.changeLogin(null);
      Navigator.pushReplacementNamed(context, "/");
    });
  }
}
