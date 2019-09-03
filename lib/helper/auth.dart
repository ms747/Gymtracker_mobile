import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<FirebaseUser> login() async {
  FirebaseUser user = await isLoggedIn();
  if (user == null) {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
  }
  return user;
}

Future<FirebaseUser> isLoggedIn() async {
  final user = await FirebaseAuth.instance.currentUser();
  if (user != null) {
    print("Already Logged In");
  }
  return user;
}

Future<void> logout() {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var futures = <Future>[_googleSignIn.signOut(),_auth.signOut()];
  return Future.wait(futures);
}
