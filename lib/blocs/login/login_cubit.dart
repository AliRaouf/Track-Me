import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  String error="";
  loginUser(String email,String password) async
  {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error='No user found for that email.';
        emit(LoginErrorState(error));
      } else if (e.code == 'wrong-password') {
        error='Wrong password provided for that user.';
        emit(LoginErrorState(error));
      }else{
        error=e.message!;
        emit(LoginErrorState(error));
      }
    }
  }
  guestLogin(){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInAnonymously()
    .then((value){
    emit(GuestLoginSuccessState());
    }).catchError((error){
    emit(LoginErrorState(error));
    });

  }
}
