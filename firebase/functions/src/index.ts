import * as functions from "firebase-functions";

const stripe = require("stripe")(process.env.STRIPE_SK_TEST);

export const createPaymentIntent = functions
  .region("asia-northeast1")
  .https.onRequest(async (req, res) => {
    // customer（Stripe上のユーザーアカウント）の作成
    const customer = await stripe.customers.create();
    // 一時的なキーを作成
    const ephemeralKey = await stripe.ephemeralKeys.create(
      { customer: customer.id },
      { apiVersion: "2022-08-01" }
    );
    // 決済フォームを作成
    const paymentIntent = await stripe.paymentIntents.create({
      amount: 1000,
      currency: "jpy",
      customer: customer.id,
      automatic_payment_methods: {
        enabled: true,
      },
    });
    // 返却
    res.json({
      paymentIntent: paymentIntent.client_secret,
      ephemeralKey: ephemeralKey.secret,
      customer: customer.id,
      publishableKey: process.env.STRIPE_PK_TEST,
    });
  });
