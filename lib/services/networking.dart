import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      return response;
    } else {
      print(response.statusCode);
    }
  }
}

// print(data);
// var longitude = jsonDecode(data)['lon'];
// print(longitude);
// var weatherDescription =
// jsonDecode(data)['current']['weather'][0]['description'];
// var condition = jsonDecode(data)['current']['weather'][0]['id'];
//
// print(condition);
// var temperature = jsonDecode(data)['hourly'][0]['temp'];
// print(temperature);
