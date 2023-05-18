import 'package:hive_flutter/adapters.dart';
import 'package:sample_one/model/player_model.dart';

class GameServices {
  String boxName = "Game-services";
  List<PlayerModel> playerList = [];
  void addFunction(PlayerModel playerModel) async {
    final box = Hive.box<PlayerModel>("players");
    box.add(playerModel);
  }

  static Box<PlayerModel> getBox() {
    return Hive.box<PlayerModel>("players");
  }
}
