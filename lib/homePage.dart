import 'package:flutter/material.dart';
import 'package:iphone_note/folderPage.dart';
import 'package:iphone_note/noteData.dart';
import 'package:iphone_note/notePage.dart';
import 'newfolder.dart';
import 'folderData.dart';
import 'folderPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  folder quicknote = folder(notes: [], title: "quickNote");
  List<folder> folderList = [];
  List<folder> filterfolders = [];

  final TextEditingController _searchcontroller = TextEditingController();
  bool issearching = false;
  bool isEditing = false;

  void _filteringSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        issearching = false;
        filterfolders = folderList;
      } else {
        issearching = true;
        filterfolders =
            folderList
                .where(
                  (folder) =>
                      folder.title.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(22, 233, 233, 233),
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
      body:
          issearching
              ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "  폴더",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 30,
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        Expanded(
                          child: TextField(
                            controller: _searchcontroller,
                            onChanged: _filteringSearchResults,
                            decoration: InputDecoration(
                              hintText: "검색",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Flexible(
                    child:
                        filterfolders.isNotEmpty
                            ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.white,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: filterfolders.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap:
                                              isEditing
                                                  ? null
                                                  : () async {
                                                    final folder
                                                    nowfolder = await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (
                                                              context,
                                                            ) => Folderpage(
                                                              folderName:
                                                                  folderList[index]
                                                                      .title,
                                                              notes:
                                                                  folderList[index]
                                                                      .notes,
                                                            ),
                                                      ),
                                                    );
                                                    setState(() {
                                                      folderList[index] =
                                                          nowfolder;
                                                    });
                                                  },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                            ),
                                            child: Row(
                                              children: [
                                                if (isEditing)
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        folderList.removeAt(
                                                          index,
                                                        );
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 10,
                                                      ),
                                                  child: Icon(
                                                    Icons.folder_copy_outlined,
                                                    color: Colors.amber,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  filterfolders[index].title,
                                                ),

                                                Spacer(),

                                                Text(
                                                  filterfolders[index]
                                                      .notes
                                                      .length
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 50,
                                          ),
                                          child: Divider(),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            )
                            : Text("생성된 폴더가 없습니다."),
                  ),
                ],
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "  폴더",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 30,
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        Expanded(
                          child: TextField(
                            controller: _searchcontroller,
                            onChanged: _filteringSearchResults,
                            decoration: InputDecoration(
                              hintText: "검색",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => Folderpage(
                                folderName: quicknote.title,
                                notes: quicknote.notes,
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
                      height: 40,
                      child: Row(
                        children: [
                          SizedBox(width: 12),
                          Icon(Icons.note_add, color: Colors.amber),
                          SizedBox(width: 12),
                          Text("빠른 메모"),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(quicknote.notes.length.toString()),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "   폴더",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Flexible(
                    child:
                        folderList.isNotEmpty
                            ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.white,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: folderList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            final folder nowfolder =
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) => Folderpage(
                                                          folderName:
                                                              folderList[index]
                                                                  .title,
                                                          notes:
                                                              folderList[index]
                                                                  .notes,
                                                        ),
                                                  ),
                                                );
                                            setState(() {
                                              folderList[index] = nowfolder;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                            ),
                                            child: Row(
                                              children: [
                                                if (isEditing)
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        folderList.removeAt(
                                                          index,
                                                        );
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 10,
                                                      ),
                                                  child: Icon(
                                                    Icons.folder_copy_outlined,
                                                    color: Colors.amber,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Text(folderList[index].title),

                                                Spacer(),
                                                Text(
                                                  folderList[index].notes.length
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 50,
                                          ),
                                          child: Divider(),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            )
                            : Text("생성된 폴더가 없습니다."),
                  ),
                ],
              ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(22, 233, 233, 233),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.folder_copy_outlined, color: Colors.amber),
              onPressed: () async {
                final folder = await showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return newFolder();
                  },
                );
                if (folder != null) {
                  setState(() {
                    folderList.add(folder);
                  });
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.note_add_outlined, color: Colors.amber),
              onPressed: () async {
                final note? enterdData = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Notepage()),
                );
                if (enterdData != null)
                  setState(() {
                    quicknote.notes.add(enterdData);
                  });
              },
            ),
          ],
        ),
      ),
    );
  }
}
