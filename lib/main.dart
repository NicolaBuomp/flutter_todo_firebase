import 'package:flutter/material.dart';
import 'package:flutter_todo_firebase/provider/AuthProvider.dart';
import 'package:flutter_todo_firebase/screens/form_screen.dart';
import 'package:flutter_todo_firebase/screens/register_screen.dart';
import 'package:flutter_todo_firebase/screens/todo_screen.dart';
import 'package:provider/provider.dart';
import './screens/login_screen.dart';
import './screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme:
          ThemeData(primarySwatch: Colors.blueGrey),
          home: const HomeScreen(),
          routes: {
            "home": (context) => const HomeScreen(),
            "login": (context) => LoginScreen(),
            "register": (context) => RegisterScreen(),
            "form": (context) => FormScreen(),
            "todos": (context) => TodoScreen()
          },
        ),
    );
  }
}
