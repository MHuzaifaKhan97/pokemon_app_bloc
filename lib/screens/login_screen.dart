import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pokemon_app_bloc/clipper/cliper.dart';
import 'package:pokemon_app_bloc/cubits/auth_cubit/auth_cubit.dart';
import 'package:pokemon_app_bloc/cubits/auth_cubit/auth_state.dart';
import 'package:pokemon_app_bloc/resources/app_theme.dart';
import 'package:pokemon_app_bloc/resources/utils.dart';
import 'package:pokemon_app_bloc/screens/home_screen.dart';
import 'package:pokemon_app_bloc/screens/signup_screen.dart';
import 'package:pokemon_app_bloc/widgets/custom_button_widget.dart';
import 'package:pokemon_app_bloc/widgets/rich_text_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 300),
                painter: RPSCustomPainter(),
              ),
              Positioned(
                top: 15,
                right: -5,
                child: CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 300),
                  painter: PSCustomPainter(),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.width * 0.35,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Text(
                        "Sign In",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        "Please sign in to continue",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryColor.withOpacity(0.6),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06),
                      FormBuilder(
                          key: BlocProvider.of<AuthCubit>(context).loginFormKey,
                          child: Column(
                            children: [
                              FormBuilderTextField(
                                name: "email",
                                // autovalidateMode: AutovalidateMode.always,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: "Email is required"),
                                  FormBuilderValidators.email(
                                      errorText:
                                          "Please enter a valid email address"),
                                ]),
                                decoration: const InputDecoration(
                                  hintText: "Enter email",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              FormBuilderTextField(
                                name: "password",
                                // autovalidateMode: AutovalidateMode.always,
                                obscureText: true,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: "Password is required"),
                                  FormBuilderValidators.minLength(8,
                                      errorText:
                                          "Password length is minimum 8"),
                                ]),
                                decoration: const InputDecoration(
                                  hintText: "Enter password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              Align(
                                alignment: Alignment.centerRight,
                                child: BlocConsumer<AuthCubit, AuthState>(
                                  listener: (context, state) {
                                    if (state is AuthLoggedInState) {
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  BlocProvider(
                                                    create: (context) =>
                                                        AuthCubit(),
                                                    child: const HomeScreen(),
                                                  ))));
                                    } else if (state is AuthErrorState) {
                                      Utils.snackbar(state.error, context,
                                          AppTheme.colorError);
                                    }
                                  },
                                  builder: (context, state) {
                                    return CustomButton(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.055,
                                      isLoading: state is AuthLoadingState,
                                      title: "SIGN IN",
                                      icon: const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                      onTap: () {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        if (BlocProvider.of<AuthCubit>(context)
                                            .loginFormKey
                                            .currentState!
                                            .saveAndValidate()) {
                                          BlocProvider.of<AuthCubit>(context)
                                              .logIn();
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: RichTextTappableWidget(
                  firstText: 'Don\'t have an account?',
                  secondText: ' Sign up',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const SignUpScreen())));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
