import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:clay_containers/clay_containers.dart';

import 'screens/home_screen.dart';
import 'screens/history_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/report_screen.dart';

import 'widgets/bottom_nav_bar.dart';

import 'package:humhum/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black),
            bodySmall: TextStyle(fontSize: 14.0, color: Colors.black),
          ),
          useMaterial3: false,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color.fromARGB(255, 244, 244, 252)),

      home: const AuthWrapper(), // ログイン状態に応じた画面を表示
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return const MainScreen(); // ログイン済みならメイン画面
    } else {
      return const LoginScreen(); // 未ログインならログイン画面
    }
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    HistoryScreen(),
    const ReportScreen(),
    const SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: ClayContainer(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: BottomNavBar(
            currentIndex: _currentIndex,
            onTabTapped: _onTabTapped,
          ),
        ));
  }
}
