import "package:go_router/go_router.dart";

abstract class AgriClaimRoutes {
  //  path names
  static const String welcome = "/";

  static List<GoRoute> get routes {
    return [
      ...commonRoutes,
      ...farmerRoutes,
      ...officerRoutes,
    ];
  }

  static List<GoRoute> get commonRoutes {
    return [];
  }

  static List<GoRoute> get farmerRoutes {
    return [];
  }

  static List<GoRoute> get officerRoutes {
    return [];
  }
}
