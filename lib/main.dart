import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_stripe_example/config/app_color.dart';
import 'package:flutter_stripe_example/pages/card_field_page.dart';
import 'package:flutter_stripe_example/pages/card_form_page.dart';
import 'package:flutter_stripe_example/pages/payment_sheet_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase の初期化
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ダッシュボードの公開可能キー
  Stripe.publishableKey = const String.fromEnvironment('STRIPE_PK_DEV');

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: AppColor.primary),
      home: const BasePage(),
    );
  }
}

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const PaymentSheetPage(),
                ),
              ),
              child: const Text('PaymentSheet'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const CardFieldPage(),
                ),
              ),
              child: const Text('CardField'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const CardFormPage(),
                ),
              ),
              child: const Text('CardForm'),
            )
          ],
        ),
      ),
    );
  }
}
