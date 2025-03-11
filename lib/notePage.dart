import 'package:flutter/material.dart';
import 'package:iphone_note/noteData.dart';

class Notepage extends StatefulWidget {
  final note? selecedNote;
  const Notepage({super.key, this.selecedNote});

  @override
  State<Notepage> createState() => _NotepageState();
}

class _NotepageState extends State<Notepage> {
  late TextEditingController _controller = TextEditingController();
  String savedNote = '';
  String title = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text:
          widget.selecedNote != null
              ? "${widget.selecedNote!.title}\n${widget.selecedNote!.notestring}"
              : "",
    );
  }

  void _saveNote() {
    List<String> lines = _controller.text.split('\n');
    title = lines.isNotEmpty ? lines[0] : "제목없음";
    savedNote = lines.length > 1 ? lines.sublist(1).join('\n') : "";
    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("노트가 저장 되었습니다")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            Flexible(
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.amber),
                onPressed: () {
                  Navigator.pop(context, null);
                },
              ),
            ),
            Text("폴더", style: TextStyle(color: Colors.amber)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.amber),
            onPressed: () {},
          ),
          SizedBox(width: 20),
          Icon(Icons.playlist_add_outlined, color: Colors.amber),
          SizedBox(width: 20),
          TextButton(
            child: Text("완료", style: TextStyle(color: Colors.amber)),
            onPressed: () {
              _saveNote();
              Navigator.pop(context, note(notestring: savedNote, title: title));
            },
          ),
        ],
      ),
      body: TextField(
        maxLines: null,
        controller: _controller,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
