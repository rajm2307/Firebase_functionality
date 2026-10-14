import 'package:go_router/go_router.dart';
import 'package:demo_project/auth/controller/binding.dart';
import 'package:demo_project/auth/view/index.dart';
import 'package:demo_project/cart/controller/binding.dart';
import 'package:demo_project/cart/view/index.dart';
import 'package:demo_project/homepage/controller/binding.dart';
import 'package:demo_project/homepage/view/index.dart';
import 'package:demo_project/product-details/controller/binding.dart';
import 'package:demo_project/product-details/view/index.dart';
import 'package:demo_project/register/controller/binding.dart';
import 'package:demo_project/register/view/index.dart';
import 'package:demo_project/splashScreen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splashscreen',
  routes: [
    GoRoute(
      path: '/splashscreen',
      name: SplashScreen.name,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/signup',
      name: Signuppage.name,
      builder: (context, state) {
        SignupBinding().dependencies();
        return const Signuppage();
      },
    ),
    GoRoute(
      path: '/login',
      name: Loginpage.name,
      builder: (context, state) {
        LoginBinding().dependencies();
        return const Loginpage();
      },
    ),
    GoRoute(
      path: '/homepage',
      name: Homepage.name,
      builder: (context, state) {
        HomepageBinding().dependencies();
        return const Homepage();
      },
    ),
    GoRoute(
      path: '/product-details',
      name: ProductDetails.name,
      builder: (context, state) {
        ProductDetailsBinding().dependencies();
        final extraMap = state.extra as Map<String, dynamic>;
        final id = extraMap['productId'] as int;

        return ProductDetails(productId: id);
      },
    ),
    GoRoute(
      path: '/cartpage',
      name: Cartpage.name,
      builder: (context, state) {
        CartPageBinding().dependencies();
        return const Cartpage();
      },
    ),
  ],
);

final GoRouter getRoute = router;