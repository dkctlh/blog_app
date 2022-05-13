import 'package:blog_app/Provider/providerstate.dart';
import 'package:blog_app/models/blogs_model.dart';
import 'package:blog_app/screens/article_screen.dart';
import 'package:blog_app/widgets/blogs_widget.dart';
import 'package:blog_app/widgets/categories_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/categories_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoriesModel> list = [];
  List<BlogsModel> blist = [];
  BlogModel? selectedBlog;
  bool isLoading = false;

  @override
  void initState() {
    initProvider();
    super.initState();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void initProvider() async {
    changeLoading();
    var app = Provider.of<AppState>(context, listen: false);
    await app.getCategories();
    await app.getBlogs(null);
    changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return selectedBlog != null
        ? ArticleDetailScreen(
            blog: selectedBlog!,
            onPop: () => setState(() => selectedBlog = null),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text("Home"),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Consumer<AppState>(
                      builder: (context, state, child) {
                        var list = state.categories?.data;
                        var blist = state.blogs?.data;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: SizedBox(
                                height: 130,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                    list?.length ?? 3,
                                    (index) => InkWell(
                                      onTap: () async {
                                        changeLoading();
                                        await state.getBlogs(list?[index].id);
                                        changeLoading();
                                      },
                                      child: CategoryView(
                                        image: list?[index].image ?? " ",
                                        title: list?[index].title ?? " ",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Blog",
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: (MediaQuery.of(context).size.height - 130)
                                  .toInt(),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: GridView(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                  ),
                                  children: List.generate(
                                      blist?.length ?? 3,
                                      (index) => BlogView(
                                            onBlogTap: () => setState(() =>
                                                selectedBlog = blist![index]),
                                            blog: blist![index],
                                            onFavToggle: () async => await state
                                                .toggleFavorite(blist[index]),
                                          )),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
            ),
          );
  }
}
