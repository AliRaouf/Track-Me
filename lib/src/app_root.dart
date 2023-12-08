import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_me/blocs/register/register_cubit.dart';
import 'package:track_me/screen/splash_screen.dart';

import '../screen/start_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>RegisterCubit()),

      ],
      child: MaterialApp(debugShowCheckedModeBanner: false,
          home:SplashScreen()),
    );
  }
}
