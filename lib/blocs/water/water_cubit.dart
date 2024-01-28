import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'water_state.dart';

class WaterCubit extends Cubit<WaterState> {
  WaterCubit() : super(WaterInitial());
  static WaterCubit get(context) => BlocProvider.of(context);
  String? userGender;
  User? user;
  getUserData()
  {
    user=FirebaseAuth.instance.currentUser;
  }
  getUserGender() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user!.email)
        .get();
    var userData = snapshot.docs.first;
    userGender=userData["gender"];
    print(userGender);

  }
}
