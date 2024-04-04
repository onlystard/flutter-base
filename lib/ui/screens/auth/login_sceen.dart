import 'package:boomracing/common_blocs/auth/auth_event.dart';
import 'package:boomracing/common_blocs/auth/bloc.dart';
import 'package:boomracing/ui/widgets/bottom_navigation_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String id = 'login_screen';

  @override
  _LoginSceenState createState() => _LoginSceenState();
}

class _LoginSceenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.isLoading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }

        if (state.user != null) {
          Navigator.pushNamed(context, BottomNavigationApp.id);
        }
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: _formInput(context),
        ),
      ),
    );
  }

  List<Widget> _formInput(BuildContext context) {
    return [
      Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                ValueListenableBuilder(
                    valueListenable: passwordNotifier,
                    builder: (_, passwordObscure, __) {
                      return TextFormField(
                        controller: passwordController,
                        obscureText: passwordObscure,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(passwordObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              passwordNotifier.value = !passwordObscure;
                            },
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(AuthEventLogin(
                          email: emailController.text,
                          password: passwordController.text));
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ))
    ];
  }
}
