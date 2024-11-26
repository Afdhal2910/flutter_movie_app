import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:test1/app_constants.dart';
import 'package:test1/movie/pages/movie_page.dart';
import 'package:test1/movie/providers/movie_get_discover_provider.dart';
import 'package:test1/movie/repositories/movie_repository.dart';
import 'package:test1/movie/repositories/movie_repository_impl.dart';

void main() {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final dioOptions = BaseOptions(
    baseUrl: AppConstants.baseUrl,
    queryParameters:  {'api_key': AppConstants.apiKey},
  );

  final Dio dio = Dio(dioOptions);
  final MovieRepository movieRepository = MovieRepositoryImpl(dio);

  runApp(App(movieRepository: movieRepository));
  FlutterNativeSplash.remove();

}

class App extends StatelessWidget {
  const App({super.key, required this.movieRepository});

  final MovieRepository movieRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieGetDiscoverProvider(movieRepository),
        ),
      ],

      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie DB',
          theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
          home: const MoviePage(),

      ),

   
    );
  }
}
