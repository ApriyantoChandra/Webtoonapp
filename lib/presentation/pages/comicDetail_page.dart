import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:webtoon_application_1/domain/entities/detail_comic.dart';
import 'package:webtoon_application_1/presentation/pages/readPage_page.dart';

import '../../utils/color.dart';
import '../bloc/chapter/chapter_bloc.dart';
import '../bloc/detail_comic/detail_comic_bloc.dart';

class DetailComicPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail_comic';

  final String param;
  const DetailComicPage({Key? key, required this.param}) : super(key: key);

  @override
  State<DetailComicPage> createState() => _DetailComicPageState();
}

class _DetailComicPageState extends State<DetailComicPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailComicBloc>().add(FetchDetailComicEvent(widget.param));
      context.read<ChapterBloc>().add(FetchChapterEvent(widget.param));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        body: BlocBuilder<DetailComicBloc, DetailComicState>(
          builder: (context, state) {
            if (state is DetailComicLoading) {
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: kTextSecondColor, size: 50),
              );
            } else if (state is DetailComicHasData) {
              final comic = state.result;
              return DetailContent(comic);
            } else if (state is DetailComicEmpty) {
              return const Center(
                child: Text("Detail Komik Tidak Ditemukan",
                    style: const TextStyle(color: kTextSecondColor)),
              );
            } else {
              return const Center(
                child: Text('Terjadi Kesalahan ;(, Coba lagi',
                    style: const TextStyle(color: kTextSecondColor)),
              );
            }
          },
        ));
  }
}

class DetailContent extends StatelessWidget {
  final DetailComic comic;
  const DetailContent(this.comic, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: kTextSecondColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  // Icon(
                  //   Icons.more_vert_outlined,
                  //   color: kTextSecondColor,
                  //   size: 30,
                  // )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(14),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kTextSecondColor, width: 2),
                    ),
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl: comic.thumbnail,
                        height: 150,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        placeholder: (context, url) {
                          return Center(
                              child: LoadingAnimationWidget.discreteCircle(
                                  color: kTextSecondColor, size: 20));
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comic.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            color: kTextSecondColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(spacing: 5, children: [
                        for (String genres in comic.genre)
                          Chip(
                            label: Text(genres,
                                style:
                                    const TextStyle(color: kTextSecondColor)),
                            backgroundColor: kSecondaryColor,
                          )
                      ]),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: kSecondaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10)),
                          child: const Text(
                            'Baca',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: kTextSecondColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        // IconButton(
                        //   icon: const Icon(
                        //     Icons.bookmark,
                        //     color: kTextSecondColor,
                        //     size: 34,
                        //   ),
                        //   onPressed: () {},
                        // ),
                        // IconButton(
                        //   icon: const Icon(
                        //     Icons.share_outlined,
                        //     color: kTextSecondColor,
                        //     size: 30,
                        //   ),
                        //   onPressed: () {},
                        // ),
                      ],
                    ),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: kSecondaryColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sinopsis',
                        style: TextStyle(
                            color: kTextSecondColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ReadMoreText(
                        comic.synopsis,
                        trimLines: 5,
                        colorClickableText: kTextSecondColor,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Baca Selengkapnya',
                        trimExpandedText: '\n\nBaca Sedikit',
                        style: const TextStyle(
                          color: kTextSecondColor,
                          fontSize: 16,
                        ),
                        moreStyle: const TextStyle(
                            color: kTextSecondColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        lessStyle: const TextStyle(
                            color: kTextSecondColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'Chapter',
                style: TextStyle(
                    color: kTextSecondColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: comic.chapters.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            comic.chapters[index].chapter,
                            style: const TextStyle(
                                color: kTextSecondColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            comic.chapters[index].release,
                            style: const TextStyle(
                                color: kTextSecondColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ReadPage.ROUTE_NAME,
                                    arguments: comic.chapters[index].param);
                              },
                              child: const Text('Baca'),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: kSecondaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10)))
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
