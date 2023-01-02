import 'package:agriclaim/models/claim.dart';
import 'package:agriclaim/models/farm.dart';
import 'package:agriclaim/ui/common/components/claim_photo_full_screen_viewer.dart';
import 'package:agriclaim/ui/common/pages/login_check.dart';
import 'package:agriclaim/ui/farmer/claim_view_page.dart';
import 'package:agriclaim/ui/farmer/farm_navigation_page.dart';
import 'package:agriclaim/ui/farmer/profile_page.dart';
import 'package:agriclaim/ui/farmer/register_farm.dart';
import 'package:agriclaim/ui/common/pages/login_page.dart';
import 'package:agriclaim/ui/common/pages/sign_up.dart';
import 'package:agriclaim/ui/common/pages/welcome_page.dart';
import 'package:agriclaim/ui/constants/enums.dart';
import 'package:agriclaim/ui/farmer/claims_list_page.dart';
import 'package:agriclaim/ui/farmer/create_claim_page.dart';
import 'package:agriclaim/ui/farmer/home_screen.dart';
import 'package:agriclaim/ui/farmer/signup_page.dart';
import 'package:agriclaim/ui/farmer/view_farm.dart';
import 'package:agriclaim/ui/farmer/view_farm_list.dart';
import 'package:agriclaim/ui/officer/assigned_claims.dart';
import 'package:agriclaim/ui/officer/claim_review_page.dart';
import 'package:agriclaim/ui/officer/home_screen.dart';
import 'package:agriclaim/ui/officer/search_page.dart';
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
  static const String farmerHome = "/home-farmer";
  static const String officerHome = "/home-farmer";
  static const String registerFarm = "/register-farm";
  //:TODO add a way to load specific page in the home nav bar
  static const String claimList = "/claims/:type";
  static const String createClaim = "/claim-create";
  static const String farmNavigation = "/farms";
  static const String viewFarmsList = "/view-farms";
  static const String viewSingleFarm = "/farm";
  static const String viewSingleClaim = "/claim";
  static const String reviewSingleClaim = "/review-claim";
  static const String viewSingleClaimImage = "/claim-photo";
  static const String viewFarm = "/view-farm";
  static const String search = "/search";
  static const String assignedClaims = "/assigned-claims";
  static const String officerProfilePage = "/officer-profile";

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

  static ClaimStates _getClaimType(GoRouterState state) {
    String type = state.params["type"] as String;
    return ClaimStates.values.firstWhere((e) => describeEnum(e) == type);
  }

  static List<GoRoute> get commonRoutes {
    return [
      GoRoute(path: loginCheck, builder: (_, __) => const LoginCheck()),
      GoRoute(path: welcome, builder: (_, __) => const WelcomePage()),
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
      GoRoute(path: farmerHome, builder: (_, __) => const FarmerHomePage()),
      GoRoute(
          path: farmNavigation, builder: (_, __) => const FarmNavigationPage()),
      GoRoute(
          path: viewFarmsList, builder: (_, __) => const ViewFarmListPage()),
      GoRoute(
        path: viewSingleFarm,
        builder: (_, state) {
          Farm farm = state.extra as Farm; // -> casting is important
          return ViewFarmPage(farm);
        },
      ),
      GoRoute(
        path: claimList,
        builder: (_, state) => ClaimsListPage(claimType: _getClaimType(state)),
      ),
      GoRoute(path: createClaim, builder: (_, __) => CreateClaimPage()),
      GoRoute(
        path: viewSingleClaim,
        builder: (_, state) {
          Claim claim = state.extra as Claim; // -> casting is important
          return ClaimViewPage(claim: claim);
        },
      ),
      GoRoute(
        path: viewSingleClaimImage,
        builder: (_, state) {
          String imageUrl = state.extra as String; // -> casting is important
          return ClaimPhotoFullScreenViewer(image: imageUrl);
        },
      ),
    ];
  }

  static List<GoRoute> get officerRoutes {
    return [
      GoRoute(
          path: officerSignUp, builder: (_, __) => const OfficerSignUpPage()),
      GoRoute(path: officerHome, builder: (_, __) => const OfficerHomePage()),
      GoRoute(path: search, builder: (_, __) => const SearchPage()),
      GoRoute(
          path: assignedClaims, builder: (_, __) => const AssignedClaimsPage()),
      GoRoute(
          path: officerProfilePage, builder: (_, __) => const ProfilePage()),
      GoRoute(
        path: reviewSingleClaim,
        builder: (_, state) {
          Claim claim = state.extra as Claim; // -> casting is important
          return ClaimReviewPage(claim: claim);
        },
      ),
    ];
  }

  static String userLoginPath(UserRoles role) {
    return login.replaceFirst(":role", role.name.toString());
  }

  static String userSignUpPath(UserRoles role) {
    return commonSignUp.replaceFirst(":role", role.name.toString());
  }

  static String claimPath(ClaimStates type) {
    return claimList.replaceFirst(":type", type.name.toString());
  }
}
