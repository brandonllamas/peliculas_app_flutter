import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/Models/models.dart';
import 'package:peliculas_app/Models/seach_response.dart';
import 'package:peliculas_app/helpers/debouncer.dart';

//esta mda es la que hara las peticiones al servidor
class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "es-ES";
  final String _apikey = "4939f9d834e1ecb397cd47a3ab5092c0";

  List<Movie> onDisplayMovie = [];
  List<Movie> onPopularMovie = [];

// el int es para el id de a pelicula
  Map<int, List<Cast>> onMovieCast = {};

  final StreamController<List<Movie>> _suggetionsStreamController =
      new StreamController.broadcast();

  Stream<List<Movie>> get suggetionStream =>
      this._suggetionsStreamController.stream;

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  int _popularPage = 0;

  MoviesProvider() {
    getDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apikey,
      'language': _language,
      'page': '${page}',
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getDisplayMovies() async {
    final jsonData = await this._getJsonData('3/movie/now_playing');
    final noewPlaying = NowPlayerResponse.fromRawJson(jsonData);
    // print(noewPlaying);
    onDisplayMovie = noewPlaying.results;

    // hey esto redibuja a los widget que utilicen esa mda
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);

    final popularResponse = PopularResponse.fromRawJson(jsonData);
    // print(noewPlaying);
    // OSEA pon las respuesta y mete el resto
    onPopularMovie = [...onPopularMovie, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int MovieId) async {
    // revisar mapa
    if (onMovieCast.containsKey(MovieId)) return onMovieCast[MovieId]!;

    // pdiiendo e servidor
    final jsonData = await this._getJsonData('/3/movie/${MovieId}/credits');
    final creditRsponsed = Credits_Response.fromRawJson(jsonData);
    print("llega cole");
    onMovieCast[MovieId] = creditRsponsed.cast;

    return creditRsponsed.cast;
  }

  Future<List<Movie>> seachMovies(String query) async {
    var url = Uri.https(_baseUrl, "3/search/movie", {
      'api_key': _apikey,
      'language': _language,
      'query': '${query}',
    });
    final response = await http.get(url);
    final movieSearch = SearchResponse.fromRawJson(response.body);

    return movieSearch.results;
  }

  void getSuggetionsByQuery(String query) {
    debouncer.value = "";

    debouncer.onValue = (value) async {
      // print("tenemos vlaor a buscar : $value");

      final restulr = await this.seachMovies(value);

      this._suggetionsStreamController.add(restulr);
    };

    final timer = Timer.periodic(Duration(microseconds: 300), (timer) {
      debouncer.value = query;
    });

    Future.delayed(Duration(microseconds: 301)).then((value) => timer.cancel());
  }
}
