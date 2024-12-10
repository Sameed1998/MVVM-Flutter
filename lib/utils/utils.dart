import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {

  static double averageRating(List<int> rating){
    var averageRating = 0;
    for(int i=0;i<rating.length;i++){
      averageRating = averageRating + rating[i];
    }
    return double.parse((averageRating/rating.length).toStringAsFixed(1));
  }

  static void fieldFocusChange(BuildContext context ,FocusNode current,FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message){
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white
      );
  }

  static flushBarErrorMessage(String message,BuildContext context){
    showFlushbar(
      context: context, 
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        titleColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        reverseAnimationCurve: Curves.easeInOut,
        flushbarPosition: FlushbarPosition.TOP,
        positionOffset: 20,
        message: message,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        icon: const Icon(Icons.error,size: 28,color: Colors.white,),
      )..show(context)
      );
  }

  static snackBar(String message,BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:Text(message),backgroundColor: Colors.red,)
    );
  }
}