import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:peliculas_app/Models/models.dart';
import 'package:peliculas_app/widgets/casting_cards.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _customAppbar(movie),
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterAndTitle(movie),
            _Overriew(),
            _Overriew(),
            _Overriew(),
            _Overriew(),
            CastingCards()
          ]))
        ],
      ),
    );
  }
}

// barra que cuando se encoja sea igual a cualquier barra normal
class _customAppbar extends StatelessWidget {
  final Movie movie;

  const _customAppbar(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 10),
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(
            this.movie.title,
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage("assets/loading.gif"),
          image: NetworkImage(this.movie.fullImg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;
  const _PosterAndTitle(
    this.movie, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(this.movie.fullImg),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                ),
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_outline,
                      size: 15,
                      color: Colors.grey,
                    ),
                    Text(
                      "${movie.voteAverage}",
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overriew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        'Sit occaecat ea Lorem culpa velit qui magna pariatur adipisicing. Tempor nulla reprehenderit sunt quis sit id ipsum Lorem et et pariatur deserunt reprehenderit. Sunt sunt fugiat deserunt Lorem cillum cupidatat aute laboris sit. Laborum exercitation eiusmod cupidatat aute sunt. Reprehenderit pariatur veniam laboris exercitation eiusmod do. Nulla ipsum in qui ex irure minim. Magna fugiat laboris culpa labore ipsum incididunt duis minim laborum esse voluptate dolore laborum.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
