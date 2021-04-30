import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix_responsive_ui/cubits/app_bar/app_bar_cubit.dart';
import 'package:flutter_netflix_responsive_ui/screens/home_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(key: PageStorageKey('homeScreen')),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  final Map<String, IconData> _icons = const {
    'Home': Icons.home,
    'Search': Icons.search,
    'Coming Soon': Icons.queue_play_next,
    'Downloads': Icons.file_download,
    'More': Icons.menu,
  };

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    return Scaffold(
      body: BlocProvider<AppBarCubit>(
          create: (_) => AppBarCubit(), child: _screens[_currentIndex]),
      bottomNavigationBar: deviceType == DeviceScreenType.desktop
          ? null
          : _getBottomNavigationBar(),
    );
  }

  BottomNavigationBar _getBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      items: _icons
          .map((title, icon) => MapEntry(
              title,
              BottomNavigationBarItem(
                icon: Icon(icon, size: 30.0),
                label: title,
              )))
          .values
          .toList(),
      currentIndex: _currentIndex,
      selectedFontSize: 12.0,
      selectedItemColor: Colors.white,
      unselectedFontSize: 12.0,
      unselectedItemColor: Colors.grey,
      onTap: (index) => setState(() => _currentIndex = index),
    );
  }
}
