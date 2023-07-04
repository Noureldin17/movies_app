import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/movie_model.dart';

abstract class MoviesLocalDatasource {
  Future<List<Movie>> getCachedMovies(String type);

  Future<Unit> cacheMovies(List<Movie> movies, String type);
}

class MoviesLocalImpl implements MoviesLocalDatasource {
  final SharedPreferences sharedPreferences;

  MoviesLocalImpl(this.sharedPreferences);

  @override
  Future<Unit> cacheMovies(List<Movie> movies, String type) {
    try {
      List list = getCachedMovies(type) as List<dynamic>;
      List moviesList =
          movies.map<Map<String, dynamic>>((movie) => movie.toJson()).toList();
      list.add(moviesList);
      sharedPreferences.setString("${type}_Cached_Movies", jsonEncode(list));
      return Future.value(unit);
    } catch (e) {
      List moviesList =
          movies.map<Map<String, dynamic>>((movie) => movie.toJson()).toList();
      sharedPreferences.setString(
          "${type}_Cached_Movies", jsonEncode(moviesList));
      return Future.value(unit);
    }
  }

  @override
  Future<List<Movie>> getCachedMovies(String type) {
    final jsonString = sharedPreferences.getString("${type}_Cached_Movies");

    if (jsonString != null) {
      List decodedJson = jsonDecode(jsonString);
      List<Movie> jsonToMovies =
          decodedJson.map<Movie>((movie) => Movie.fromJson(movie)).toList();
      return Future.value(jsonToMovies);
    } else {
      throw EmptyCacheException();
    }
  }
}
