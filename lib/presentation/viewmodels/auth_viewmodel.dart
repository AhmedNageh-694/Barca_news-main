import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/presentation/coordinators/coordinators.dart';

/// AuthViewModel - handles authentication state and logic
class AuthViewModel extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final AuthCoordinator _coordinator = AuthCoordinator();

  // Observable state
  final Rx<User?> user = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isGoogleLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Getters
  bool get isAuthenticated => user.value != null;
  String? get userEmail => user.value?.email;
  String? get userId => user.value?.uid;

  @override
  void onInit() {
    super.onInit();
    _bindAuthState();
  }

  void _bindAuthState() {
    user.bindStream(_firebaseAuth.authStateChanges());
  }

  /// Sign in with email and password
  Future<void> signIn(String email, String password) async {
    try {
      _setLoading(true);
      _clearError();

      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _coordinator.onLoginSuccess();
    } on FirebaseAuthException catch (e) {
      _setError(e.message ?? 'Authentication failed');
    } catch (_) {
      _setError('Unexpected error. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  /// Sign up with email and password
  Future<void> signUp(String email, String password) async {
    try {
      _setLoading(true);
      _clearError();

      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _coordinator.onSignUpSuccess();
    } on FirebaseAuthException catch (e) {
      _setError(e.message ?? 'Registration failed');
    } catch (_) {
      _setError('Unexpected error. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      isGoogleLoading.value = true;
      _clearError();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        isGoogleLoading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      _coordinator.onLoginSuccess();
    } on FirebaseAuthException catch (e) {
      _setError(e.message ?? 'Google sign-in failed');
    } catch (e) {
      _setError('Google sign-in failed. Please try again.');
    } finally {
      isGoogleLoading.value = false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  // Navigation methods
  void navigateToSignUp() => _coordinator.navigateToSignUp();
  void navigateToLogin() => _coordinator.navigateToLogin();
  void goBack() => _coordinator.goBack();

  // Private helpers
  void _setLoading(bool value) => isLoading.value = value;
  void _setError(String message) => errorMessage.value = message;
  void _clearError() => errorMessage.value = '';
}
