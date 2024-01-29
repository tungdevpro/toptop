import 'package:flutter/material.dart';
import 'package:presentation/common/constants/app_icons.dart';
import 'package:presentation/features/camera/camera_page.dart';
import 'package:presentation/features/home/home.dart';
import 'package:presentation/features/profile/profile_page.dart';

import '../../common/widgets/svg_viewer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ValueNotifier<int> currentIndex;
  late PageController _pageController;

  var items = <Widget>[
    const HomePage(),
    const CameraPage(),
    Container(),
    const ProfilePage(),
  ];

  final navs = [
    NavItem(icon: AppIcons.icNavHome, name: '', iconSelected: AppIcons.icNavHomeSelected),
    NavItem(icon: AppIcons.icNavCamera, name: '', iconSelected: AppIcons.icNavCameraSelected),
    NavItem(icon: AppIcons.icNavMessage, name: '', iconSelected: AppIcons.icNavMessageSelected),
    NavItem(icon: AppIcons.icNavProfile, name: '', iconSelected: AppIcons.icNavProfileSelected),
  ];

  @override
  void initState() {
    currentIndex = ValueNotifier(0);
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: items,
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: currentIndex,
        builder: (context, index, child) => BottomNavigationBar(
          onTap: _onChangeIndexNavigation,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          elevation: .0,
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.blue,
          items: navs
              .asMap()
              .entries
              .map<BottomNavigationBarItem>(
                (e) => BottomNavigationBarItem(
                  icon: SvgViewer(index == e.key ? e.value.iconSelected : e.value.icon),
                  label: '',
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    currentIndex.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onChangeIndexNavigation(int value) {
    currentIndex.value = value;
    _pageController.jumpToPage(value);
  }
}

class NavItem {
  final String name;
  final String icon;
  final String iconSelected;

  NavItem({required this.name, required this.icon, required this.iconSelected});
}
