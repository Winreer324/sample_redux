import 'package:flutter_sample_redux/counter/model/counter_state.dart';

enum CounterAction { increment, decrement }

CounterState appCounterStateReducers(CounterState state, dynamic action)   {
  if (action == CounterAction.increment) {
    return _incrementState(state);
  }
  if (action == CounterAction.decrement) {
    return _decrementState(state);
  }

  return state;
}

CounterState _incrementState(CounterState state) {
  return CounterState((state.count + 1));
}

CounterState _decrementState(CounterState state) {
  return CounterState((state.count - 1));
}
