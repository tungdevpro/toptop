import 'package:flutter/material.dart';
import 'package:presentation/common/constants/app_icons.dart';
import 'package:presentation/features/home/home.dart';

import '../../common/widgets/svg_viewer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final currentIndex = ValueNotifier(0);

  var items = <Widget>[
    const HomePage(),
    Container(),
    Container(),
    Container(),
  ];

  final navs = [
    NavItem(icon: AppIcons.icNavHome, name: '', iconSelected: AppIcons.icNavHomeLight),
    NavItem(icon: AppIcons.icNavCamera, name: '', iconSelected: AppIcons.icNavCameraLight),
    NavItem(icon: AppIcons.icNavMessage, name: '', iconSelected: AppIcons.icNavMessageLight),
    NavItem(icon: AppIcons.icNavProfile, name: '', iconSelected: AppIcons.icNavProfileLight),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
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
                (e) => BottomNavigationBarItem(icon: SvgViewer(index == e.key ? e.value.iconSelected : e.value.icon, width: 18), label: ''),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    currentIndex.dispose();
    super.dispose();
  }

  void _onChangeIndexNavigation(int value) {
    currentIndex.value = value;
  }
}

class NavItem {
  final String name;
  final String icon;
  final String iconSelected;

  NavItem({required this.name, required this.icon, required this.iconSelected});
}
