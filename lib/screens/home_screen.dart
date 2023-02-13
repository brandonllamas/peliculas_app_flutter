import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:peliculas_app/widgets/widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            CardSwiper(),
            //tarjeta principales
            MovieSlider()
          ],
        ),
      ),
    );
  }
}
