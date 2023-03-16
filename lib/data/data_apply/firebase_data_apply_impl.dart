import 'package:to_do/data/data_apply/firebase_data_apply.dart';
import 'package:to_do/data/vos/task_vo.dart';
import 'package:to_do/network/data_agent/cloud_store_data_agent_impl.dart';
import 'package:to_do/network/data_agent/firebase_data_agent.dart';

class FireBaseDataApplyImpl extends FireBaseDataApply{

  FireBaseDataApplyImpl._();
  static final FireBaseDataApplyImpl _singleton = FireBaseDataApplyImpl._();
  factory FireBaseDataApplyImpl() => _singleton;

  final FireBaseDataAgent _cloudStoreImpl = CloudStoreImpl();


  @override
  Stream<List<TaskVO>?> getAllTask() {
    return _cloudStoreImpl.getAllTask();
  }

  @override
  Future<void> createTask(String title, String note, String description,String date,String time ,TaskVO? taskVO) {

    return _addOrEditTask(title, note, description,date,time, taskVO);
  }
  Future<void> _addOrEditTask(String title, String note, String description,String date,String time,TaskVO? taskVO){
    if(taskVO == null){
      TaskVO task = TaskVO(
          DateTime.now().millisecondsSinceEpoch,
          title,
          note,
          description,
        date,
        time
      );
      return _cloudStoreImpl.createTask(task);
    }
    return _cloudStoreImpl.createTask(taskVO);
  }

  @override
  Future<void> deleteTask(int id) =>
    _cloudStoreImpl.deleteTask(id);


  @override
  Future<TaskVO> getTaskById(int id) => _cloudStoreImpl.getTaskById(id);



}