import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:situ_talk/core/utils/theme/app_system_theme.dart';
import 'core/bindings/controller_binder.dart';
import 'core/utils/theme/theme.dart';

class SituTalk extends StatelessWidget {
  const SituTalk({super.key});

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // initialRoute: AppRoute.getAuthWrapper(),
          // getPages: AppRoute.routes,
          initialBinding: ControllerBinder(),
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          // builder: EasyLoading.init(),
          // Localization configuration
          // translations: LocalizationService(),
          // locale: LocalizationService.currentLocale, // Use saved locale
          // fallbackLocale: LocalizationService.fallbackLocale,
          builder: (context, child) {
            final overlayStyle = Theme.of(
              context,
            ).extension<AppSystemTheme>()!.systemOverlayStyle;

            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: overlayStyle,
              child: child!,
            );
          },
        );
      },
    );
  }
}