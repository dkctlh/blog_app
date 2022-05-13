import 'dart:developer';

import 'package:blog_app/models/blogs_model.dart';
import 'package:blog_app/services/IAppService.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/categories_model.dart';

class AppState with ChangeNotifier {
  final IAppService appService;

  AppState({
    required this.appService,
  }) {
    getToken();
    getLocation();
  }
  late String? token;

  CategoriesModel? categories;

  BlogsModel? blogs;

  XFile? image;
  Position? loc;

  getToken() async {
    var sPref = await SharedPreferences.getInstance();
    token = sPref.getString("Token");
  }

  signIn(
      {required TextEditingController email,
      required TextEditingController password,
      required BuildContext ctx}) async {
    token = await appService.signIn(email, password, ctx, token);
    if (token != null) {
      setTokenDevice(token: token as String);
    }
  }

  signUp(
      {required TextEditingController email,
      required TextEditingController password,
      required TextEditingController rePassword,
      required BuildContext ctx}) async {
    token = await appService.signUp(
      email,
      password,
      rePassword,
      ctx,
    );
    if (token != null) {
      setTokenDevice(token: token as String);
    }
  }

  setTokenDevice({required String token}) async {
    var sPref = await SharedPreferences.getInstance();
    sPref.setString("Token", token);
    this.token = token;
    //notifyListeners();
  }

  getCategories() async {
    categories = await appService.fetchCategories(token);

    notifyListeners();
  }

  getBlogs(String? catId) async {
    blogs = await appService.fetchBlogs(
      token,
      catId,
    );
    notifyListeners();
  }

  toggleFavorite(BlogModel blog) async {
    var response = await appService.toggleFavorite(token, blog.id!);

    if (response) {
      var blogIndex =
          blogs!.data!.indexWhere((element) => element.id == blog.id);
      if (blogIndex != -1) {
        blogs!.data![blogIndex].isFavorited =
            !blogs!.data![blogIndex].isFavorited!;
        notifyListeners();
      }
    } else {
      ///TODO: Show error snackbar.
    }
  }

  getImage(ImagePicker p, ImageSource src) async {
    image = await appService.getImage(p, src);
    notifyListeners();
  }

  removeImage() {
    image = null;
    notifyListeners();
  }

  getLocation() async {
    loc = await appService.determinePosition();

    notifyListeners();
  }

  logOut(BuildContext ctx) async {
    SharedPreferences sPref = await SharedPreferences.getInstance();
    sPref.remove("Token");
    await appService.logOut(token, ctx);
  }

  updateProfile() async {
    await appService.updateProfile(
        token, loc!.longitude.toString(), loc!.latitude.toString());
    notifyListeners();
  }
}
