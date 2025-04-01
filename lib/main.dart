import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_aki_bro/utils/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/repository/auth_repository.dart';
import 'features/splash/splash_screen.dart';

void main() async {
  /// supabase setup
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://erqfgzgptstbmpdeqfue.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVycWZnemdwdHN0Ym1wZGVxZnVlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI4NDMyODUsImV4cCI6MjA1ODQxOTI4NX0.YFulmk0PNEW8N6H5y5RZcexr0GWbtzfpu6sHJGLlsaw',
  );
  runApp(NineAkiBro());
}

class NineAkiBro extends StatelessWidget {
  final _authRepository = AuthRepository();
  NineAkiBro({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: _authRepository)
        ..add(
          AuthCheckRequested(),
        ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
