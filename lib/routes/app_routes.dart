import 'package:anchor_getx/presentation/message_screen/binding/messageScreenBinding.dart';
import 'package:anchor_getx/presentation/message_screen/message_screen.dart';
import 'package:anchor_getx/presentation/splash_screen/splash_screen.dart';
import 'package:anchor_getx/presentation/splash_screen/binding/splash_binding.dart';
import 'package:anchor_getx/presentation/auth_screen/auth_screen.dart';
import 'package:anchor_getx/presentation/auth_screen/binding/auth_binding.dart';
import 'package:anchor_getx/presentation/log_in_screen/log_in_screen.dart';
import 'package:anchor_getx/presentation/log_in_screen/binding/log_in_binding.dart';
import 'package:anchor_getx/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:anchor_getx/presentation/forgot_password_screen/binding/forgot_password_binding.dart';
import 'package:anchor_getx/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:anchor_getx/presentation/sign_up_screen/binding/sign_up_binding.dart';
import 'package:anchor_getx/presentation/notification_screen/notification_screen.dart';
import 'package:anchor_getx/presentation/notification_screen/binding/notification_binding.dart';
import 'package:anchor_getx/presentation/invite_friends_screen/invite_friends_screen.dart';
import 'package:anchor_getx/presentation/invite_friends_screen/binding/invite_friends_binding.dart';
import 'package:anchor_getx/presentation/daily_new_tab_container_screen/daily_new_tab_container_screen.dart';
import 'package:anchor_getx/presentation/daily_new_tab_container_screen/binding/daily_new_tab_container_binding.dart';
import 'package:anchor_getx/presentation/trending_tab_container_screen/trending_tab_container_screen.dart';
import 'package:anchor_getx/presentation/trending_tab_container_screen/binding/trending_tab_container_binding.dart';
import 'package:anchor_getx/presentation/stories_container_screen/stories_container_screen.dart';
import 'package:anchor_getx/presentation/stories_container_screen/binding/stories_container_binding.dart';
import 'package:anchor_getx/presentation/trending_posts_tab_container_screen/trending_posts_tab_container_screen.dart';
import 'package:anchor_getx/presentation/trending_posts_tab_container_screen/binding/trending_posts_tab_container_binding.dart';
import 'package:anchor_getx/presentation/stories_and_tweets_screen/stories_and_tweets_screen.dart';
import 'package:anchor_getx/presentation/stories_and_tweets_screen/binding/stories_and_tweets_binding.dart';
import 'package:anchor_getx/presentation/search_screen/search_screen.dart';
import 'package:anchor_getx/presentation/search_screen/binding/search_binding.dart';
import 'package:anchor_getx/presentation/live_screen/live_screen.dart';
import 'package:anchor_getx/presentation/live_screen/binding/live_binding.dart';
import 'package:anchor_getx/presentation/for_you_screen/for_you_screen.dart';
import 'package:anchor_getx/presentation/for_you_screen/binding/for_you_binding.dart';
import 'package:anchor_getx/presentation/page_view_screen/page_view_screen.dart';
import 'package:anchor_getx/presentation/page_view_screen/binding/page_view_binding.dart';
import 'package:anchor_getx/presentation/comments_screen/comments_screen.dart';
import 'package:anchor_getx/presentation/comments_screen/binding/comments_binding.dart';
import 'package:anchor_getx/presentation/account_view_screen/account_view_screen.dart';
import 'package:anchor_getx/presentation/account_view_screen/binding/account_view_binding.dart';
import 'package:anchor_getx/presentation/account_details_screen/account_details_screen.dart';
import 'package:anchor_getx/presentation/account_details_screen/binding/account_details_binding.dart';
import 'package:anchor_getx/presentation/chat_screen/chat_screen.dart';
import 'package:anchor_getx/presentation/chat_screen/binding/chat_binding.dart';
import 'package:anchor_getx/presentation/friends_screen/friends_screen.dart';
import 'package:anchor_getx/presentation/friends_screen/binding/friends_binding.dart';
import 'package:anchor_getx/presentation/detailed_profile_screen/detailed_profile_screen.dart';
import 'package:anchor_getx/presentation/detailed_profile_screen/binding/detailed_profile_binding.dart';
import 'package:anchor_getx/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:anchor_getx/presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import 'package:anchor_getx/routes/route_guard.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../core/authentication_manager.dart';

class AppRoutes {

  static const String splashScreen = '/splash_screen';

  static const String authScreen = '/auth_screen';

  static const String logInScreen = '/log_in_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String signUpScreen = '/sign_up_screen';

