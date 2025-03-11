import 'package:flutter/material.dart';
import 'package:iphone_note/folderData.dart';
import 'package:iphone_note/noteData.dart';
import 'package:iphone_note/notePage.dart';

class Folderpage extends StatefulWidget {
  final String folderName;
  final List<note> notes;

  const Folderpage({super.key, required this.folderName, required this.notes});

  @override
  State<Folderpage> createState() => _FolderpageState();
}

class _FolderpageState extends State<Folderpage> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
              folder(notes: widget.notes, title: widget.folderName),
            );
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          TextButton(
            child: Text(
              isEditing ? "완료" : "편집",
              style: TextStyle(color: Colors.orange),
            ),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              widget.folderName,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
            ),
          ),
          Container(decoration: BoxDecoration(color: Colors.grey)),
          Flexible(
            child:
                widget.notes.isNotEmpty
                    ? ListView.builder(
                      itemCount: widget.notes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => Notepage(
                                      selecedNote: widget.notes[index],
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.only(left: 20),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    if (isEditing)
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            widget.notes.removeAt(index);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 7,
                                          ),
                                          child: Text(
                                            widget.notes[index].title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                            top: 7,
                                          ),
                                          child: Text(
                                            widget.notes[index].notestring
                                                .split('\n')
                                                .first,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                    : Text("생성된 노트가 없습니다."),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.only(left: 300, top: 15),
        height: 35,
        child: IconButton(
          icon: Icon(Icons.note_add, color: Colors.amber),
          onPressed: () async {
            final note? newnote = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Notepage()),
            );
            if (newnote != null)
              setState(() {
                widget.notes.add(newnote);
              });
          },
        ),
      ),
    );
  }
}
