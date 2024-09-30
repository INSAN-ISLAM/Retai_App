import 'package:googleapis_auth/auth_io.dart';

class AccessTokenFirebase {
  static String firebaseMessagingScope = 'https://www.googleapis.com/auth/firebase.messaging';

  Future<String> getAccessToken () async {
    final client = await clientViaServiceAccount(ServiceAccountCredentials.fromJson(
        {
          "type": "service_account",
          "project_id": "retailappstore",
          "private_key_id": "0fd82022a23a3eff9d921577cc5e5b1fbecfff97",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDtf4h1+9AqSgSc\nIXssZ5uvkhxaR4ImaudbdXMtx+Na6gahN7uoPKak5lv8opEPadaXoy4Sg0ot2yjq\nPayusx8uxGieo3fyoDksXcyksHlICm0N7l1UsYqtjSTLDfuaNnwsbVpQClP6taOf\nFUTuxqG+l16NWu6Q/EpFYn6/qUQuZiNESbQ06InfOoYfVcBWVTh7W4S8KJMsYFJJ\nVpQ5xlkFV9K6QB6E9BjqGuZUKKVWqzH8n4n6P9cDecnceN87xh4QAMo+GvNwf7Er\ngA+eRGG6e07VKmyJjw41ReMeWdyAL+bUUk9qHOKOucw8ddI7sRI+yaXABSJed72i\n5B5k6N6BAgMBAAECggEAdhQjvQEjGHtvek69JjEm+u4Kcao+36nj+BlXWAobE/7p\np+sFPlpVQgQT9PHAbGjjG8YyKFslHNJrL7bVLZB57u8Q0tqUTslxU4kZL0JcMkCY\nwsXhmjOhLrNPeTMtBhmTuCTwM35HDY2UWYoiGRMhpJgultoAZY5BwOh8+v6FmwkQ\npT4TglXDN6B6waOviW6ORp4hCcIjl62BUEVB2/XvgvEecqXq4Vpz7Osbx1c8Hlf+\nZQAwLbzhL15jH403I3MkZSJ5HefAQRkT/8q32PXB4f2aws3Onmpt8LhMKK8HvHfb\nyvJYPFb6B8JoyTnioTdC658nK10XWw7HhQ027GzQ9wKBgQD/ejWDo7zgyLotPepY\nRhWovSACZlSLb/gQ2nwJo6NMacGpzu3qZ8CEziHp8Q3ROF5E7Uy5I87TPzyAxSL7\nRNEsEXkTpVPq1XEcyhOFt+S19x5VX0yRYvhZGENu1Ced9srUAeJ6VQkt+yApS3L8\n6ZuWlwOJLKm4VXhwCWwhhhmvYwKBgQDt++iSMRCW9pj3mfaGPIEq5ITiyhU/CXwp\nJEnr3u1hTenw5wtO3jkij4+G+/sojNgKGjJSpLEwbBwcSeERMdI7RJf3hZqpVAaH\nlTzJyx0rOJX3Gqc+lnjhaI7f72T71UA5Lx8nbWaXTvDKebmM+puct6neSIkLXj7p\nIPzbcFd5ywKBgAQb1Qx+76S11biwjDpLNkH2eLNRLf7oGBc9TE1jYlbyRHkUqOLi\nNEhugEEg7VX2EB4PqvI3TzY6iCCSCxP7cVnCFi5otEbMk/sgjNvTr0v143kABV05\nOEFGkJ8Rrmlt9KkgNqI9B97DcSr42aqTnzr2xsnH/BrI1R0IKcMIQxV9AoGBAIK7\n2d1FetmTiiCqwZSodES92IpFfTpt2Xk4aCtdAYZsqNEf+0ROK5Di0HPUxPpXtO6H\nyZFAy93P5flcVHl/pv/MBLeC+519fUDKKOSp4dI2eZuPVsS5IJqjN6mo9w6o7Wj8\ni9666JrCUODJ0bayjP2gn35u1moaUfD7oCxkIInVAoGAAtBjn35I5JECRz9EZNzr\neexP1ZNiIzMX3i1oPerk7sHbW0MJ4xpILvbauDYr8EsDa0ufMN9Q1dYu9LllI4PT\nWeerS1bzBZB3yz4ohod4xeeq09zIN4LiJQXv7IF3sHZpiOVrMLyFg4lirwjRvtbN\nnsiuMDJDFxQgCvP6kG7HgUw=\n-----END PRIVATE KEY-----\n",
          "client_email": "firebase-adminsdk-7lj2c@retailappstore.iam.gserviceaccount.com",
          "client_id": "107603035206021863996",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-7lj2c%40retailappstore.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }
    ), [firebaseMessagingScope]);
    
    final accessToken = client.credentials.accessToken.data;
    
    print('Access token is $accessToken');


    return accessToken;
  }
}