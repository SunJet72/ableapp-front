import 'package:able_app/features/maps/presentation/blocs/location_bloc.dart';
import 'package:able_app/features/maps/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:able_app/features/maps/presentation/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'config/theme/app_theme.dart';

void main() async{
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const AbleApp());
}

class AbleApp extends StatelessWidget {
  const AbleApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (context) => UserBloc()),
        BlocProvider<LocationBloc>(
          create:
              (context) => LocationBloc()..add(const GetCurrentLocationEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: AppTheme.light,
       // home: const MainMapScreen(),
        home:  LandingScreen(),
      ),
    );
  }
}
