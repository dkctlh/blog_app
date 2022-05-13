import 'dart:ffi';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:blog_app/models/blogs_model.dart';
import 'package:blog_app/models/categories_model.dart';
import 'package:flutter/cupertino.dart';

abstract class IAppService {
  Future<String?> signIn(TextEditingController email,
      TextEditingController pass, BuildContext ctx, String? token);
  Future<String?> signUp(
      TextEditingController email,
      TextEditingController pass,
      TextEditingController rePass,
      BuildContext ctx);
  Future<Void?> logOut(String? token, BuildContext ctx);
  Future<CategoriesModel?> fetchCategories(String? token);
  Future<BlogsModel?> fetchBlogs(String? token, String? catId);
  Future<dynamic> toggleFavorite(String? token, String blogID);
  Future<XFile?> getImage(ImagePicker p, ImageSource src);
  Future<Position> determinePosition();
  Future<dynamic> updateProfile(String? token, String long, String lat);
}
