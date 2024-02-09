import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  String error="";
  Uint8List? image;
  Future<String>uploadImage(Uint8List file)async{
    String imgName=FirebaseAuth.instance.currentUser!.email!;
    Reference ref = FirebaseStorage.instance.ref('profile_image').child(imgName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  registerUser(String email, String password,String userName, String gender,Uint8List? file) async {
    emit(RegisterLoadingState());
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ); if (file != null) {
        saveUser(email, password, userName, gender, file);
      } else {
        saveUser(email, password, userName, gender,Uint8List.fromList([]));
      }
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        error=('An account already exists for that email.');
        emit(RegisterErrorState(error));
      } else if (e.code == 'weak-password') {
        error=('The password provided is too weak.');
        emit(RegisterErrorState(error));
      } else {
        error=e.message!;
        emit(RegisterErrorState(error));
      }
    } catch (e) {
      print(e);
      emit(RegisterErrorState(e));
    }
  }

  saveUser(email, password, username, gender,file)async{
    emit(SaveUserLoadingState());
    String imageUrl= await uploadImage(file);
    try {
      FirebaseFirestore.instance
          .collection("users")
          .add({"username": username, "email": email, "password": password,"gender":gender,"image":imageUrl});
      print("user saved success");
      emit(SaveUserSuccessState());
    } on Exception catch (e) {
      emit(SaveUserErrorState(e));
      print("couldnt save user $e");
    }
  }
  showSnackBar(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
  pickImage(ImageSource source)async{
    final ImagePicker imagePicker=ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
  if(file!=null){
    return await file.readAsBytes();
  }else{
    print("No Image Selected");
  }
  }
 selectImage()async{
   Uint8List? img = await pickImage(ImageSource.gallery);
   image=img;
  }
}
