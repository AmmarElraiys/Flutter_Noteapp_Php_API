import 'package:flutter/material.dart';
import 'package:notes_app_php/constant/links.dart';
import 'package:notes_app_php/customs/home/card_sustoms.dart';
import 'package:notes_app_php/customs/home/floatingactionbutton_widget.dart';
import 'package:notes_app_php/main.dart';
import 'package:notes_app_php/model/notemodel.dart';
import 'package:notes_app_php/screens/home/edit_notes_screen.dart';
import 'package:notes_app_php/screens/home/notes_screen.dart';
import 'package:notes_app_php/utils/home/drawer_home.dart';
import 'package:notes_app_php/widgets/data/crud.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final Crud _crud = Crud();

class _HomeScreenState extends State<HomeScreen> {
  getNotes() async {
    var response = await _crud.postRequest(linkNotesView, {
      "id": sharedPreferences!.getString("id"),
    });

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerHome(),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () {
          Navigator.of(context).pushNamed("/addnotes");
        },
        icon: Icons.add,
      ),
      appBar: AppBar(
        title: Text("Home Screen"),

        actions: [
          IconButton(
            onPressed: () {
              sharedPreferences!.clear();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil("/", (route) => false);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == "fail") {
                    return Center(child: Text("No Notes Available"));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CardCustom(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => NotesScreen(
                                    notes: snapshot.data['data'][index],
                                  ),
                            ),
                          );
                        },
                        noteModel: NoteModel.fromJson(
                          snapshot.data['data'][index],
                        ),

                        onPressedDelete: () async {
                          var response = await _crud
                              .postRequest(linkNotesDelete, {
                                "id": snapshot.data['data'][index]['notes_id'],
                                "imagename":
                                    snapshot.data['data'][index]['notes_image'],
                              });
                          if (response["status"] == "success") {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              "/home",
                              (route) => false,
                            );
                          }
                        },
                        onPressedEdit: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => EditNotesScreen(
                                    notes: snapshot.data['data'][index],
                                  ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("Loading ...."));
                }
                return Center(child: Text("Loading ....?"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
