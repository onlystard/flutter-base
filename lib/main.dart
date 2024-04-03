import 'package:boomracing/common_blocs/auth/bloc.dart';
import 'package:boomracing/injection.dart';
import 'package:boomracing/ui/screens/auth/login_sceen.dart';
import 'package:boomracing/ui/widgets/bottom_navigation_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  configureDependencies();

  runApp(const BoomRacing());
}

class BoomRacing extends StatelessWidget {
  const BoomRacing({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<AuthBloc>(
              lazy: false, create: (BuildContext context) => getIt<AuthBloc>()),
        ],
        child: GlobalLoaderOverlay(
          useDefaultLoading: true,
          child: MaterialApp(
              title: 'Boom Racing',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              debugShowCheckedModeBanner: false,
              home: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, AuthState state) {
                  if (state.isInitializing) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  }

                  if (state.user != null) {
                    return const BottomNavigationApp();
                  } else {
                    return const LoginScreen();
                  }
                },
              ),
              routes: {
                LoginScreen.id: (context) => const LoginScreen(),
                BottomNavigationApp.id: (context) =>
                    const BottomNavigationApp(),
              }),
        ));
  }
}
