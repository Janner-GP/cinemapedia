import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroments {

  static String moviedDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay api key';

}