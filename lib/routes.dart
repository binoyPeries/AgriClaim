import 'package:agriclaim/ui/common/pages/welcome_page.dart';
import 'package:agriclaim/ui/farmer/login.dart';
import "package:go_router/go_router.dart";

abstract class AgriClaimRoutes {
  //  path names
  static const String farmerLogin = "/farmer/login";
  static const String officerLogin = "/officer/login";
  static const String welcome = "/";

  static List<GoRoute> get routes {
    return [
      ...farmerRoutes,
      ...officerRoutes,
      ...commonRoutes,
    ];
  }

  static List<GoRoute> get commonRoutes {
    return [
      GoRoute(path: welcome, builder: (_, __) => const WelcomePage()),
    ];
  }

  static List<GoRoute> get farmerRoutes {
    return [
      GoRoute(path: farmerLogin, builder: (_, __) => const FarmerLoginPage()),
    ];
  }

  static List<GoRoute> get officerRoutes {
    return [
      GoRoute(path: officerLogin, builder: (_, __) => const FarmerLoginPage()),
    ];
  }
}
