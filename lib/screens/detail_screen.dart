import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:peliculas_app/widgets/casting_cards.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "no-movie";

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _customAppbar(),
          SliverList(
              delegate: SliverChildListDelegate(const [
            _PosterAndTitle(),
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
            "Movie title",
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage("assets/loading.gif"),
          image: NetworkImage("https://via.placeholder.com/300x400"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage("https://via.placeholder.com/200x300"),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Movie.title",
                style: Theme.of(context).textTheme.headlineSmall,
                overflow: TextOverflow.clip,
                maxLines: 2,
              ),
              Text(
                "Original name",
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
                    'movievoteavergare',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overriew extends StatelessWidget {
  const _Overriew({super.key});

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
