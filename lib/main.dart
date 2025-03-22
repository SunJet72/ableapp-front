import 'package:able_app/core/injection/dependency_injection.dart';
import 'package:able_app/features/maps/presentation/blocs/route/route_bloc.dart';
import 'package:able_app/features/maps/presentation/screens/landing_screen.dart';
import 'package:able_app/features/maps/presentation/screens/main_map_screen.dart';
import 'package:able_app/features/maps/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:latlong2/latlong.dart';

import 'config/enums/stairs_enum.dart';
import 'config/enums/terrain_enum.dart';
import 'config/theme/app_theme.dart';
import 'features/maps/presentation/blocs/location/location_bloc.dart';
import 'features/maps/presentation/blocs/user/user_bloc.dart';

void main() async{
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  DependencyInjection.injectDependencies();
  runApp(const AbleApp());
}

class AbleApp extends StatelessWidget {
  const AbleApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MultiBlocProvider(
      providers: [
        BlocProvider<RouteBloc>(create: (context) => RouteBloc()),
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
      // home:  MainMapScreen(),
       //home:  SettingsScreen(),
        home:  const LandingScreen(),
      ),
    );
  }
}
