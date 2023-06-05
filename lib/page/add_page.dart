import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:front_end/modals/note.dart';
import 'package:front_end/provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewPage extends StatefulWidget {
  bool isupdate;
  Note? note;
  AddNewPage({super.key, required this.isupdate, this.note});

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentControlller = TextEditingController();
  FocusNode noteFocus = FocusNode();
  void addnewnote() {
    Note newnote = Note(
      id: const Uuid().v1(),
      userid: "dharmendrabaghel2900@gmail.com",
      title: titleController.text,
      content: contentControlller.text,
      dateadded: DateTime.now().toString(),
    );
    Provider.of<noteProvider>(context, listen: false).addNotes(newnote);
    Navigator.pop(context);
  }

  void updatenote() {
    widget.note!.title != titleController.text;
    widget.note!.dateadded != DateTime.now();
    widget.note!.content != contentControlller.text;
    Provider.of<noteProvider>(context, listen: false).updateNotes(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    if (widget.isupdate) {
      titleController.text = widget.note!.title!;
      contentControlller.text = widget.note!.content!;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (widget.isupdate) {
                  updatenote();
                } else {
                  addnewnote();
                }
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                onSubmitted: (val) {
                  if (val != "") {
                    noteFocus.requestFocus();
                  }
                },
                autofocus: (widget.isupdate == true) ? false : true,
                style: TextStyle(
                  fontSize: 30,
                ),
                decoration: InputDecoration(hintText: "Title"),
              ),
              Expanded(
                child: TextField(
                  controller: contentControlller,
                  focusNode: noteFocus,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      hintText: "Note", border: InputBorder.none),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
