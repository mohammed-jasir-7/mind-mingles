import 'package:hive/hive.dart';
part 'player_model.g.dart';

@HiveType(typeId: 1)
class PlayerModel extends HiveObject {
  @HiveField(0)
  final String playerName;
  PlayerModel({required this.playerName});
}
