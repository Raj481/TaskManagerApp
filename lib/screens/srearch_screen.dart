import 'package:flutter/material.dart';
import 'package:onlinetask/database/local_database.dart';
import 'package:onlinetask/database/task_model.dart';
import 'package:onlinetask/firebase/firestore_handler.dart';
import 'package:onlinetask/screens/widgets/task_list_item.dart';

//class SearchScreen extends StatelessWidget {

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<TaskModel> _tasks = [];

  List<TaskModel> _searchResults = [];

// Data gate from database
  reloadData() {
    print(">>>>>>search reload");
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await LocalDatabase.getTaskData().then((value){

        if(value != null){

          setState(() {
            _tasks = value.map((data)=> TaskModel.fromMap(data)).toList();
          });

        }
      });
    });
  }

// Filter data for search functionality
  filterList(){

    if(_searchController.text.trim().isEmpty){
      setState(() {
        _searchResults = _tasks;
      });
    }else {

      if(_tasks.isEmpty){
        return;
      }else{
        setState(() {

          _searchResults = _tasks.where((value) => value.title.contains(_searchController.text)).toList();
        });
      }

    }

  }

  @override
  void initState() {
    super.initState();
    reloadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Item List',

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Trigger the search when the text changes
                filterList();
              },
            ),
            SizedBox(height: 16),
            // Display search results

            if( _searchController.text.trim().isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return TaskListItem(
                    task: _searchResults[index],
                    showTraling: false,
                    onDelete: (value){
                      setState(() {
                       // _deleteTask(value);
                      });
                      FireStoreHandler().saveOnFireStore(_tasks);
                    }, onEdit: (value ) {

                    setState(() {
                     // titleController.text = _tasks[index].title;
                     // descriptioncontroller.text = _tasks[index].description;
                    });
                   // _showEditDialog(index);

                  },
                  );
                },
              ),
            ),

            if(_searchController.text.trim().isEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    return TaskListItem(
                      task: _tasks[index],
                      showTraling: false,
                      onDelete: (value){
                        setState(() {
                          // _deleteTask(value);
                        });
                        FireStoreHandler().saveOnFireStore(_tasks);
                      }, onEdit: (value ) {

                      setState(() {
                        // titleController.text = _tasks[index].title;
                        // descriptioncontroller.text = _tasks[index].description;
                      });
                      // _showEditDialog(index);

                    },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

