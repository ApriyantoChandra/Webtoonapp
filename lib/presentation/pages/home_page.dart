import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtoon_application_1/presentation/pages/search_page.dart';
import 'package:webtoon_application_1/presentation/widget/RecommendationHeader_widget.dart';
import 'package:webtoon_application_1/presentation/widget/Recommendation_widget.dart';
import 'package:webtoon_application_1/presentation/widget/hotReleaseHeader_widget.dart';
import 'package:webtoon_application_1/presentation/widget/hotRelease_widget.dart';

import '../../utils/color.dart';
import '../bloc/comic/comic_bloc.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ComicBloc _comicBloc;

  @override
  void initState() {
    _comicBloc = BlocProvider.of<ComicBloc>(context);
    _comicBloc.add(FetchComicEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: kSecondaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: kWhite, width: 1.5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/webtoon.jpg',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                SearchPage.ROUTE_NAME,
                              );
                            },
                            child: Icon(
                              Icons.search,
                              color: kTextSecondColor,
                            ),
                          ),
                          SizedBox(width: 20),
                          // Icon(
                          //   Icons.notifications,
                          //   color: kWhite,
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                // New Release Section
                const HotReleaseHeaderWidget(),
                const HotReleaseWidget(),

                // Most Popular Comic
                const RecommendationHeaderWidget(),
                const RecommendationWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
