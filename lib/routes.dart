import "package:go_router/go_router.dart";

abstract class AgriClaimRoutes {
  //  path names
  static const String welcome = "/";

  static List<GoRoute> get routes {
    return [
      ...commonRoutes,
      ...patientRoutes,
      ...doctorRoutes,
    ];
  }

  static List<GoRoute> get commonRoutes {
    return [];
  }

  static List<GoRoute> get patientRoutes {
    return [];
  }

  static List<GoRoute> get doctorRoutes {
    return [];
  }
}
