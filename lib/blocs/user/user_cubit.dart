import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context)=>BlocProvider.of(context);
  String? userEmail;
  String? userName;
  User? user;
  getUserData()
  {
    user=FirebaseAuth.instance.currentUser;
    emit(GetUserDataState());
  }
  Future receiverUserName() async {
    emit(ReceiveUserNameLoadingState());
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: user!.email!)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        userName = querySnapshot.docs.first.get("username");
        emit(ReceiveUserNameSuccessState());
      } else {
        emit(ReceiveUserNameErrorState());
      }
    } catch (e) {
      emit(ReceiveUserNameErrorState());
    }
  }

}
