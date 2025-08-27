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

  void setLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void login(LoginModel data, BuildContext ctx) async {
    setLoading();
    try {
      log(data.toJson().toString());
      var url =
          Uri.parse('https://b2292217954e.ngrok-free.app/auth/token/login');
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
        setLoading();
        ctx.push('/home');
      }
    } catch (e) {
      log(e.toString());
      setLoading();
      showErrorPopup(ctx, AppText.kErrorLogin, null, null);
      setLoading();
    }
  }

  void register(RegisterModel data, BuildContext ctx) async {
    setLoading();
    try {
      log(data.toJson().toString());
      var url = Uri.parse('https://b2292217954e.ngrok-free.app/auth/users/');
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
        setLoading();
        ctx.push('/login');
      } else if (response.statusCode == 400) {
        var data = jsonDecode(response.body);
        showErrorPopup(
          ctx,
          data['password'][0],
          null,
          null,
        );
        setLoading();
      }
    } catch (e) {
      log(e.toString());
      setLoading();
      showErrorPopup(ctx, AppText.kErrorLogin, null, null);
      setLoading();
    }
  }

  void getUser(String accessToken, BuildContext ctx) async {
    setLoading();
    try {
      var url = Uri.parse('https://b2292217954e.ngrok-free.app/auth/users/me');
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
        log('get user successful:  ${response.body.toString()}');
        Storage().setString(accessToken, response.body);
        log('get user successful. Token: $accessToken');
        ctx.read<TabNotifier>().setcurrentIndex(0);
        ctx.go('/home');
        setLoading();
      }
    } catch (e) {
      log(e.toString());
      setLoading();
      showErrorPopup(ctx, AppText.kErrorLogin, null, null);
      setLoading();
    }
  }

  ProfileModel? getUserData(){
    String? accessToken = Storage().getString('accessToken');
    if(accessToken != null){
      String? userData = Storage().getString(accessToken);
      if(userData != null){
        final Map<String, dynamic> jsonResponse = jsonDecode(userData);
        return ProfileModel.fromJson(jsonResponse);
      }
    }
  }
}
