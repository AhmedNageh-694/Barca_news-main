import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthBloc({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? GoogleSignIn(),
      super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthGoogleSignInRequested>(_onGoogleSignInRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      final user = userCredential.user;
      if (user == null) {
        emit(AuthError('Unable to log in. Please try again.'));
        return;
      }
      emit(AuthAuthenticated(user.uid));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Authentication failed'));
    } catch (_) {
      emit(AuthError('Unexpected error. Please try again.'));
    }
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      final user = userCredential.user;
      if (user == null) {
        emit(AuthError('Unable to register. Please try again.'));
        return;
      }
      emit(AuthAuthenticated(user.uid));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Registration failed'));
    } catch (_) {
      emit(AuthError('Unexpected error. Please try again.'));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
    emit(AuthInitial());
  }

  Future<void> _onGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        emit(AuthInitial());
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      final user = userCredential.user;

      if (user == null) {
        emit(AuthError('Unable to sign in with Google. Please try again.'));
        return;
      }

      emit(AuthAuthenticated(user.uid));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Google sign-in failed'));
    } catch (e) {
      emit(AuthError('Google sign-in failed. Please try again.'));
    }
  }
}
