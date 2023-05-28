// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleRepository {
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();

//   Future<String> signInWithGoogle() async {
//     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//     final GoogleSignInAuthentication googleAuthentication =
//         await googleSignInAccount!.authentication;
//     final AuthCredential credential = GoogleAuthProvider.getCredential(
//         accessToken: googleAuthentication.accessToken,
//         idToken: googleAuthentication.idToken);
//     final AuthResult authResult =
//         await firebaseAuth.signInWithCredential(credential);
//     final FirebaseUser user = authResult.user;
//     assert(!user.isAnonymous);
//     assert(await user.getIdToken() != null);
//     final FirebaseUser currentUser = await firebaseAuth.currentUser();
//     assert(user.uid == currentUser.uid);
//     print('signInWithGoogle succeeded: $user');
//     return 'signInWithGoogle succeeded: $user';
//   }
// }
