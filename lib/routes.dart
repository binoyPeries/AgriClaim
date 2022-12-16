import 'package:agriclaim/ui/common/pages/home_screen.dart';
import 'package:agriclaim/ui/common/pages/login_check.dart';
import 'package:agriclaim/ui/farmer/register_farm.dart';
import 'package:agriclaim/ui/common/pages/login_page.dart';
import 'package:agriclaim/ui/common/pages/sign_up.dart';
import 'package:agriclaim/ui/common/pages/welcome_page.dart';
import 'package:agriclaim/ui/constants/enums.dart';
import 'package:agriclaim/ui/farmer/signup_page.dart';
import 'package:agriclaim/ui/officer/signup_page.dart';
import 'package:flutter/foundation.dart';
import "package:go_router/go_router.dart";

abstract class AgriClaimRoutes {
  //  path names
  static const String loginCheck = "/";
  static const String welcome = "/welcome";
  static const String login = "/login/:role";
  static const String commonSignUp = "/signup/:role";
  static const String farmerSignUp = "/signup-farmer";
  static const String officerSignUp = "/signup-officer";
  static const String registerFarm = "/register-farm";
  static const String home = "/home";

  static List<GoRoute> get routes {
    return [
      ...commonRoutes,
      ...farmerRoutes,
      ...officerRoutes,
    ];
  }

  static UserRoles _getUserRole(GoRouterState state) {
    String role = state.params["role"] as String;
    return UserRoles.values.firstWhere((e) => describeEnum(e) == role);
  }

  static List<GoRoute> get commonRoutes {
    return [
      GoRoute(path: loginCheck, builder: (_, __) => const LoginCheck()),
      GoRoute(path: welcome, builder: (_, __) => const WelcomePage()),
      GoRoute(path: home, builder: (_, __) => const HomeScreen()),
      GoRoute(
        path: login,
        builder: (_, state) => LoginPage(userType: _getUserRole(state)),
      ),
      GoRoute(
          path: commonSignUp,
          builder: (_, state) =>
              CommonSignUpPage(userType: _getUserRole(state))),
    ];
  }

  static List<GoRoute> get farmerRoutes {
    return [
      GoRoute(path: farmerSignUp, builder: (_, __) => const FarmerSignupPage()),
      GoRoute(path: registerFarm, builder: (_, __) => const RegisterFarmPage()),
    ];
  }

  static List<GoRoute> get officerRoutes {
    return [
      GoRoute(
          path: officerSignUp, builder: (_, __) => const OfficerSignUpPage()),
    ];
  }

  static String userLoginPath(UserRoles role) {
    return login.replaceFirst(":role", role.name.toString());
  }

  static String userSignUpPath(UserRoles role) {
    return commonSignUp.replaceFirst(":role", role.name.toString());
  }
}
