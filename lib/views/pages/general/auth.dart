import 'package:smartpay/utilities/imports/generalImport.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AuthMethods {
  static final _googleSignIn = GoogleSignIn();

  // final FirebaseAuth auth = FirebaseAuth.instance;
  static Future<GoogleSignInAccount?> signInWithGoogle() =>
      _googleSignIn.signIn();

  // getCurrentUser() async {
  //   return await auth.currentUser;
  // }

  // signInWithGoogle(BuildContext context) async {
  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // final GoogleSignInAccount? googleSignInAccount =
  //     await googleSignIn.signIn();

  // final GoogleSignInAuthentication? googleSignInAuthentication =
  //     await googleSignInAccount?.authentication;

  // final AuthCredential credential = GoogleAuthProvider.credential(
  //     idToken: googleSignInAuthentication?.idToken,
  //     accessToken: googleSignInAuthentication?.accessToken);

  // UserCredential result = await firebaseAuth.signInWithCredential(credential);

  // User? userDetails = result.user;

  // if (result != null) {
  //   Map<String, dynamic> userInfoMap = {
  //     "email": userDetails!.email,
  //     "name": userDetails.displayName,
  //     "imgUrl": userDetails.photoURL,
  //     "id": userDetails.uid,
  //   };
  //   DatabaseMethods().addUser(userDetails.uid, userInfoMap).then((value) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => Home()));
  //     // context.goNamed(homeRoute);

  //   });
  // }
  // }

//   Future<User> signInWithApple({List<Scope> scopes = const []}) async {
//     final result = await TheAppleSignIn.performRequests(
//         [AppleIdRequest(requestedScopes: scopes)]);

//     switch (result.status) {
//       case AuthorizationStatus.authorized:
//         final AppleIdCredential = result.credential!;
//         final oAuthProvider = OAuthProvider('apple.com');
//         final credential = oAuthProvider.credential(
//             idToken: String.fromCharCodes(AppleIdCredential.identityToken!));
//         final UserCredential = await auth.signInWithCredential(credential);
//         final firebaseUser = UserCredential.user!;
//         if (scopes.contains(Scope.fullName)) {
//           final fullName = AppleIdCredential.fullName;
//           if (fullName != null &&
//               fullName.givenName != null &&
//               fullName.familyName != null) {
//             final displayName = '${fullName.givenName} ${fullName.familyName}';
//             await firebaseUser.updateDisplayName(displayName);
//           }
//         }
//         return firebaseUser;
//       case AuthorizationStatus.error:
//         throw PlatformException(
//             code: 'ERROR_AUTHORIZATION_DENIED',
//             message: result.error.toString());

//       case AuthorizationStatus.cancelled:
//         throw PlatformException(
//             code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');

//       default:
//         throw UnimplementedError();
//     }
//   }
}
