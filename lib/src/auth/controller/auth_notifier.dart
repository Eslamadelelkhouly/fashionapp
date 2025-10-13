import 'dart:convert';
import 'dart:developer';

import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/environment.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/error_modal.dart';
import 'package:fashionapp/src/auth/models/login_models.dart';
import 'package:fashionapp/src/auth/models/profile_model.dart';
import 'package:fashionapp/src/auth/models/register_model.dart';
import 'package:fashionapp/src/auth/models/token_model.dart';
import 'package:fashionapp/src/entrypoint/controller/bottom_tab_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AutthNotifier with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  bool _RisLoading = false;
  bool get RisLoading => _RisLoading;

  void setRLoading() {
    _RisLoading = !_RisLoading;
    notifyListeners();
  }

  void login(LoginModel data, BuildContext ctx) async {
    setLoading(true);
    try {
      log(data.toJson().toString());
      var url =
          Uri.parse('https://f5ecc3f9774b.ngrok-free.app/auth/token/login');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data.toJson()),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        String accessToken = TokenModel.fromJson(jsonResponse).authToken;
        log('Login successful. Token: $accessToken');
        getUser(accessToken, ctx);
        setLoading(false);
        ctx.push('/home');
      }
    } catch (e) {
      log(e.toString());
      setLoading(false);
      showErrorPopup(ctx, AppText.kErrorLogin, null, null);
    }
  }

  void register(RegisterModel data, BuildContext ctx) async {
    setRLoading();
    try {
      log(data.toJson().toString());
      var url = Uri.parse('https://f5ecc3f9774b.ngrok-free.app/auth/users/');
      log(url.toString());
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data.toJson()),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 201) {
        log('Registration successful.');
        setRLoading();
        ctx.pop();
      } else if (response.statusCode == 400) {
        setRLoading();
        var data = jsonDecode(response.body);
        showErrorPopup(
          ctx,
          data['password'][0],
          null,
          null,
        );
      }
    } catch (e) {
      log(e.toString());
      setRLoading();
      showErrorPopup(ctx, AppText.kErrorLogin, null, null);
    }
  }

  void getUser(String accessToken, BuildContext ctx) async {
    setLoading(true);
    try {
      var url = Uri.parse('https://f5ecc3f9774b.ngrok-free.app/auth/users/me');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        Storage().setString('accessToken', accessToken);
        setLoading(false);
        log('get user successful:  ${response.body.toString()}');
        Storage().setString(accessToken, response.body);
        log('get user successful. Token: $accessToken');
        ctx.read<TabNotifier>().setcurrentIndex(0);
        ctx.go('/home');
      }
    } catch (e) {
      log(e.toString());
      setLoading(false);
      showErrorPopup(ctx, AppText.kErrorLogin, null, null);
    }
  }

  ProfileModel? getUserData() {
    String? accessToken = Storage().getString('accessToken');
    if (accessToken != null) {
      String? userData = Storage().getString(accessToken);
      if (userData != null) {
        final Map<String, dynamic> jsonResponse = jsonDecode(userData);
        return ProfileModel.fromJson(jsonResponse);
      }
    }
  }
}
