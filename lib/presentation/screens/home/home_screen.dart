import 'package:contact_app_tw/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../profile/profile_controller.dart';
import '../profile/profile_screen.dart';
import 'home_content.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    Get.put(ProfileController());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_currentIndex == 0 ? 'My Contacts' : 'My Profile')),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          HomeContent(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white,
        currentIndex: _currentIndex,
        onTap: (index) async {
          final user = Get.find<HomeController>().loggedInUser;

          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });

          if (index == 1 && user != null) {
            Get.find<ProfileController>().updateProfileData(
              name: '${user.firstName} ${user.lastName}',
              email: user.email,
            );
          }
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 4.0,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.darkGray,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
