// // ignore_for_file: avoid_print
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
//
// import '../controllers/signin_controller.dart';
//
// class AuthService extends ChangeNotifier {
//   final _auth = FirebaseAuth.instance;
//   SignInController signinController = Get.find<SignInController>();
//
//   Future<void> sendOtp({
//     required String phoneNumber,
//     required Function(String verificationId) onCodeSent,
//     required Function(String error) onError}) async {
//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         timeout: const Duration(seconds: 60),
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           // Auto-sign in case of trusted devices
//           await _auth.signInWithCredential(credential);
//           print("Phone number automatically verified!");
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           String errorMsg = _getErrorMessage(e);
//           onError(errorMsg);
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           onCodeSent(verificationId);
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//         },
//       );
//     } catch (e) {
//       onError("Something went wrong. Please try again.");
//     }
//   }
//
//   String _getErrorMessage(FirebaseAuthException e) {
//     switch (e.code) {
//       case 'invalid-phone-number':
//         return 'The phone number entered is invalid.';
//       case 'too-many-requests':
//         return 'Too many requests. Please try again later.';
//       case 'quota-exceeded':
//         return 'SMS quota exceeded. Try again later.';
//       default:
//         return 'Verification failed. Try again.';
//     }
//   }
//
//   Future<void> verifyOtp({
//     required String otp,
//     required Function(UserCredential user) onSuccess,
//     required Function(String error) onError,
//     required String verificationId,
//   }) async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: otp,
//       );
//
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//       final User? user = userCredential.user;
//
//       if (user != null) {
//         await signinController.verifyMobile(user);
//       }
//
//       onSuccess(userCredential);
//     } catch (e) {
//       print(e);
//       onError("Invalid OTP. Please try again.");
//     }
//   }
//
// }
