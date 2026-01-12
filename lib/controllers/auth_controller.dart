import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Rx<User?> user = Rx<User?>(null);
  RxBool isLoading = false.obs;
  RxBool isGoogleLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_firebaseAuth.authStateChanges());
  }

  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? 'Authentication failed';
    } catch (_) {
      errorMessage.value = 'Unexpected error. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? 'Registration failed';
    } catch (_) {
      errorMessage.value = 'Unexpected error. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isGoogleLoading.value = true;
      errorMessage.value = '';

      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        isGoogleLoading.value = false;
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
      // This will automatically create a new account if one doesn't exist
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? 'Google sign-in failed';
    } catch (e) {
      errorMessage.value = 'Google sign-in failed. Please try again.';
    } finally {
      isGoogleLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
