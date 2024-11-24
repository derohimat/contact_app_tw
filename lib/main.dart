// main.dart
import 'package:contact_app_tw/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/services/secure_storage_service.dart';
import 'presentation/screens/home/home_binding.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/login/login_binding.dart';
import 'presentation/screens/login/login_screen.dart';
import 'presentation/screens/profile/profile_binding.dart';
import 'presentation/screens/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? loggedInUserId = await SecureStorageService.getLoggedInUserId();
  runApp(MyApp(loggedInUserId: loggedInUserId));
}

class MyApp extends StatelessWidget {
  final String? loggedInUserId;

  const MyApp({super.key, this.loggedInUserId});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Contact App',
      theme: ThemeData(
        primaryColor: AppColors.white,
        dividerColor: AppColors.darkGray,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          shadowColor: AppColors.darkGray,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 4.0,
          titleTextStyle: TextStyle(color: AppColors.black, fontSize: 23.0, fontWeight: FontWeight.bold),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.darkGray, width: 0.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.blue, width: 0.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          hintStyle: WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
            if (states.contains(WidgetState.focused)) {
              return TextStyle(color: AppColors.blue);
            }
            return TextStyle(color: AppColors.darkGray);
          }),
          labelStyle: TextStyle(color: AppColors.darkGray.withOpacity(0.6)),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
      initialRoute: loggedInUserId != null ? '/home' : '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/profile',
          page: () => const ProfileScreen(),
          binding: ProfileBinding(),
        ),
      ],
    );
  }
}
