import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:serious_gaming/service/firebase_firestore_service.dart';

import 'package:serious_gaming/model/note.dart';
import 'package:serious_gaming/ui/note_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListViewNote extends StatefulWidget {
  final FirebaseUser user;
  const ListViewNote({

    Key key,
    this.user
  }): super(key:key);



  @override
  _ListViewNoteState createState() => new _ListViewNoteState();



}

class _ListViewNoteState extends State<ListViewNote> {
  List<Request> items;
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  StreamSubscription<QuerySnapshot> noteSub;

  @override
  void initState() {
    super.initState();
    items = new List();

    noteSub?.cancel();
    noteSub = db.getNoteList().listen((QuerySnapshot snapshot) {
      final List<Request> notes = snapshot.documents
          .map((documentSnapshot) => Request.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = notes;
      });
    });
  }


  @override
  void dispose() {
    noteSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UP CEBU PORTAL',
      home: Scaffold(
        appBar: AppBar(
          title: Text('UP CEBU PORTAL'),
          centerTitle: true,
          backgroundColor: Color(0xFFD83227),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){},
            )
          ],
        ),
        drawer: new Drawer(child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("First Name Last"),
              accountEmail: new Text('${widget.user.email}'),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  child: Image.asset('assets/upcebu.png'),
                  backgroundColor: Colors.transparent ,
                ),
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/upcebu.jpg'),
                  fit: BoxFit.fill
                )
              ),
            ),
            new ListTile(
              title: new Text("Requests"),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();

                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new ListViewNote()));
              },
            ),
            new ListTile(
              title: new Text("Chenes"),
              trailing:  new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.pop(context);
                //Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new NoteScreen()));
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("Close"),
              trailing: new Icon(Icons.cancel),
              onTap: () => Navigator.of(context).pop(),
            )
          ],
        ),),
        body: Center(
          child: ListView.builder(
           //shrinkWrap: true,
              itemCount: items.length,
              padding: const EdgeInsets.all(5.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                     Slidable (
                       delegate: new SlidableDrawerDelegate(),
                       actionExtentRatio: 0.25,
                       actions: <Widget>[
                          IconSlideAction(
                             icon: Icons.archive,
                             caption: 'Archive',
                           color: Colors.blue,
                           onTap: () {},
                         ),
                       ],
                       secondaryActions: <Widget>[
                          IconSlideAction(
                            // icon: Icons.more_horiz,
                            icon: FontAwesomeIcons.trash,
                           caption: 'Delete',
                           color: Colors.black45,
                           onTap: () {
                              _deleteNote(context, items[position], position);
                           },
                         ),
                       ],
                       /*onDismissed: (direction){
                        //setState((){
                          _deleteNote(context, items[position], position);
                      //  });
                       },
                       background: Container(
                         color: Colors.redAccent,
                         alignment: Alignment.centerRight,
                         padding: EdgeInsets.all(10),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             Icon(
                               FontAwesomeIcons.trash,
                               color: Colors.white,
                             ),
                             Padding(
                                padding: EdgeInsets.all(2),
                            ),
                             Text('Delete', style: TextStyle(color: Colors.white))
                           ],
                         ),
                       ),*/
                     child:ListTile(
                      title: Text(
                        '${items[position].title}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Text(
                        '${items[position].org}',
                        style: new TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      leading: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10)),
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 15.0,
                            child: Text(
                              '${position + 1}',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          /*Expanded(child: IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => _deleteNote(context, items[position], position))),*/
                        ],
                      ),
                      onTap: () => _navigateToNote(context, items[position]),
                    ),
                       key: ObjectKey(items),
                     ),
                      //key: ObjectKey(value),

                  ],
                );
              }),
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewNote(context),
        ),
      ),
    );
  }

  void _deleteNote(BuildContext context, Request note, int position) async {
    db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToNote(BuildContext context, Request note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );
  }

  void _createNewNote(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Request(null, '', '', '', ''))),
    );
  }

}


