import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:meta/meta.dart';
import 'package:track_me/screen/login_screen.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);
  String? userEmail;
  String? userName;
  String? gender;
  String? password;
  User? user;
  String imageUrl="";
  bool isOldPasswordObscured = true;
  bool isNewPasswordObscured = true;
  bool isConfirmNewPasswordObscured = true;

  getUserData() {
    user = FirebaseAuth.instance.currentUser;
    emit(GetUserDataState());
  }

  Future receiverUserData() async {
    emit(ReceiveUserNameLoadingState());
    try {
      QuerySnapshot<
          Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: user!.email!)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        userName = querySnapshot.docs.first.get("username");
        imageUrl =querySnapshot.docs.first.get("image");
        gender=querySnapshot.docs.first.get("gender");
        password=querySnapshot.docs.first.get("password");
        emit(ReceiveUserNameSuccessState());
      } else {
        emit(ReceiveUserNameErrorState());
      }
    } catch (e) {
      emit(ReceiveUserNameErrorState());
    }
  }
  userSignOut(context) async {
    emit(UserSignOutLoadingState());
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    emit(UserSignOutSuccessState());
  }

  changeUserPassword(oldPassword, newPassword) {
    emit(ChangeUserPasswordLoadingState());
    AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!, password: oldPassword);
    user!.reauthenticateWithCredential(credential)
        .then((_) {
      user!.updatePassword(newPassword).then((_) {
        print('Password updated successfully');
        updateUserPassword(newPassword);
        emit(ChangeUserPasswordSuccessState());
      }).catchError((error) {
        print('Error updating password: $error');
        emit(ChangeUserPasswordErrorState());
      });
    }).catchError((error) {
      print('Error re-authenticating user: $error');
      emit(ChangeUserPasswordErrorState());
    });
  }

  updateUserPassword(newPassword) {
    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user!.email)
        .get().then((QuerySnapshot querySnapshot) {
      var doc = querySnapshot.docs[0];
      doc.reference.update({'password': newPassword}).then((value) => print("Password Updated Successfully"))
          .catchError((error)=>print("Failed To Update Password"));
    });
  }

  void toggleOldPasswordVisibility() {
    isOldPasswordObscured = !isOldPasswordObscured!;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordObscured = !isNewPasswordObscured!;
  }

  void toggleConfirmNewPasswordVisibility() {
    isConfirmNewPasswordObscured = !isConfirmNewPasswordObscured!;
  }
}
