import 'package:flutter/material.dart';
import 'folderData.dart';

class newFolder extends StatefulWidget {
  const newFolder({super.key});

  @override
  State<newFolder> createState() => _newFolderState();
}

class _newFolderState extends State<newFolder> {
  final TextEditingController _controller = TextEditingController();
  final folder _folder = folder(notes: [], title: "title");
  void _saveText() {
    setState(() {
      _folder.title = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.98,
      decoration: BoxDecoration(
        color: Color.fromARGB(232, 242, 240, 240),
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 20, left: 5),
            child: TextButton(
              child: Text("취소", style: TextStyle(color: Colors.amber)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 65),
            child: Text(
              "새로운 폴더",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          actions: [
            TextButton(
              child: Text("완료", style: TextStyle(color: Colors.amber)),
              onPressed: () {
                _saveText();
                Navigator.pop(context, _folder);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
