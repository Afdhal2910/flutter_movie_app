import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1/app_constants.dart';
import 'package:test1/movie/providers/movie_get_discover_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:test1/widget/image_widget.dart';


class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {

  

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(),
          WidgetDiscoverMovie(),
        ],
      )
    );
  }
}


class WidgetDiscoverMovie extends StatefulWidget {
  const WidgetDiscoverMovie({super.key});

  @override
  State<WidgetDiscoverMovie> createState() => _WidgetDiscoverMovieState();
}

class _WidgetDiscoverMovieState extends State<WidgetDiscoverMovie> {
  @override
    void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
      });
    super.initState();
    }


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return  Container(
              child: const Text("Loading"),
            );
          }

          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
              itemCount: provider.movies.length,
              itemBuilder: (_, index, __) {
                final movie = provider.movies[index];
                return Stack(
                    children: [
                     ImageNetworkWidget(
                        height: 300.0,
                        width: double.infinity,
                        imageScr: '${AppConstants.imageUrlw500}${movie.backdropPath}',
                      ),
                      Container(
                        height: 300.0,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black87,
                            ])
                        ),
                      ),
                      Positioned(
                        bottom: 16.0,
                        left: 16.0,
                        right: 16.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageNetworkWidget(
                              height: 180.0,
                              width: 100,
                              imageScr: '${movie.posterPath}',
                            ),
                            Text(
                              movie.title,
                              style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                ),
                                Text(
                                  "${movie.voteAverage} (${movie.voteCount})",
                                  style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                              ],
                            )



                          ],
                          
                          
                          
                          )
                          )



                    ],
                );
              },
              options: CarouselOptions(
                height: 300.0,
                viewportFraction: 0.8,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal
              )
            );
          }

         return  Container(
              child: const Text("Not found this discover movies"),
            );
        },
      ),

    );
  }
}

