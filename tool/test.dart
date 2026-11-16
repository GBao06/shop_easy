
import 'package:shop_easy/features/auth/data/auth_service.dart';

Future<void> main() async {
  final auth = AuthService();

  final result = await auth.login('emilys', 'emilyspass');
  print('User: ${result.user.fullName}'); // Emily Johnson

  final me = await auth.getCurrentUser(result.tokens.accessToken);
  print('Me: ${me.email}');

  final newTokens = await auth.refresh(result.tokens.refreshToken);
  print(
    'Token mới: ${newTokens.accessToken != result.tokens.accessToken}',
  );
}
