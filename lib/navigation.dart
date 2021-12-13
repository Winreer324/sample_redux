import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sample_redux/shopping_list/model/shopping_state.dart';
import 'package:flutter_sample_redux/shopping_list/redux/actions.dart';
import 'package:flutter_sample_redux/shopping_list/widgets/shopping_cart_app.dart';

import 'counter/couter_screen.dart';
import 'counter/model/counter_state.dart';
import 'di/injection.dart';
import 'shopping_list/widgets/shopping_cart_app.dart';

class NavigationApp extends StatefulWidget {
  const NavigationApp({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<NavigationApp> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // late List<Widget> _widgetOptions;

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
        CounterScreen(counterState: injection()),
        const ShoppingCartApp(),
      ]);
      // _widgetOptions = <Widget>[
      //   ShoppingCartApp(widget.store),
      //   const Text(
      //     'counter',
      //     style: optionStyle,
      //   ),
      // ];
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<CounterState>(
      store: injection(),
      child: StoreProvider<ShoppingState>(
        store: injection(),
        child: MaterialApp(
          title: 'ShoppingList',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
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
