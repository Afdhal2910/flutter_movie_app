import 'package:flutter/material.dart';
import 'package:test1/movie/models/movie_model.dart';
import 'package:test1/movie/repositories/movie_repository.dart';

class MovieGetDiscoverProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetDiscoverProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void getDiscover(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    print('Fetching movie data...'); // Log when data fetching starts


    final result = await _movieRepository.getDiscover();

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage),
        ));

        print('Error fetching movies: $errorMessage');

        _isLoading = false;
        notifyListeners();
        return;

      }, (response) {

        print('Movies fetched successfully: ${response.results.length} movies found.');
        print('Movies fetched successfully: ${response.results[0].posterPath}');


        _movies.clear();
        _movies.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return null;

      });
  }
}