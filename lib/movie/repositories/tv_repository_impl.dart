import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test1/movie/models/tv_model.dart';
import 'package:test1/movie/repositories/tv_repository.dart';

class TvRepositoryImpl implements TvRepository {

  final Dio _dio;
  
  TvRepositoryImpl(this._dio);

  @override
  Future<Either<String, TvRespondModel>> getDiscoverTv({int page = 1}) async {
   
    try {
       final results = await _dio.get(
        '/discover/tv',
        queryParameters: {'page': page},
       );

       if(results.statusCode == 200 && results.data != null) {
        final model = TvRespondModel.fromMap(results.data);
        return Right(model);
       }

       return const Left('Error get discover tv');
    } on DioException catch (e) {

      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get discover tv');  
    }
  }
}