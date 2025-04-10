import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_aki_bro/core/constants/sensitive_data.dart';
import 'package:nine_aki_bro/core/helpers/bloc_observer.dart';
import 'package:nine_aki_bro/views/auth/logic/cubit/authentication_cubit.dart';
import 'package:nine_aki_bro/views/splash/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/theme.dart';

void main() async {
  /// supabase setup
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://roukbxhlisygcczaneiw.supabase.co',
    anonKey: anonKey,
  );
  Bloc.observer = MyObserver();
  runApp(const NineAkiBro());
}

class NineAkiBro extends StatelessWidget {
  const NineAkiBro({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nine Aki Bro',
        themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
