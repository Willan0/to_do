import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/constant/fire_base_constant.dart';
import 'package:to_do/data/vos/task_vo.dart';
import 'package:to_do/network/data_agent/firebase_data_agent.dart';

class CloudStoreImpl extends FireBaseDataAgent{

  CloudStoreImpl._();
  static final CloudStoreImpl _singleton = CloudStoreImpl._();
  factory CloudStoreImpl() => _singleton;

  final FirebaseFirestore _cloudFireStore = FirebaseFirestore.instance;
  @override
  Future<void> createTask(TaskVO taskVO) {
    return _cloudFireStore.collection(kRootCollectionPath)
        .doc(taskVO.id.toString()).set(taskVO.toJson());
  }

  @override
  Stream<List<TaskVO>?> getAllTask() {
    return _cloudFireStore.collection(kRootCollectionPath).snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((document) {
        return TaskVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Future<void> deleteTask(int id) {
    return
      _cloudFireStore.collection(kRootCollectionPath)
      .doc(id.toString())
      .delete();
  }

  @override
  Future<TaskVO> getTaskById(int id) {
    return
        _cloudFireStore.collection(kRootCollectionPath)
        .doc(id.toString())
        .get()
        .asStream()
        .map((documentSnapshot) =>
            TaskVO.fromJson(documentSnapshot.data() ?? {}))
            .first;
  }

}