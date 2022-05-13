import 'package:blog_app/Provider/providerstate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/blogs_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text("My Favorites"),
      )),
      body: Consumer<AppState>(builder: (context, state, child) {
        var favoritedBlogs = state.blogs?.data
                ?.where((element) => element.isFavorited!)
                .toList() ??
            [];
        if (favoritedBlogs.isEmpty) {
          return const Center(child: Text("There are no favorited blogs yet!"));
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
            child: GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
              ),
              children: List.generate(
                  favoritedBlogs.length,
                  (index) => BlogView(
                        onBlogTap: () {},
                        blog: favoritedBlogs[index],
                        onFavToggle: () async =>
                            await state.toggleFavorite(favoritedBlogs[index]),
                      )),
            ),
          );
        }
      }),
    );
  }
}
