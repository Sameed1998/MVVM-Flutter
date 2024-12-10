import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/res/app_url.dart';

class AppRepository{
  BaseApiservices _apiservices = Networkapiservice();

  Future<dynamic> loginApi(dynamic data) async{
    try {
      dynamic response = await _apiservices.getPostApiResponse(AppUrl.loginEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> signUpApi(dynamic data) async{
    try {
      dynamic response = await _apiservices.getPostApiResponse(AppUrl.registerEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}