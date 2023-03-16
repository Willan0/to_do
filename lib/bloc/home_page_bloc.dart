import 'package:flutter/cupertino.dart';
import 'package:to_do/data/data_apply/firebase_data_apply.dart';
import 'package:to_do/data/data_apply/firebase_data_apply_impl.dart';
import 'package:to_do/data/vos/task_vo.dart';

class HomePageBloc extends ChangeNotifier{
  // state variable
  bool _dispose = false;
  List<TaskVO>? _taskVOList ;

  // getter
  List<TaskVO>? get getTaskVOList => _taskVOList;

  final FireBaseDataApply _dataApply = FireBaseDataApplyImpl();

  HomePageBloc(){
    _dataApply.getAllTask().listen((event) {
      _taskVOList = event;
      notifyListeners();
    });
  }

  Future deleteTask(int id){
    return _dataApply.deleteTask(id);
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