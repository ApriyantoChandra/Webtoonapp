import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:webtoon_application_1/presentation/pages/bookmark_page.dart';
import 'package:webtoon_application_1/presentation/pages/comic_page.dart';
import 'package:webtoon_application_1/presentation/pages/home_page.dart';
import 'package:webtoon_application_1/presentation/pages/more_page.dart';
import 'package:webtoon_application_1/utils/color.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _page = [
    HomePage(),
    ComicPage(),
    BookmarkPage(),
    MorePage()
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: kPrimaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _page[_selectedIndex],
      ),
    );
  }
}
