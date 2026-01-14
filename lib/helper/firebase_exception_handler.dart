import 'package:budget_app/shared/utilities/pops.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseExceptionHandler {
  /// Central method to handle all firebase errors
  static void handle(Object error) {
    String message = 'An unknown error occurred. Please try again.';

    // -------- Firebase Auth Exceptions --------
    if (error is FirebaseAuthException) {
      message = _handleAuthException(error);
    }
    // -------- Firestore Exceptions --------
    else if (error is FirebaseException && error.plugin == 'cloud_firestore') {
      message = _handleFirestoreException(error);
    }
    // -------- Other Errors --------
    else {
      if (kDebugMode) {
        print('Unhandled error: $error');
      }
    }

    // Show dialog (UI message)
    Pops.showError(message);

    if (kDebugMode) {
      print('Firebase Error: $error');
    }
  }

  // ======== AUTH ERROR MESSAGES ========
  static String _handleAuthException(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'The email address is badly formatted.'; // invalid address format
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'The password is incorrect.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'account-exists-with-different-credential':
        return 'This email is already used with another sign-in method.';
      case 'invalid-credential':
        return 'The authentication credential is invalid or expired.';
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
      default:
        return error.message ?? 'Authentication failed. Try again.';
    }
  }

  // ======== FIRESTORE ERROR MESSAGES ========
  static String _handleFirestoreException(FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return 'You don’t have permission to perform this action.';
      case 'unimplemented':
        return 'This feature is not implemented yet.';
      case 'not-found':
        return 'Requested data was not found.';
      case 'already-exists':
        return 'The document already exists.';
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'invalid-argument':
        return 'Invalid data provided.';
      case 'deadline-exceeded':
        return 'The request timed out. Try again.';
      case 'resource-exhausted':
        return 'Quota exhausted or rate limited.';
      case 'aborted':
        return 'Operation aborted. Try again.';
      case 'unknown':
        return 'Unknown error occurred with database.';
      default:
        return error.message ?? 'Database error occurred.';
    }
  }
}
