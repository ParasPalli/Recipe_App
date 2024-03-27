// Function to sign out the user
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> handleSignIn() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = authResult.user;

    if (user != null) {
      // Successfully signed in with Google
      print('Signed in with Google: ${user.displayName}');
    } else {
      // Handle sign-in failure
      print('Sign-in failed.');
    }
  } catch (error) {
    // Handle errors
    print('Error during Google sign-in: $error');
  }
}
