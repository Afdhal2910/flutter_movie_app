import 'package:dartz/dartz.dart';
import 'package:test1/movie/models/tv_model.dart';

abstract class TvRepository {
  Future<Either<String, TvRespondModel>> getDiscoverTv({int page = 1});

}