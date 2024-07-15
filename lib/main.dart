import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:route_task/route_task/presentation/pages/product_screen.dart';

void main() {
  runApp(const RoutTask());
}

class RoutTask extends StatelessWidget {
  const RoutTask({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        // ignore: prefer_const_constructors
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rout Task',
          locale: const Locale('en'),
          home: ProductScreen(),
        );
      },
    );
  }
}
