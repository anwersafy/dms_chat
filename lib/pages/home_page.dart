import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/utils/style_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/routers.dart';
import 'package:frontend/pages/drawer/navigation_drawer.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

///
/// Main Container
///
class HomePage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const HomePage(this.navigationShell, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String _selectedVersion = '3.5'; // Default selected version
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVersionChanged(String? newValue) {
    if (newValue != null) {
      _controller.reset();
      _selectedVersion = newValue;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: NavigationDrawerWidget(widget.navigationShell),
        appBar: AppBar(
            leadingWidth: 68,
            titleSpacing: 0,

            leading: IconButton(
              tooltip: 'Open Drawer Menu',
              padding: const EdgeInsets.all(8),
              onPressed: () => scaffoldKey.currentState!.openDrawer(),
              icon: const Icon(Icons.menu),
            ),
            centerTitle: false,
            title: Row(

              children: [
                MenuTitle(widget.navigationShell.currentIndex),
                const SizedBox(width: 250),

                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DropdownButton<String>(
                      //  style: TextStyle(fontSize: 24, color: Colors.grey[800]),
                        borderRadius: BorderRadius.circular(8),
                        menuMaxHeight: 150,
                     //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),


                        value: _selectedVersion,
                        onChanged: _onVersionChanged,
                        items: <String>['3.5', '4'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text('GPT $value'),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),

              ],
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: AnimatedTextKit(animatedTexts: [
                    WavyAnimatedText(t.home.appbar_action,
                        textStyle: style16)
                  ], repeatForever: true)),
            ]),
        body: widget.navigationShell);
  }
}

///Menu Name
class MenuTitle extends ConsumerWidget {
  const MenuTitle(this.currentIndex, {super.key});

  final int currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(menuNameList[currentIndex]);
  }
}
