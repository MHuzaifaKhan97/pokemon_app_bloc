import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_bloc/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:pokemon_app_bloc/logic/cubits/auth_cubit/auth_state.dart';
import 'package:pokemon_app_bloc/logic/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:pokemon_app_bloc/logic/cubits/pokemon_cubit/pokemon_cubit.dart';
import 'package:pokemon_app_bloc/screens/home_screen.dart';
import 'package:pokemon_app_bloc/screens/login_screen.dart';
import 'package:pokemon_app_bloc/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: ((context) => AuthCubit())),
    BlocProvider(create: ((context) => PokemonCubit())),
    BlocProvider(create: ((context) => FavouriteCubit())),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xFF1e81b0),
      )),
      // home: BlocProvider(
      //   create: (context) => AuthCubit(),
      //   child: SplashScreen(),
      // ),
      // home: MultiBlocProvider(
      //   providers: [
      //     BlocProvider(create: ((context) => SplashCubit())),
      //     BlocProvider(create: ((context) => AuthCubit())),
      //   ],
      //   child: BlocBuilder<SplashCubit, SplashState>(
      //     builder: (context, state) {
      //       if (state is SplashDoneState) {
      //         return BlocBuilder<AuthCubit, AuthState>(
      //           buildWhen: (previous, current) => previous is AuthInitialState,
      //           builder: (context, state) {
      //             if (state is AuthLoggedInState) {
      //               return HomeScreen();
      //             } else if (state is AuthLoggedOutState) {
      //               return LoginScreen();
      //             }
      //             return Scaffold();
      //           },
      //         );
      //       }
      //       return SplashScreen();
      //     },
      //   ),
      // ),
      home: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) => previous is AuthInitialState,
          builder: (context, state) {
            if (state is AuthLoggedInState) {
              return const HomeScreen();
            } else if (state is AuthLoggedOutState) {
              return const LoginScreen();
            } else if (state is AuthInitialState) {
              return const SplashScreen();
            }
            return const Scaffold();
          },
        ),
      ),
      // home: SplashScreen(),
    );
  }
}
