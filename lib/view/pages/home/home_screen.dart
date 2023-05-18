import 'package:flutter/material.dart';
import 'package:sample_one/controller/game_services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_one/model/player_model.dart';
import 'package:sample_one/view/pages/games/game.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<Box<PlayerModel>>(
              valueListenable: GameServices.getBox().listenable(),
              builder: (context, value, child) {
                final players = value.values.toList().cast<PlayerModel>();
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          trailing: IconButton(
                            onPressed: () {
                              players[index].delete();
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                          ),
                          tileColor: Colors.amber,
                          title: Text(players[index].playerName),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                    itemCount: players.length);
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: textEditingController,
                          decoration: const InputDecoration(
                            hintText: "Add Player Name",
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                        ),
                      ),
                      IconButton(
                          alignment: Alignment.center,
                          onPressed: () {
                            if (textEditingController.text.isNotEmpty) {
                              GameServices services = GameServices();
                              services.addFunction(PlayerModel(
                                  playerName: textEditingController.text));
                            }
                          },
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    final box =
                        Hive.box<PlayerModel>('players').values.toList();
                    if (box.length < 2) {
                      showAlertDialog(context);
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.orange),
                    minimumSize: MaterialStateProperty.all(const Size(130, 40)),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    "LET'S PLAY",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Alert"),
    content: const Text("minimum two players required"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
