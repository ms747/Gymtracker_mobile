import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> login() async {
  bool status = await isLoggedIn();
  if (!status) {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
  }
}

Future<bool> isLoggedIn() async {
  bool loggedIn = false;
  final user = await FirebaseAuth.instance.currentUser();
  if (user != null) {
    loggedIn = true;
    print("Already Logged In");
  }
  return loggedIn;
}

Future<void> logout() {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  return _auth.signOut();
}
