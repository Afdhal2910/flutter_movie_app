import 'package:flutter/material.dart';
import 'package:test1/movie/models/tv_model.dart';
import 'package:test1/movie/repositories/tv_repository.dart';

class TvGetDiscoverProvider with ChangeNotifier {
    final TvRepository _tvRepository;
    TvGetDiscoverProvider(this._tvRepository);

    bool _isLoading = false;
    bool get isLoading => _isLoading;

final List<TvModel> _tv = [];
List<TvModel> get tv => _tv;

void getDiscover(BuildContext context) async {
  _isLoading = true;
  notifyListeners();

  print('Fetching tv data...');

  final result = await _tvRepository.getDiscoverTv();

  result.fold(
    (errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage),
      ));

      print('Error fecthing tv: $errorMessage');

      _isLoading = false;
      notifyListeners();
      return;

    }, (response) {

        print('masuk TV fetched successfully: ${response.results[0].title}');

        _tv.clear();
        _tv.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return null;

    });
  } 
}