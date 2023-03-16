import '../vos/task_vo.dart';

abstract class FireBaseDataApply{
  Stream<List<TaskVO>?> getAllTask();

  Future<void> createTask(String title,String note,String description,String date,String time,TaskVO? taskVO);

  Future<void> deleteTask(int id);

  Future<TaskVO> getTaskById(int id);
}