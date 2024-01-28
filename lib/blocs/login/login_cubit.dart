import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  loginUser(String email,String password)
  {
    emit(LoginLoadingState());
    FirebaseAuth
        .instance
        .signInWithEmailAndPassword(email: email, password: password
    ).then((value){
      emit(LoginSuccessState());
    }).catchError((error){
      emit(LoginErrorState(error));
    });
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
