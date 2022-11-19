import * as functions from "firebase-functions";

const stripe = require("stripe")(process.env.STRIPE_SK);

export const createPaymentIntent = functions
  .region(`asia-northeast1`)
  .https.onRequest(async (req, res) => {
    try {
      // 新しい customer を作成（既存の場合は id を渡せばOK）
      const customer = await stripe.customers.create();
      // Ephemeral Key (一時的なアクセス権を付与するキー)を作成
      // cf：https://stripe.com/docs/payments/accept-a-payment?platform=ios&ui=payment-sheet#add-server-endpoint
      const ephemeralKey = await stripe.ephemeralKeys.create(
        { customer: customer.id },
        { apiVersion: `2020-08-27` }
      );
      // PaymentIntent の作成
      const paymentIntent = await stripe.paymentIntents.create({
        amount: 1000,
        currency: `jpy`,
        customer: customer.id,
        automatic_payment_methods: {
          enabled: true,
        },
      });
      // アプリ側で必要な値を返却
      res.status(200).send({
        paymentIntent: paymentIntent.client_secret,
        ephemeralKey: ephemeralKey.secret,
        customer: customer.id,
        publishableKey: process.env.STRIPE_PK,
      });
    } catch (error) {
      console.error(`error: %j`, error);
      res.status(400).send({
        title: `エラーが発生しました`,
        message: error,
      });
    }
  });
