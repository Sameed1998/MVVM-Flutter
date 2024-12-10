import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/res/app_url.dart';

class HomeRepository{
  BaseApiservices _apiservices = Networkapiservice();

  Future<MovieListModel> fetchMoviesList() async{
    try {
      dynamic response = await _apiservices.getGetApiResponse(AppUrl.moviesListEndpoint);
      return response = MovieListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}