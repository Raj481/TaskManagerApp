import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlinetask/screens/setting_screen.dart';
import '../firebase/firestore_handler.dart';
import 'profile_screen.dart';
import '../database/task_model.dart';
import '../database/local_database.dart';
import 'srearch_screen.dart';
import 'widgets/task_form.dart';
import 'widgets/task_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> _tasks = [];
  var drawerIndex =0;
  var title = 'Home';


  void _addTask(TaskModel task) async {
    await LocalDatabase.addTask(task);
    setState(() => _tasks.add(task));
  }

  void _deleteTask(TaskModel task) async {

    print(">>>>");
    print(task.toMap());
    _tasks.remove(task);
    await LocalDatabase.deleteTask(task.id ?? 0);
    setState(() => _tasks.remove(task));
  }


  Future reloadData() async {
    await LocalDatabase.getTaskData().then((value){

      if(value != null){

        setState(() {
          _tasks = value.map((data)=> TaskModel.fromMap(data)).toList();
        });

        FireStoreHandler().saveOnFireStore(_tasks);
      }
    });
  }

  Widget selectedIconStyle(IconData icon,int index){

    if(drawerIndex == index){
     return  Icon(icon, color: Colors.deepPurple,);
    }
    return  Icon(icon);
  }
  TextStyle selectedTextStyle(int index){

    if(drawerIndex == index){
      return const TextStyle(
        color: Colors.deepPurple,
        fontWeight: FontWeight.bold,
      );
    }
    return TextStyle();
  }

  @override
  void initState() {
    super.initState();
    reloadData();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(

      initialIndex: drawerIndex,
      length: 3,
      child: Scaffold(
        bottomNavigationBar:  BottomNavigationBar(
          currentIndex: drawerIndex,
        onTap: (index) => setState(() {
          drawerIndex = index;

          if(index == 0){
            title = "Home";
          }

          if(index == 1){
            title = "Search";
          }

          if(index == 2){
            title = "Profile";
          }
        }),
        items:  const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
        icon: Icon(Icons.home),
    label: 'Home',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.search),
    label: 'Search',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Profile',
    ),
    ],
        ),
        appBar: AppBar(
          title: Text(title),

        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Menu', style: TextStyle(color: Colors.white)),
              ),
              ListTile(

                leading: selectedIconStyle(Icons.home,0),
                title: Text('Home',
                style: selectedTextStyle(0),
                ),

                onTap: () {
                  setState(() {
                    drawerIndex = 0;
                    title = "Home";
                  });
                  Navigator.pop(context);
                }
                ),



              ListTile(
                leading: selectedIconStyle(Icons.person,1),
                title:  Text('Profile', style: selectedTextStyle(1),),
                  onTap: () {
                    setState(() {
                      drawerIndex = 2;
                      title = "Profile";
                    });
                    Navigator.pop(context);
                  }
              ),
              ListTile(
                leading: selectedIconStyle(Icons.settings,2),
                title: Text('Settings', style: selectedTextStyle(2),),
                  onTap: () {
                    // setState(() {
                    //   drawerIndex = 3;
                    // });
                    // Navigator.pop(context);
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),);


  }
              ),
            ],
          ),
        ),
        body: FutureBuilder(future: Future.value(drawerIndex), builder: (_, data){

          if(drawerIndex == 0){
            return _buildTaskList();
          }
          if(drawerIndex == 1){
            return SearchScreen();
          }
          if(drawerIndex == 2){
            return ProfileScreen();
          }
          if(drawerIndex == 3){
            return SettingsScreen();
          }

          return _buildTaskList();
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (_) => TaskForm(onAddTask: _addTask),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        return TaskListItem(
          task: _tasks[index],
          onDelete: (value){
           setState(() {
             _deleteTask(value);
           });
           FireStoreHandler().saveOnFireStore(_tasks);
          }, onEdit: (value ) {

           setState(() {
             titleController.text = _tasks[index].title;
             descriptioncontroller.text = _tasks[index].description;
           });
          _showEditDialog(index);

        },
        );
      },
    );
  }

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptioncontroller = TextEditingController();

  void _showEditDialog(int index) {

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: descriptioncontroller,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Update the data with new values
                setState(() {
                  _tasks[index].title = titleController.text;
                  _tasks[index].description = descriptioncontroller.text;
                });
                await LocalDatabase.updateTask(_tasks[index]).whenComplete(() async {
                  await FireStoreHandler().saveOnFireStore(_tasks).whenComplete((){
                    Navigator.pop(context);
                  });
                });
               // Close the dialog
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without saving
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }


}

