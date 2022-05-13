import 'package:blog_app/constants/colors_constants.dart';
import 'package:blog_app/models/blogs_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_fake.dart';

class BlogView extends StatelessWidget {
  final BlogModel blog;
  final VoidCallback onFavToggle;
  final VoidCallback onBlogTap;
  const BlogView({
    Key? key,
    required this.onBlogTap,
    required this.blog,
    required this.onFavToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBlogTap,
      child: Column(
        children: [
          Expanded(
            flex: 210,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  child: Image.network(
                    blog.image!,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                    ),
                    color: (blog.isFavorited ?? false)
                        ? Colors.red
                        : AppColors.buttonWhiteBg,
                    onPressed: onFavToggle,
                  ),
                )
              ],
            ),
          ),
          Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                bottom: 16,
                right: 16,
              ),
              child: Text(blog.title!),
            ),
          ])
        ],
      ),
    );
  }
}
