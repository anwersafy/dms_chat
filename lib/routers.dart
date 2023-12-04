import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/chat/chat_page.dart';

import 'package:frontend/gen/strings.g.dart';


final menuNameList = [
  t.chat.menuName,

];
final menuRouterList = ['/chat','/details'];

const menuPageList = <Widget>[
  ChatPage(),



];

final _navigatorKey = GlobalKey<NavigatorState>();



final globalRouter = GoRouter(
    observers: [RouterObserver()],
    initialLocation: '/chat',
    debugLogDiagnostics: true,
    navigatorKey: _navigatorKey,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
          builder: (context, state, statefulChild) {
            return HomePage(statefulChild);
          },
          branches: createStatefulShellBranch())
    ]);


List<StatefulShellBranch> createStatefulShellBranch() {
  final branchList = <StatefulShellBranch>[];
  for (var i = 0; i < menuNameList.length; i++) {
    var branch = StatefulShellBranch(routes: <RouteBase>[
      GoRoute(
          path: menuRouterList[i],
          name: menuNameList[i],
          builder: (context, state) => menuPageList[i])
    ]);
    branchList.add(branch);
  }
  return branchList;
}


class RouterObserver extends NavigatorObserver {
  @override
  void didStopUserGesture() {
    debugPrint('| [GoRouter] didStopUserGesture');
  }

  @override
  void didStartUserGesture(
      Route<dynamic>? route, Route<dynamic>? previousRoute) {
    debugPrint(
        '| [GoRouter] didStartUserGesture : ${route.toString()} , previousRoute : ${previousRoute.toString()}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint(
        '| [GoRouter] didReplace : newRoute = ${newRoute.toString()} , oldRoute = ${oldRoute.toString()}');
  }

  @override
  void didRemove(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    debugPrint(
        '| [GoRouter] didRemove : route = ${route.toString()} , previousRoute = ${previousRoute.toString()}');
  }

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    debugPrint(
        '| [GoRouter] didPop : route = ${route.toString()} , previousRoute = ${previousRoute.toString()}');
  }

  @override
  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    debugPrint(
        '| [GoRouter] didPush : route = ${route.toString()} , previousRoute = ${previousRoute.toString()}');
  }
}
