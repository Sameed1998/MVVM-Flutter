import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier{
  final _myRepo = AppRepository();
  UserViewModel userData = UserViewModel();


  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading=value;
    notifyListeners();
  }
  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setSignupLoading(bool value){
    _signUpLoading=value;
    notifyListeners();
  }
  
  Future<void> loginApi(dynamic data, BuildContext context) async{
    setLoading(true);
    _myRepo.loginApi(data)
    .then((onValue){
      if(kDebugMode){
      Utils.flushBarErrorMessage(onValue.toString(),context);
      print(onValue);
      }
      final userPreference = Provider.of<UserViewModel>(context, listen:false);
      userPreference.saveUser(
        UserModel(
          token: onValue['token'].toString()
        )
      );
      Navigator.pushNamed(context, RoutesName.home);
      setLoading(false);
    })
    .onError((error,stackTrace){
      if(kDebugMode){
      Utils.flushBarErrorMessage(error.toString(),context);
      print("login error: ${error}");
      }
      setLoading(false);
    });
    
  }
  Future<void> signUpApi(dynamic data, BuildContext context) async{
    setSignupLoading(true);
    _myRepo.signUpApi(data)
    .then((onValue){
      if(kDebugMode){
      Utils.flushBarErrorMessage(onValue.toString(),context);
      print(onValue);
      }
      Navigator.pushNamed(context, RoutesName.home);
      setSignupLoading(false);
    })
    .onError((error,stackTrace){
      if(kDebugMode){
      Utils.flushBarErrorMessage(error.toString(),context);
      print(error);
      }
      setSignupLoading(false);
    });
    
  }
}