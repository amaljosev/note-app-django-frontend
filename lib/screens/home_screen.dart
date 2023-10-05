import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tododjango/models/models.dart';
import 'package:tododjango/repositories/api_functions.dart';
import 'package:tododjango/screens/edit_form.dart';
import 'package:tododjango/screens/form_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

final apiController = Get.put(Api());

class HomeState extends State<Home> {
  late Future<List<Note>> employees;
  @override
  void initState() {
    super.initState();
    employees = apiController.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Center(
        child: FutureBuilder<List<Note>>(
          future: employees,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  childAspectRatio: 1 / 0.8,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data[index];
                  final id = data.id;
                  return GestureDetector(
                    onTap: () => Get.to(EditScreen(snapshot: data, id: id)),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(
                          color: Colors.greenAccent, 
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: Text(
                                  data.title,
                                  maxLines: 1,
                                )),
                                IconButton(
                                    onPressed: () =>
                                        apiController.deleteNote(id),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.greenAccent, 
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Flexible(
                                child: Text(
                              data.description,
                              overflow: TextOverflow.fade,
                            )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const SizedBox.expand(
                child: Center(child: Text('Empty Notes')),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(const FormScreen()),
          child: const Icon(Icons.add)),
    );
  }
}
// ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (BuildContext context, int index) {
//                 var data = snapshot.data[index];
//                 final id = data.id;
//                 return Card(
//                   child: ListTile(
//                     onTap: () => Get.to(EditScreen(snapshot: data,id: id,)), 
//                     title: Text(
//                       data.title,
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                     trailing: IconButton(
//                         onPressed: () {
//                           apiController.deleteNote(id);
//                         },
//                         icon: const Icon(Icons.delete)),
//                   ),
//                 );
//               },
//             );