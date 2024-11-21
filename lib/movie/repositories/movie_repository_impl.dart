import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test1/movie/models/movie_model.dart';
import 'package:test1/movie/repositories/movie_repository.dart';


class MovieRepositoryImpl implements MovieRepository {

  final Dio _dio ;

  MovieRepositoryImpl(this._dio);

  @override
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1}) async {
    
    try {
      final results = await _dio.get(
        '/discover/movie',
        queryParameters: {'page': page},
      );

      if(results.statusCode == 200 && results.data != null) {
        final model = MovieResponseModel.fromMap(results.data);
        return Right(model);
      }

      return const Left('Error get discover movies');
    } on DioException catch (e) {

        if (e.response != null) {
        return Left(e.response.toString());
        }
        return const Left('Another error on get discover movies');
    }
  }
}