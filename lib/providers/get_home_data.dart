import 'package:http/http.dart' as http;

import '../models/home_model.dart';
import '../services/api_endpoint.dart';

class GetHomApiData {
  getHomeData() async {
    try {
      var response = await http.get(Uri.parse('$getMoviesapi'),
          headers: {"Accept": "application/json"});
      // jsonResponse = json.decode(response.body);
      // var message = jsonResponse["message"];
      // print(jsonResponse);
      if (response.statusCode == 200) {
        var data = homeModelFromJson(response.body.toString());
        return data;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        // err = 'Error';
        return Error;
      } else {
        // showSnackBar('error'.tr, 'server_error'.tr, warningColor);
        // return status;
      }
    } catch (err) {
      // showSnackBar('error'.tr, 'server_error'.tr, warningColor);
      return print(err.toString());
    }
  }
}
