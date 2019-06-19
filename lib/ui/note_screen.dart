import 'package:flutter/material.dart';
import 'package:serious_gaming/model/note.dart';
import 'package:serious_gaming/service/firebase_firestore_service.dart';

class NoteScreen extends StatefulWidget {
  final Request note;
  NoteScreen(this.note);

  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  TextEditingController _nameController;
  TextEditingController _orgController;
  TextEditingController _venueController;
  TextEditingController _reasonController;

  @override
  void initState() {
    super.initState();

    _nameController = new TextEditingController(text: widget.note.title);
    _orgController = new TextEditingController(text: widget.note.org);
    _venueController = new TextEditingController(text: widget.note.venue);
    _reasonController = new TextEditingController(text: widget.note.reason);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Request')),
      body:  SingleChildScrollView(scrollDirection: Axis.vertical,child:Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _orgController,
              decoration: InputDecoration(labelText: 'Organization'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _venueController,
              decoration: InputDecoration(labelText: 'Venue'),
            ),
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(labelText: 'Reason'),
              maxLines: 5,
            ),
            RaisedButton(
              child: (widget.note.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.note.id != null) {
                  db
                      .updateNote(
                      Request(widget.note.id, _nameController.text, _orgController.text, _venueController.text, _reasonController.text))
                      .then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  db.createNote(_nameController.text, _orgController.text, _venueController.text, _reasonController.text).then((_) {
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
