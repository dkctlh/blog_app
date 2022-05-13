import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:blog_app/Utils/snackbar_widget.dart';
import 'package:blog_app/models/blogs_model.dart';
import 'package:blog_app/models/categories_model.dart';
import 'package:blog_app/screens/logIn_screen.dart';
import 'package:blog_app/screens/tab_screen.dart';
import 'package:blog_app/services/IAppService.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class AppService extends IAppService {
  @override
  Future<String?> signIn(TextEditingController email,
      TextEditingController pass, BuildContext ctx, String? token) async {
    if (email.text.isNotEmpty && pass.text.isNotEmpty) {
      var jsonData;
      var response = await http.post(
        Uri.parse("http://test020.internative.net/Login/SignIn"),
        body: jsonEncode(
            {"Email": email.text.trim(), "Password": pass.text.trim()}),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      jsonData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        // jsonData = json.decode(response.body);
        if (!jsonData["HasError"]) {
          log("error:$token , ${response.statusCode} ");
          Navigator.of(ctx).pushReplacementNamed(TabScreen.routename);
          return token = jsonData["Data"]["Token"];
        } else {
          snackBar(jsonData["Message"]);
          String? message = jsonData["Message"] as String;
          log("message:$message");
          return null;
        }
      } else {
        snackBar("Bir hata oluştu");
      }
    }
    snackBar("Bir hata oluştu");
  }

  @override
  Future<String?> signUp(
      TextEditingController email,
      TextEditingController pass,
      TextEditingController rePass,
      BuildContext ctx) async {
    var jsonData;
    var response = await http.post(
      Uri.parse("http://test020.internative.net/Login/SignUp"),
      body: jsonEncode({
        "Email": email.text.trim(),
        "Password": pass.text.trim(),
        "PasswordRetry": rePass.text.trim()
      }),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      jsonData = json.decode(response.body);
      if (!jsonData["HasError"]) {
        log("message:${jsonData["HasError"]}");

        Navigator.of(ctx).pushReplacementNamed(TabScreen.routename);
        return jsonData["Data"]["Token"];
      } else {
        snackBar(jsonData["Message"]);
        log("HasError:${jsonData["HasError"]}");
        String? message = jsonData["Message"] as String;
        log("message:$message");
        return null;
      }
    } else {
      snackBar("Bir hata oluştu.");
    }
  }

  @override
  Future<CategoriesModel?> fetchCategories(String? token) async {
    var response = await http.get(
        Uri.parse("http://test020.internative.net/Blog/GetCategories"),
        headers: {"accept": "*/*", "Authorization": "Bearer $token"});
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return CategoriesModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  @override
  Future<BlogsModel?> fetchBlogs(String? token, String? catId) async {
    Map<String, dynamic> body = {
      "CategoryId": catId ?? "",
    };

    var response = await http.post(
      Uri.parse("http://test020.internative.net/Blog/GetBlogs"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: json.encode(body),
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return BlogsModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  @override
  Future<dynamic> toggleFavorite(String? token, String blogID) async {
    Map<String, dynamic> body = {
      "Id": blogID,
    };

    var response = await http.post(
      Uri.parse("http://test020.internative.net/Blog/ToggleFavorite"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: json.encode(body),
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    }

    return jsonDecode(response.body)["Message"];
  }

  @override
  Future<XFile?> getImage(ImagePicker p, ImageSource src) async {
    return await p.pickImage(source: src);
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  @override
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        snackBar('Location permissions are denied');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<Void?> logOut(String? token, BuildContext ctx) async {
    if (token != null) {
      token = null;
      snackBar("Cikis basarili");
      Navigator.of(ctx)
          .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
    } else {
      snackBar("Cikis basarili");
      Navigator.of(ctx)
          .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
    }
    return null;
  }

  @override
  Future updateProfile(String? token, String long, String lat) async {
    Map<String, dynamic> body = {
      "Image": "image",
      "Location": {"Longtitude": long, "Latitude": lat}
    };

    var response = await http.post(
      Uri.parse("http://test020.internative.net/Account/Update"),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: json.encode(body),
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      snackBar(jsonDecode(response.body)["Message"]);
      return true;
    }
    snackBar(jsonDecode(response.body)["Message"]);
    return jsonDecode(response.body)["Message"];
  }
}
