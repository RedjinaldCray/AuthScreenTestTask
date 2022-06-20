import 'package:authorization_app/consts/routes.dart';
import 'package:authorization_app/screens/authentication/authentication_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(const MyAuthenticationApp());
}

class MyAuthenticationApp extends StatelessWidget {
  const MyAuthenticationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, context) {
        return GetMaterialApp(
          initialRoute: authentication,
          getPages: [
            GetPage(
                name: authentication,
                page: () => const AuthenticationScreenProvider())
          ],
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
