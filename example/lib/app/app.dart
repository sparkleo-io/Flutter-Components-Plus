import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'modules/theme/theme_config.dart';
import 'modules/theme/theme_controller.dart';
import 'routes/app_pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Components Plus',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<ThemeController>(() => ThemeController());
      }),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final viewPadding = MediaQuery.viewPaddingOf(context);

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: viewPadding.left,
              right: viewPadding.right,
              bottom: viewPadding.bottom,
            ),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
