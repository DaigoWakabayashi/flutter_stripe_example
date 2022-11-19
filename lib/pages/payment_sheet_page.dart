import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentSheetPage extends StatelessWidget {
  const PaymentSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(runtimeType.toString())),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  // 1. Cloud Functions 上で PaymentIntent を作成
                  final callable = FirebaseFunctions.instance
                      .httpsCallable('createPaymentIntent');
                  final result = await callable.call();
                  final data = result.data;
                  log(result.data.toString());

                  // 2. PaymentSheet を初期化
                  await Stripe.instance.initPaymentSheet(
                    paymentSheetParameters: SetupPaymentSheetParameters(
                      customFlow: true,
                      merchantDisplayName: 'Flutter Stripe Example',
                      paymentIntentClientSecret: data['paymentIntent'],
                      customerEphemeralKeySecret: data['ephemeralKey'],
                      customerId: data['customer'],
                    ),
                  );

                  // 3. PaymentSheet を表示
                  await Stripe.instance.presentPaymentSheet();

                  // 4. 決済を確定
                  await Stripe.instance.confirmPaymentSheetPayment();
                } on StripeException catch (e) {
                  final error = e.error;
                  switch (error.code) {
                    case FailureCode.Canceled:
                      log('キャンセルされました', error: e);
                      break;
                    case FailureCode.Failed:
                      log('エラーが発生しました', error: e);
                      break;
                  }
                } on FirebaseFunctionsException catch (e) {
                  log('エラーが発生しました', error: e);
                } catch (e) {
                  log('不明なエラーが発生しました', error: e);
                }
              },
              child: const Text('Call PaymentIntent API'),
            )
          ],
        ),
      ),
    );
  }
}
