# Zilla Checkout iOS SDK

Zilla connect is an easy, fast and secure way for your users to buy now and pay later from your app. It is a drop in framework that allows you host the Zilla checkout application within your iOS application and allow customers make payments using any of the available payment plans.

## Getting Started

<!-- Register on your Zilla Merchant  -->

1. Register on your [Zilla](https://merchant.usezilla.com/register) Merchant dashboard to get your public and secret keys.

## Installation

### Cocoapods 

Zilla Checkout iOS sdk is available through CocoaPods. To install it, simply add the following line to your Podfile:

```sh
pod 'CheckoutiOS'
```

## Requirements
- iOS 11.0 or higher

Then in your code, create a new instance of the Zilla connect
Import Checkout SDK

```swift
import CheckoutiOS
```

## Methods

There are two ways to make use of the Zilla Checkout Sdk

- [`completeExistingOrder()`](#completeExistingOrder)
  You can use this if have your own server and choose to create your order from your server [(see how)](https://www.notion.so/usezilla/Accepting-payments-5528b21e758244878d9b72acbdb8500c) to generate an `id`(`orderCode`) that you can pass as a parameter to your zilla connect instance.

- [`createNewOrder()`](#createNewOrder)
  You can use this if you want to create your order on the fly from your android application. Your order parameters are passed to the zilla checkout instance.

## Usage

### Completing an existing order

```swift

Zilla.shared.completeExistingOrder(withViewController: self,
                                   withPublicKey: "<public_key>",
                                   withOrderId: "<order_code>",
                                   onSuccess: { result in
    self.statusLabel.text = "Transaction status: \(result.status)"
    print(" onSuccess: \(result)")
}, onEvent: { eventName,data in })
```

### Creating a new order

```swift
let params = TransactionParamsBuilder()
    .title(title)
    .amount(10000)
    .clientOrderReference(<unique_ref>)
    .redirectUrl("<redirect_url>")
    .productCategory("Fashion")
    .build()

Zilla.shared.createNewOrder(withViewController: self,
                            withPublicKey: "<public_key>",
                            withTransactionParams: params,
                            onSuccess: { result in
    print(" onSuccess: \(result)")
},
                            onEvent: { eventName, data in
    print(" onEvent: \(eventName) data \(data)")
})
```


### Public key


Read more about the transaction parameters in this [doc](https://github.com/Zilla-tech/web-checkout-sdk/tree/f00a8fae126763473a61e719ed473e50a85437e7#parameters)

## Support

If you're having general difficulties with Zilla Connect or your Sdk integration, please reach out to us at <boost@zilla.africa> or come chat with us on Slack. We're more than happy to help you out with your integration to Zilla.

## License

`MIT`
