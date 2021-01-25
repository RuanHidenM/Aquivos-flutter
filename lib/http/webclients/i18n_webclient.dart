import 'dart:convert';
import 'package:bkinternacionalizacao/http/webclient.dart';
import 'package:http/http.dart';

const MESSAGES_URI = "https://gist.githubusercontent.com/RuanHidenM/fddc5fa97dcf2e5f468addb8bc6afee2/raw/0376bbacc8aabd64af079c1bf535e72a802f38f9/";
class I18NWebClient {
  final String _viewkey;

  I18NWebClient(this._viewkey);
  Future<Map<String, dynamic>> findAll() async {

    final Response response =
    await client.get("$MESSAGES_URI$_viewkey.json");
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson;
  }
}