  static const String notificationScreen = '/notification_screen';

  static const String inviteFriendsScreen = '/invite_friends_screen';

  static const String discoverPage = '/discover_page';

  static const String dailyNewPage = '/daily_new_page';

  static const String dailyNewTabContainerScreen =
      '/daily_new_tab_container_screen';

  static const String trendingPage = '/trending_page';

  static const String trendingTabContainerScreen =
      '/trending_tab_container_screen';

  static const String storiesPage = '/stories_page';

  static const String storiesContainerScreen = '/stories_container_screen';

  static const String trendingPostsPage = '/trending_posts_page';

  static const String trendingPostsTabContainerScreen =
      '/trending_posts_tab_container_screen';

  static const String storiesAndTweetsScreen = '/stories_and_tweets_screen';

  static const String searchScreen = '/search_screen';

  static const String liveScreen = '/live_screen';

  static const String forYouScreen = '/for_you_screen';

  static const String pageViewScreen = '/page_view_screen';

  static const String commentsScreen = '/comments_screen';

  static const String accountViewScreen = '/account_view_screen';

  static const String accountDetailsScreen = '/account_details_screen';

  static const String messagesPage = '/messages_page';
  static const String messageScreen = '/message_screen';
  static const String chatScreen = '/chat_screen';

  static const String friendsScreen = '/friends_screen';

  static const String notificationsPage = '/notifications_page';

  static const String profilePage = '/profile_page';

  static const String detailedProfileScreen = '/detailed_profile_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(key: Key('SplashScreen')),
      bindings: [
        SplashBinding(),
      ],

    ),
    GetPage(
      name: authScreen,
      page: () => AuthScreen(key: Key('AuthScreen')),
      bindings: [
        AuthBinding(),
      ],
    ),
    GetPage(
      name: logInScreen,
      page: () => LogInScreen(key: Key('LogInScreen')),
      bindings: [
        LogInBinding(),
      ],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
      bindings: [
        ForgotPasswordBinding(),
      ],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: signUpScreen,
      page: () => SignUpScreen(),
      bindings: [
        SignUpBinding(),
      ],
        transition: Transition.cupertino,


    ),
    GetPage(
      name: notificationScreen,
      page: () => NotificationScreen(),
      bindings: [
        NotificationBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: inviteFriendsScreen,
      page: () => InviteFriendsScreen(),
      bindings: [
        InviteFriendsBinding(),
      ],
      middlewares: [RouteGuard()],

    ),
    GetPage(
      name: dailyNewTabContainerScreen,
      page: () => DailyNewTabContainerScreen(),
      bindings: [
        DailyNewTabContainerBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: trendingTabContainerScreen,
      page: () => TrendingTabContainerScreen(),
      bindings: [
        TrendingTabContainerBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: storiesContainerScreen,
      page: () => StoriesContainerScreen(),
      bindings: [
        StoriesContainerBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: trendingPostsTabContainerScreen,
      page: () => TrendingPostsTabContainerScreen(),
      bindings: [
        TrendingPostsTabContainerBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: storiesAndTweetsScreen,
      page: () => StoriesAndTweetsScreen(),
      bindings: [
        StoriesAndTweetsBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: searchScreen,
      page: () => SearchScreen(),
      bindings: [
        SearchBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: liveScreen,
      page: () => LiveScreen(),
      bindings: [
        LiveBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: forYouScreen,
      page: () => ForYouScreen(),
      bindings: [
        ForYouBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: pageViewScreen,
      page: () => PageViewScreen(),
      bindings: [
        PageViewBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: commentsScreen,
      page: () => CommentsScreen(),
      bindings: [
        CommentsBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: accountViewScreen,
      page: () => AccountViewScreen(),
      bindings: [
        AccountViewBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: accountDetailsScreen,
      page: () => AccountDetailsScreen(),
      bindings: [
        AccountDetailsBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: messageScreen,
      page: () => MessageScreen(),
      bindings: [
        MessageScreenBinding(),
      ],
      // middlewares: [RouteGuard()],
    ),
    GetPage(
      name: chatScreen,
      page: () => ChatScreen(),
      bindings: [
        ChatBinding(),
      ],
     // middlewares: [RouteGuard()],
    ),
    GetPage(
      name: friendsScreen,
      page: () => FriendsScreen(),
      bindings: [
        FriendsBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: detailedProfileScreen,
      page: () => DetailedProfileScreen(),
      bindings: [
        DetailedProfileBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [
        AppNavigationBinding(),
      ],
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: initialRoute,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],

    )
  ];
}
