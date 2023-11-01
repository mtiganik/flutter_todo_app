
import 'package:flutter_todo_app/api/api_config.dart';
import 'package:flutter_todo_app/services/user_service.dart';

Future<void> If401HandleRefreshToken(int statusCode) async {
  if(statusCode != 401) return;
  else{
    print("401 status occured");
    // var userData = await UserService.getUser();
    // String? refreshToken = userData!.refreshToken;
    // if(refreshToken != null){
    //   var url = "${APIConfig.getUrl()}Account/RefreshToken";
    //   final response = await http.post(
    //     url,
    //     body:{

    //     }
    //   )
    // }
  }
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String refreshToken = prefs.getString('refreshToken');

  // final response = await http.post(
  //   Uri.parse('${APIConfig.getUrl()}Account/RefreshToken'),
  //   headers: {'Authorization': 'Bearer $refreshToken'},
  // );

  // if (response.statusCode == 200) {
  //   // Parse the response for the new token and refreshToken
  //   String newToken = ...;
  //   String newRefreshToken = ...;

  //   // Update the tokens in shared preferences
  //   prefs.setString('token', newToken);
  //   prefs.setString('refreshToken', newRefreshToken);

  //   return newToken;
  // } else {
  //   // Token refresh failed; log the user out
  //   return null;
  }
// }
