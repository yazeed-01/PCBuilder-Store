import 'package:flutter/material.dart';
import 'package:pcstore/auth_pages/login_page.dart';
import 'package:pcstore/auth_pages/register_page.dart';
import 'package:pcstore/home_pages/home_page.dart';
import 'package:pcstore/loading_page/loading_page.dart';
import 'package:pcstore/profile_settings_pages/about_page.dart';
import 'package:pcstore/provider/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PC Store',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false)
            .checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }
          return Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.isLoggedIn) {
                return HomePage();
              } else {
                return LoginPage();
              }
            },
          );
        },
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
        '/about': (context) => AboutPage(),
      },
    );
  }
}
