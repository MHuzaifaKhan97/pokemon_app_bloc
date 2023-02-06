import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app_bloc/logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:pokemon_app_bloc/logic/cubits/auth_cubit/auth_state.dart';
import 'package:pokemon_app_bloc/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Screen",
        ),
        actions: [
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoggedOutState) {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => LoginScreen())));
              }
            },
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).loggedOut();
                  },
                  icon: const Icon(Icons.logout));
            },
          ),
        ],
      ),
      body: Center(child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoggedInState) {
            return Text(BlocProvider.of<AuthCubit>(context).currentUser!.uid);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}
