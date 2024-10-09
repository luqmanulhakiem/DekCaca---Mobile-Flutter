import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      try {
        // await FirebaseAuth.instance.signOut();
        await GoogleSignIn().signOut();
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        Logger().d("googleUser: $googleUser");
        final storage = FlutterSecureStorage();
        storage.write(key: 'displayName', value: googleUser?.displayName);
        storage.write(key: 'email', value: googleUser?.email);
        storage.write(key: 'photoUrl', value: googleUser?.photoUrl);
        storage.write(key: 'signIn', value: 'true');

        // ALTERNATIF JANGAN DIHAPUS
        // Obtain the auth details from the request
        // final GoogleSignInAuthentication? googleAuth =
        //     await googleUser?.authentication;
        // // [GoogleAuthUtil] [GoogleAuthUtil] error status:UNKNOWN with method:getTokenWithDetails
        // Logger().d("googleAuth: $googleAuth");
        // Logger().d("googleAuth: ${googleAuth?.accessToken}");
        // Logger().d("googleAuth: ${googleAuth?.idToken}");

        // // Create a new credential
        // final credential = GoogleAuthProvider.credential(
        //   accessToken: googleAuth?.accessToken,
        //   idToken: googleAuth?.idToken,
        // );

        // // Once signed in, return the UserCredential
        // await FirebaseAuth.instance.signInWithCredential(credential);
        emit(AuthSuccessLogin());
      } catch (e) {
        // Logger().d("ERRR: $e");
        emit(AuthFailure(error: e.toString()));
      }
    });

    on<AuthLogout>((event, emit) async {
      emit(AuthLoading());
      try {
        final storage = FlutterSecureStorage();

        storage.write(key: 'signIn', value: 'false');

        // await FirebaseAuth.instance.signOut();
        // await GoogleSignIn().signOut();
        emit(AuthSuccessLogout());
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });
  }
}
