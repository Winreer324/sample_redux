import 'package:flutter_sample_redux/counter/model/counter_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

import 'reducers.dart';

Future<Store<CounterState>> createCounterReduxStore() async {
  return DevToolsStore<CounterState>(
    appCounterStateReducers,
    initialState: CounterState.empty(),
  );
}
