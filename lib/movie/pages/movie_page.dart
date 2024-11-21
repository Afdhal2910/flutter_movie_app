import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1/movie/providers/movie_get_discover_provider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<MovieGetDiscoverProvider>().getDiscover(context);

    print("masuk sini");


    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie DB'),
      ),
      body: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          
          if(provider.isLoading) {
            return const Center(
             child: CircularProgressIndicator(),
            );
          }
        
        if (provider.movies.isNotEmpty) {
          return ListView.builder(itemBuilder: (context, index){
            final movie = provider.movies[index];
            return ListTile(
              title: Text(movie.title),
              subtitle: Text(movie.overview),
              );
            },
          );
        } 

      return const Center(
        child: Text('Not found discover moview'),
        );

      },
      ),
    );
  }
}