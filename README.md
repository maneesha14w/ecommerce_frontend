
# Rainforest

An e-commerce application built using Flutter and Bloc for state management. The app enables users to browse products, add them to a cart, and complete a checkout process. This project serves as a learning exercise to explore the BloC pattern and library.


## Demo

https://www.youtube.com/watch?v=YiJzrIoPI6E


## Features


- Product Browsing: Users can view a list of available products with their details (image, title, and price).

- Cart Management: Add or remove products from the cart with a separate CartCubit to manage the cart's state.

- Checkout Process: Complete the checkout by entering shipping information and placing the order.

- Order Summary: View a summary of items in the cart and the total price before placing the order.

- Error Handling: Graceful handling of errors during the checkout process with proper messages.
## Architecture

This app uses the BLoC architecture and the BLoC state management library using mainly cubits.
## Mock Backend

The backend consumed is the [fakeStoreApi](https://fakestoreapi.com/) by [keikaavousi](https://github.com/keikaavousi)
## Versions 

Flutter 3.27.3 • channel stable • https://github.com/flutter/flutter.git

Framework • revision c519ee916e (3 days ago) • 2025-01-21 10:32:23 -0800

Engine • revision e672b006cb

Tools • Dart 3.6.1 • DevTools 2.40.2



## Installation


```bash
git clone git@github.com:maneesha14w/ecommerce_frontend.git
cd ecommerce-app
flutter pub get
flutter run
```
    
## Feedback

If you have any feedback, please reach out to me at maneesha14w@gmail.com


## Future Improvements

- Use BLoCs to handle state for more fine control as app grows.

- Use theme to handle styling.

- Write tests for the logic layer.
