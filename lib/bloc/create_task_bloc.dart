import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/data/data_apply/firebase_data_apply.dart';
import 'package:to_do/data/data_apply/firebase_data_apply_impl.dart';
import 'package:to_do/data/vos/task_vo.dart';

class CreateTaskBloc extends ChangeNotifier{
  bool _dispose = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TaskVO? _taskVO;
  String _title = '';
  String _note = '';
  String _description = '';
  String _date = '';
  String _time = '';
  DateTime _dateTime = DateTime.now();


  // getter

  TextEditingController get getTitleController => _titleController;
  TextEditingController get getNoteController => _noteController;
  TextEditingController get getDescriptionController => _descriptionController;
  String get getTitle => _title;
  String get getNote => _note;
  String get getDescription => _description;
  TaskVO? get getTaskVO => _taskVO;
  String get getDate => _date;
  String get getTime => _time;
  DateTime get getDateTime => _dateTime;

  Future onTapAdd(){
    if(_taskVO!= null){
      _taskVO?.title = _title;
      _taskVO?.note = _note;
      _taskVO?.description = _description;
      _taskVO?.time = _time;
      _taskVO?.date = _date;
    }
    return _dataApply.createTask(_title, _note, _description,_date,_time, _taskVO);
  }
  // state instance
  final FireBaseDataApply _dataApply = FireBaseDataApplyImpl();

  void setDateTime(DateTime? dateTime){
    if(dateTime!= null){
      _dateTime = dateTime;
      _date = DateFormat.yMMMd().format(_dateTime);
      notifyListeners();
    }
  }
  CreateTaskBloc(int postId){
    if(postId!= -1){
      _dataApply.getTaskById(postId).then((value) {
        _taskVO = value;
        notifyListeners();
        _titleController = TextEditingController(text: _taskVO?.title);
        _descriptionController = TextEditingController(text: _taskVO?.description);
        _noteController = TextEditingController(text: _taskVO?.note);
      });

    }
    _date = DateFormat.yMMMd().format(_dateTime);
    _time = DateFormat.jm().format(_dateTime);
    notifyListeners();


  }


  void setEdit(){
   _title = _titleController.text;
   _note = _noteController.text;
   _description = _descriptionController.text;
   notifyListeners();
  }



  @override
  void notifyListeners() {
    if(!_dispose){
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
    _titleController.dispose();
    _noteController.dispose();
    _descriptionController.dispose();
  }
}