import 'package:flutter/foundation.dart';

class LoginBloc extends ChangeNotifier{
  // state variable
  bool _dispose = false;
  bool _visibility = true;

  // getter
  bool get getVisibility => _visibility;

  void setVisibility (){
    if(_visibility== true){
      _visibility = false;
    }else{
      _visibility = true;
    }
    notifyListeners();
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    if(!_dispose){
      super.notifyListeners();
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dispose = true;
  }
}