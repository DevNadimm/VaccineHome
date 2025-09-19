import 'package:googleapis_auth/auth_io.dart';
import 'package:vaccine_home/core/constants/service_account_key.dart';

class AccessTokenGenerator {
  static Future<String> generateAccessToken() async {
    final scopes = [
      "https://www.googleapis.com/auth/firebase.messaging",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/userinfo.email",
    ];
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(serviceAccountKey),
      scopes,
    );
    final accessToken = client.credentials.accessToken.data;
    return accessToken;
  }
}
