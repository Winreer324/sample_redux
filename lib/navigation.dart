import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sample_redux/shopping_list/model/shopping_state.dart';
import 'package:flutter_sample_redux/shopping_list/redux/actions.dart';
import 'package:flutter_sample_redux/shopping_list/widgets/shopping_cart_app.dart';

import 'counter/couter_screen.dart';
import 'counter/model/counter_state.dart';
import 'di/injection.dart';
import 'gallery/constants/api_constants.dart';
import 'gallery/gallery_screen.dart';
import 'gallery/redux/gallery_state.dart';
import 'shopping_list/widgets/shopping_cart_app.dart';

class NavigationApp extends StatefulWidget {
  const NavigationApp({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<NavigationApp> {
  final GlobalKey<NavigatorState> navigatorKey = ApiConstants.alice.getNavigatorKey()!;
  int _selectedIndex = 0;

  final StreamController<List<Widget>> _streamController = StreamController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      _streamController.add([
        const GalleryScreen(),
        CounterScreen(counterState: injection()),
        const ShoppingCartScreen(),
      ]);
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ApiConstants.alice.setNavigatorKey(navigatorKey);
    return StoreProvider<CounterState>(
      store: injection(),
      child: StoreProvider<ShoppingState>(
        store: injection(),
        child: MaterialApp(
          title: 'Flutter redux samples',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          navigatorKey: navigatorKey,
          home: StoreBuilder<ShoppingState>(
            onInit: (store) => store.dispatch(FetchItemsAction()),
            builder: (context, store) => Scaffold(
              body: Center(
                child: StreamBuilder<List<Widget>>(
                  stream: _streamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return snapshot.data!.elementAt(_selectedIndex);
                    }

                    return const SizedBox();
                  },
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.accessible_forward),
                    label: 'Gallery',
                    backgroundColor: Colors.blueGrey,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.business),
                    label: 'Counter',
                    backgroundColor: Colors.green,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Shopping',
                    backgroundColor: Colors.red,
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.amber[800],
                onTap: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
