
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onlinetask/database/task_model.dart';

class FireStoreHandler{

  var storeDb = FirebaseFirestore.instance;

  // save Firestore

  Future saveOnFireStore(List<TaskModel> dataList) async {

    var ref = storeDb.collection("taskmanager-b1c42.firebasestorage.app");

    var list = List.generate(dataList.length, (index) => dataList[index].toMap());

    ref.doc("tasks").set({"data": list});


  }

}