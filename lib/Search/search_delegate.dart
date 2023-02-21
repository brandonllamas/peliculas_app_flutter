import 'package:flutter/material.dart';
import 'package:peliculas_app/Models/models.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => "Buscar Pelicula";

// estp es el texto que eta a la derecha
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

// es la misma mda pero a la izquierda
  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text("buildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return Container(
        child: const Center(
          child: Icon(Icons.movie_creation_outlined,
              color: Colors.black38, size: 130),
        ),
      );
    }
    final movieProvioder = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: movieProvioder.seachMovies(query),
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: const Center(
              child: Icon(Icons.movie_creation_outlined,
                  color: Colors.black38, size: 130),
            ),
          );
        }
        final moviues = snapshot.data!;

        return ListView.builder(
          itemCount: moviues.length,
          itemBuilder: (context, index) {
            return _MovieItem(
              movie: moviues[index],
            );
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroId = "seach-delegate-${movie.id}";
    return ListTile(
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
            width: 50,
            fit: BoxFit.contain,
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage(movie.fullImg)),
      ),
    );
  }
}
