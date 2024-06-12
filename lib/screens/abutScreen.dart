import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housing/Colors/colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'معلومات عن تطبيق سكن',
            style: TextStyle(fontSize: 20, color: btnColor),
          ),
          backgroundColor: backgroundColor,
        ),
        backgroundColor: Colors.white,
        body: const SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage('assets/images/logo.png')),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'نبذة عن التطبيق:شرح موجز يوضح الهدف من التطبيق وأسباب تطويره.مثال: "تم تصميم تطبيق سكن لتسهيل عملية عرض وتأجير العقارات لأصحاب السكن. سواء كنت تملك شقة، فيلا، أو استوديو، فإن سكن يوفر لك الأدوات اللازمة للوصول إلى مستأجرين موثوقين بسرعة وسهولة."الخدمات الرئيسية:قائمة بالخدمات الرئيسية التي يقدمها التطبيق.مثال:إنشاء قوائم عقارات بسهولة وسرعة.تحميل صور ومقاطع فيديو عالية الجودة لعقاراتك.إدارة طلبات الاستئجار والتواصل مع المستأجرين.نظام تقييم ومراجعات للمستأجرين.تقارير وتحليلات عن أداء العقارات.',
                    textAlign: TextAlign.center,
                    style: textstyle1,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
