import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/recovery_page.dart';
import '../../features/home/presentation/pages/brand_products_page.dart';
import '../../features/home/presentation/pages/random_products_Page.dart';
import '../../features/product_details/data/models/product_model.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_screen.dart';
import '../../features/product_details/presentation/pages/product_details_page.dart';
import 'route_names.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case RouteNames.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RouteNames.signup:
        return MaterialPageRoute(builder: (_) => SignupPage());
      case RouteNames.recovery:
        return MaterialPageRoute(builder: (_) => RecoveryPage());
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => HomePage());

      case RouteNames.brandProducts:
        final args = settings.arguments as Map<String, dynamic>;
        final brand = args['brand'] as String;
        final products = args['products'] as List<ProductModel>;
        return MaterialPageRoute(
          builder: (_) => BrandProductsPage(brand: brand, products: products),
        );

      case RouteNames.randomProducts: // This case was incorrectly placed
        final randomProductsArgs = settings.arguments as List<ProductModel>;
        return MaterialPageRoute(builder: (_) => RandomProductsPage(products: randomProductsArgs));

      case RouteNames.productDetails:
        final product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsPage(initialProduct: product),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
