import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_stripe_example/config/app_color.dart';
import 'package:flutter_stripe_example/pages/card_field_page.dart';
import 'package:flutter_stripe_example/pages/card_form_page.dart';
import 'package:flutter_stripe_example/pages/payment_sheet_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ダッシュボードの公開可能キー
  Stripe.publishableKey =
      'pk_test_51M0db1Ek1lV8YCpRscOysEpa1E0x9ftsWvgZt8nBdoQ9GTeUyVU4c3GBgLFlA2Qaxigb9k5bcVnNSOVsVrehtN7V007XFCU35D';

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
