
import 'package:to_do/data/vos/task_vo.dart';

abstract class FireBaseDataAgent{

  Stream<List<TaskVO>?> getAllTask();

  Future<void> createTask(TaskVO taskVO);

  Future<void> deleteTask(int id);

  Future<TaskVO> getTaskById(int id);

}