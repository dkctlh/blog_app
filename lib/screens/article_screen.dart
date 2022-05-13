import 'package:blog_app/Provider/providerstate.dart';
import 'package:blog_app/models/blogs_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class ArticleDetailScreen extends StatelessWidget {
  static const routeName = "/ArticleDetail";
  final BlogModel blog;
  final VoidCallback onPop;
  const ArticleDetailScreen({Key? key, required this.blog, required this.onPop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, state, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: onPop, icon: const Icon(Icons.chevron_left)),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const SizedBox(),
            const Text("Article Detail"),
            IconButton(
                onPressed: () => state.toggleFavorite(blog),
                icon: Icon(
                  Icons.favorite,
                  color: blog.isFavorited! ? Colors.red : Colors.black,
                )),
          ]),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              Text(blog.title!),
              const SizedBox(height: 16),
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Image.network(blog.image!)),
              const SizedBox(height: 16),
              Html(
                data: blog.content,
              ),
            ],
          ),
        ),
      );
    });
  }
}
