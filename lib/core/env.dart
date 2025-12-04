import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env{
  static final baseUrl = dotenv.env['BASE_URL']??'';
}