import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // String data = response.body;
      return response;
    } else {
      // print(response.statusCode);
    }
  }
}
