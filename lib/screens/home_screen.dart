import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //traera el servicio de peliculas y lo escuchara
    final movieProvider = Provider.of<MoviesProvider>(context);

    // print(movieProvider.onDisplayMovie);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cine'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //tarjetas arriba
            CardSwiper(movies: movieProvider.onDisplayMovie),
            //tarjeta principales
            MovieSlider(
              movies: movieProvider.onPopularMovie,
              onNextPage: () => movieProvider.getPopularMovies(),
            )
          ],
        ),
      ),
    );
  }
}
