import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:front_end/page/add_page.dart';
import 'package:front_end/provider/notes_provider.dart';
import 'package:provider/provider.dart';

import 'modals/note.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    noteProvider notesprovider = Provider.of<noteProvider>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Notes App'),
        ),
        body: (notesprovider.isloading == false)
            ? SafeArea(
                child: (notesprovider.notes.length > 0)
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: notesprovider.notes.length,
                        itemBuilder: (context, index) {
                          Note currentNote = notesprovider.notes[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => AddNewPage(
                                          isupdate: true, note: currentNote)));
                            },
                            onLongPress: () {
                              notesprovider.deleteNotes(currentNote);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey)),
                              margin: const EdgeInsets.all(6),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentNote.title!,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    currentNote.content!,
                                    maxLines: 5,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                    : const Center(child: Text("No Notes yet")),
              )
            : CircularProgressIndicator(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => AddNewPage(
                            isupdate: false,
                          )));
            },
            child: const Icon(Icons.add)));
  }
}
