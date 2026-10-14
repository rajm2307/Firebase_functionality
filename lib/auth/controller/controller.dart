import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordHidden = true.obs;
  final errorMessage = RxnString();

  void togglePasswordVisibility() =>
      isPasswordHidden.value = !isPasswordHidden.value;

  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) return 'Username is required';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    return null;
  }

  /// Returns true on success so the view can handle navigation.
  Future<bool> login() async {
    if (!(formKey.currentState?.validate() ?? false)) return false;

    try {
      isLoading.value = true;
      errorMessage.value = null;

      await _auth.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text,
      );
      Get.snackbar('Success', 'Login successful');

      // await TokenStorage.save(token);
      return true;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Login Failed', e.message ?? e.code);
      return false;
    } catch (e, st) {
      log('Error during login: $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        st,
        reason: 'login failed',
        fatal: false,
      );
      errorMessage.value = 'Something went wrong. Please try again.';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      Get.snackbar('Success', 'Password reset email sent');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? e.code);
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
