import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safe_space_01/apis/auth_api.dart';
import 'package:safe_space_01/apis/user_api.dart';
import 'package:safe_space_01/core/utils.dart';
import 'package:safe_space_01/features/auth/view/login_view.dart';
import 'package:safe_space_01/features/home/view/home_view.dart';
import 'package:appwrite/models.dart' as model;
import 'package:safe_space_01/models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  print("currentUserId = " + currentUserId);
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  print("userDetails.value.name: " + userDetails.value!.name);
  return userDetails.value;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) async {
  final authController = ref.watch(authControllerProvider.notifier);
  return await authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);
// state = isLoading

  Future<model.User?> currentUser() => _authAPI.currentUserAccount();

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(email: email, password: password);
    state = false;
    res.fold(
      (l) => print("problem accoured: " + l.message),
      (r) async {
        UserModel userModel = UserModel(
            email: email,
            name: getNameFromEmail(email),
            followers: const [],
            following: const [],
            profilePic: '',
            bannerPic: '',
            uid: r.$id,
            bio: '',
            isTwitterBlue: false);
        final res2 = await _userAPI.saveUserData(userModel);
        res2.fold((l) => print("saveUserData did not worked"), (r) {
          Navigator.push(context, LoginView.route());
        });
      },
    );
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.login(email: email, password: password);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      Navigator.push(context, HomeView.route());
    });
  }

  Future<UserModel> getUserData(String uid) async {
    print("uid in getUserData: " + uid);
    final document = await _userAPI.getUserData(uid);
    print("document: " + document.$id);
    final updatedUser = UserModel.fromMap(document.data);
    print("updatedUser: " + updatedUser.uid);
    return updatedUser;
  }

  void logout(BuildContext context) async {
    final res = await _authAPI.losgout();
    res.fold(
      (l) => null,
      (r) {
        Navigator.pushAndRemoveUntil(
          context,
          LoginView.route(),
          (route) => false,
        );
      },
    );
  }
}

// showSnackBar(context, l.message)

