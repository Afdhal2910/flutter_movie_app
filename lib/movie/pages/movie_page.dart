import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1/app_constants.dart';
import 'package:test1/movie/providers/movie_get_discover_provider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    //context.read<TvGetDiscoverProvider>().getDiscover(context);

    });

   
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

            String imageUrl = AppConstants.imageUrlw500 + movie.posterPath.toString();
            print(imageUrl);
            return ListTile(
              contentPadding: EdgeInsets.all(8.0),
               leading: movie.posterPath!.isEmpty
                ? Image.network(
                imageUrl,
                width: 50, // Set width of the image
                fit: BoxFit.cover, // Adjust the image to cover the box
              )
            : Container(
                width: 50, // Placeholder width if no image
                child: Icon(Icons.image, size: 50), // Placeholder icon
              ),
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