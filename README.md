## Cash On Rails Inline Checkout

Learn how to integrate Cash On Rails' Inline Checkout for a seamless payment experience.

### How It Works

Cash On Rails' Inline Checkout can be triggered in two ways:

1. **Using `CashonrailsCheckout`** 
    Call this function directly with transaction details.
2. **Using `CashonRailsCheckoutWithAccessCode`** 
First, retrieve an access code via an API request, then invoke this function with the received access code.

---

### Integration Guide

#### 1. Load the Inline JavaScript SDK  
Include the Cash On Rails JavaScript SDK on your webpage.

```html copy
<script src="https://cashonrails-inlinejs.vercel.app/inline.js"></script>
```

#### Using `CashonrailsCheckout`
To initiate payment directly, call `CashonrailsCheckout` with the required parameters:

```javascript copy
<script>
  CashonrailsCheckout({
    api_key: 'sk_test_0a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p',
    amount: Number(document.querySelector('#amount').value),
    currency: 'NGN',
    reference: 'COR_' + Date.now(),
    customer: {
      email: document.querySelector('#email_address').value,
      first_name: document.querySelector('#first_name').value,
      last_name: document.querySelector('#last_name').value,
      phone: document.querySelector('#phone_number').value,
    },
    logo_url: "",
    callback_url: 'https://google.com', // Redirect after payment (optional)
    onComplete: function (response) {
      console.log('status', response.status, 'reference', response.reference);
    },
    onCancel: function (response) {
      console.log('status', response.status, 'reference', response.reference);
    },
    debug: true
  });
</script>
```

#### Full Integration Example using `CashonrailsCheckout`
Here's a complete example of how to integrate Cash On Rails' Inline Checkout using `CashonrailsCheckout` function:

```html copy
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cash On Rails Checkout</title>
    <script src="https://cashonrails-inlinejs.vercel.app/inline.js"></script>
</head>
<body>
    <h2>Make a Payment</h2>
    <input type="text" id="email_address" placeholder="Email Address">
    <input type="text" id="first_name" placeholder="First Name">
    <input type="text" id="last_name" placeholder="Last Name">
    <input type="text" id="phone_number" placeholder="Phone Number">
    <input type="number" id="amount" placeholder="Amount">
    <button onclick="payWithCashOnRails()">Pay Now</button>

    <script>
      function payWithCashOnRails() {
        CashonrailsCheckout({
          api_key: 'sk_test_a0b1c2d3e4f5g6h7i8j9k0',
          amount: Number(document.querySelector('#amount').value),
          currency: 'NGN',
          reference: 'COR_' + Date.now(),
          customer: {
            email: document.querySelector('#email_address').value,
            first_name: document.querySelector('#first_name').value,
            last_name: document.querySelector('#last_name').value,
            phone: document.querySelector('#phone_number').value,
          },
          logo_url: "",
          callback_url: 'https://google.com',
          onComplete: function (response) {
            console.log('status', response.status, 'reference', response.reference);
          },
          onCancel: function (response) {
            console.log('status', response.status, 'reference', response.reference);
          },
          debug: true
        });
      }
    </script>
</body>
</html>
```


#### Using `CashonRailsCheckoutWithAccessCode`
This method requires an access code, which must be retrieved before initiating payment.

#### Step 1: Get an Access Code
Make a POST request to the Cash On Rails API:

```sh copy
curl --location 'https://mainapi.cashonrails.com/api/v1/transaction/initialize' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer sk_test_a0b1c2d3e4f5g6h7i8j9k0' \
--data '{
    "first_name":"John",
    "last_name":"Doe",
    "email":"johndoe@gmail.com",
    "amount":"100",
    "currency":"NGN",
    "reference":"COR_202501241711532",
    "redirectUrl":"https://yourwebsite.com", 
    "title":"Payment for Order", 
    "description":"Order #12345", 
    "logoUrl":"https://yourwebsite.com/logo.png" 
}'
```

#### Step 2: Use the Access Code
Once you receive a response containing the `access_code`, use it to trigger the payment modal:

```html copy
<script>
  CashonRailsCheckoutWithAccessCode({
    access_code: document.querySelector('#access_code').value,
    callback_url: 'https://google.com', // Redirect after payment (optional)
    onComplete: function (response) {
      console.log('status', response.status, 'reference', response.reference);
    },
    onCancel: function (response) {
      console.log('status', response.status, 'reference', response.reference);
    },
    debug: true
  });
</script>
```



### Full Integration Example using `CashonRailsCheckoutWithAccessCode`
Here's a complete example of how to integrate Cash On Rails' Inline Checkout using `CashonRailsCheckoutWithAccessCode` function:

```html copy
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cash On Rails Checkout</title>
    <script src="https://cashonrails-inlinejs.vercel.app/inline.js"></script>
</head>
<body>
    <h2>Make a Payment</h2>
    <button onclick="payWithCashOnRails()">Pay Now</button>

    <script>
      function payWithCashOnRails() {
        CashonRailsCheckoutWithAccessCode({
          access_code: 'xdzejwy9iquqd355qqetwpyuk48le33j',
          callback_url: 'https://google.com',
          onComplete: function (response) {
            console.log('status', response.status, 'reference', response.reference);
          },
          onCancel: function (response) {
            console.log('status', response.status, 'reference', response.reference);
          },
          debug: true
        });
      }
    </script>
</body>
</html>
```
