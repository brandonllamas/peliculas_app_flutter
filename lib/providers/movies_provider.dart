import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/Models/models.dart';

//esta mda es la que hara las peticiones al servidor
class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "es-ES";
  final String _apikey = "4939f9d834e1ecb397cd47a3ab5092c0";

  List<Movie> onDisplayMovie = [];
  List<Movie> onPopularMovie = [];

  MoviesProvider() {
    getDisplayMovies();
  }

  getDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
      'page': '1',
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final noewPlaying = NowPlayerResponse.fromRawJson(response.body);
    // print(noewPlaying);
    onDisplayMovie = noewPlaying.results;

    // hey esto redibuja a los widget que utilicen esa mda
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': '1',
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final popularResponse = PopularResponse.fromRawJson(response.body);
    // print(noewPlaying);
    // OSEA pon las respuesta y mete el resto
    onPopularMovie = [...onPopularMovie, ...popularResponse.results];

    // hey esto redibuja a los widget que utilicen esa mda
    notifyListeners();
  }
}
