import 'package:flutter_sample_redux/counter/model/counter_state.dart';
import 'package:flutter_sample_redux/counter/redux/store.dart';
import 'package:flutter_sample_redux/shopping_list/model/shopping_state.dart';
import 'package:flutter_sample_redux/shopping_list/redux/store.dart';
import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';

GetIt injection = GetIt.I;

Future setInjections() async {
  final storeShopping = await createShoppingReduxStore();
  final storeCounter = await createCounterReduxStore();

  injection.registerLazySingleton<Store<ShoppingState>>(() => storeShopping);
  injection.registerLazySingleton<Store<CounterState>>(() => storeCounter);
}
