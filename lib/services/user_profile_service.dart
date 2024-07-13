import 'package:fclp_app/models/user_model/user.dart';
import 'package:fclp_app/services/network_request.dart';
import 'package:fclp_app/utils/network_urls.dart';

class UserProfileService{
  static Future<Object> updateProfile(String token,String id, User userModel) async{
    print(token);
    return await NetworkRequest().putRequest(url: "${NetworkUrls.userUpdateUrl}/$id", headers: {"Authorization":"Bearer $token","content-type":"Application/json"}, body: userModel.toJsonUpdateProfile());
  }
}