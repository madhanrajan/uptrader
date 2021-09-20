import 'package:flutter/cupertino.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

String hostUrl = "http://0.0.0.0:8000";
String hostUrlWebsocket = "ws://0.0.0.0:8000";

class Authentication {
  String token = "";

  Authentication._private();

  static final Authentication instance = Authentication._private();

  Future<String> getIdToken() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final idToken = await user!.getIdToken();
      return idToken;
    } catch (error) {
      throw (error.toString());
    }
  }

  // Future<UserCredential> googleSignIn() async {
  //   GoogleSignIn _googleSignIn = GoogleSignIn(
  //     scopes: [
  //       'email',
  //       'profile',
  //     ],
  //   );

  //   try {
  //     await _googleSignIn.signIn();

  //     final GoogleSignInAuthentication googleAuth =
  //         await _googleSignIn.currentUser!.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  //   } catch (error) {
  //     throw (error.toString());
  //   }
  // }
}

// ignore: non_constant_identifier_names
FutureBuilder AuthenticatedFutureBuilder(
    Uri uri, Widget Function(BuildContext, AsyncSnapshot<Response>) builder) {
  Future<String> tokenFuture = Authentication.instance.getIdToken();

  return FutureBuilder<String>(
      future: tokenFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String dt = snapshot.data ?? "";
          Future<Response> resp = http.get(uri, headers: {"token": dt});
          return FutureBuilder<Response>(builder: builder, future: resp);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}
