import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_aki_bro/core/helpers/bloc_observer.dart';
import 'package:nine_aki_bro/views/auth/logic/authentication_cubit.dart';
import 'package:nine_aki_bro/views/splash/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/theme.dart';

void main() async {
  /// supabase setup
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://vbwovpydyygqyosbrtih.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZid292cHlkeXlncXlvc2JydGloIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM2MzI1MDQsImV4cCI6MjA1OTIwODUwNH0.46XUtPSkVdsDeyWTw8Qn0Fff85BNoQ3uDQe84MPGkjQ',
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