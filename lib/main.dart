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

  const MyApp({Key? key, this.loggedInUserId}) : super(key: key);

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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(AppColors.blue),
            backgroundColor: WidgetStateProperty.all<Color>(AppColors.lightBlue),
            textStyle: WidgetStateProperty.all<TextStyle>(
              const TextStyle(color: AppColors.blue, fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            shape: WidgetStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(AppColors.red),
            side: WidgetStateProperty.all<BorderSide>(
              BorderSide(color: AppColors.red, width: 0.5),
            ),
            textStyle: WidgetStateProperty.all<TextStyle>(
              const TextStyle(color: AppColors.red, fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            shape: WidgetStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightGray, width: 0.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.blue, width: 0.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          hintStyle: WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
            if (states.contains(WidgetState.focused)) {
              return const TextStyle(color: AppColors.blue);
            }
            return const TextStyle(color: AppColors.darkGray);
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
        if (loggedInUserId != null)
          GetPage(
            name: '/home',
            page: () => const HomeScreen(),
            binding: HomeBinding(loggedInUserId!),
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
