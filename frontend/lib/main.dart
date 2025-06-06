import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/constants.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/auth/landing_screen.dart';
import 'screens/selection/provider_selection_screen.dart';
import 'screens/selection/provider_info_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/settings/profile_screen.dart';
import 'screens/home/energy_tips_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/settings/notifications_screen.dart';
import 'screens/settings/about_screen.dart';
import 'screens/settings/terms_screen.dart';
import 'screens/settings/change_password_screen.dart';
import 'screens/schedule/schedule_screen.dart';
import 'screens/home/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _getInitialScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final username = prefs.getString('username');
    final email = prefs.getString('email');
    final provider = prefs.getString('provider') ?? 'PEA';

    if (token != null && username != null && email != null) {
      return MainScreen(
        username: username,
        email: email,
        provider: provider,
      );
    } else {
      return SplashScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PeakSmart',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _getInitialScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data as Widget;
          } else {
            return const Scaffold(
              backgroundColor: AppColors.background,
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/landing':
            return MaterialPageRoute(builder: (_) => LandingScreen());
          case '/register':
            return MaterialPageRoute(builder: (_) => RegisterPage());
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginScreen());
          case '/selection':
            {
              final args = settings.arguments as Map<String, dynamic>?;

              return MaterialPageRoute(
                builder: (_) => ProviderSelectionScreen(
                  username: args?['username'] ?? '',
                  email: args?['email'] ?? '',
                  userId: args?['userId'],
                ),
              );
            }
          case '/provider-info':
            return MaterialPageRoute(
                builder: (_) => const ProviderInfoScreen());
          case '/home':
            {
              final args = settings.arguments as Map<String, dynamic>?;

              return MaterialPageRoute(
                builder: (_) => MainScreen(
                  username: args?['username'] ?? '',
                  email: args?['email'] ?? '',
                  provider: args?['provider'] ?? 'PEA',
                ),
              );
            }
          case '/profile':
            {
              final args = settings.arguments as Map<String, dynamic>?;

              return MaterialPageRoute(
                builder: (_) => ProfileScreen(
                  username: args?['username'] ?? '',
                  email: args?['email'] ?? '',
                  provider: args?['provider'] ?? 'PEA',
                ),
              );
            }
          case '/energy-tips':
            return MaterialPageRoute(builder: (_) => const EnergyTipsScreen());
          case '/settings':
            return MaterialPageRoute(builder: (_) => const SettingsScreen());
          case '/notifications':
            return MaterialPageRoute(
                builder: (_) => const NotificationsScreen());
          case '/about-us':
            return MaterialPageRoute(builder: (_) => const AboutUsScreen());
          case '/terms':
            return MaterialPageRoute(
                builder: (_) => const TermsAndConditionsScreen());
          case '/change-password':
            return MaterialPageRoute(
                builder: (_) => const ChangePasswordScreen());
          case '/calendar':
            return MaterialPageRoute(builder: (_) => const ScheduleScreen());
          default:
            return MaterialPageRoute(builder: (_) => SplashScreen());
        }
      },
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
    );
  }
}
