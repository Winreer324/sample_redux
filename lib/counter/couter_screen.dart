import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sample_redux/counter/redux/reducers.dart';
import 'package:redux/redux.dart';

import 'model/counter_state.dart';

class CounterScreen extends StatefulWidget {
  final Store<CounterState> counterState;

  const CounterScreen({Key? key, required this.counterState}) : super(key: key);

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    controller.addListener(() {
      setState(() {});
      // if (controller.isCompleted) {
      //   widget.counterState.dispatch(CounterAction.increment);
        // timer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
        //   widget.counterState.dispatch(CounterAction.increment);
        //   setState(() {});
        // });
        // setState(() {});
      // } else {
      //   timer?.cancel();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: StoreBuilder<CounterState>(
        builder: (context, store) => SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTapDown: (_) => controller.forward(),
                onTapUp: (_) {
                  if (controller.status == AnimationStatus.forward) {
                    controller.reverse();
                    timer?.cancel();
                    timer = null;
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    const CircularProgressIndicator(
                      value: 1.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                    CircularProgressIndicator(
                      value: controller.value,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    const Icon(Icons.add)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(store.state.count.toString()),
              ),
              ElevatedButton(
                onPressed: () {
                  store.dispatch(CounterAction.increment);
                  controller.forward();
                },
                child: const Text('Increment'),
              ),
              ElevatedButton(
                onPressed:() {
                  store.dispatch(CounterAction.decrement);
                  controller.reverse();
                },
                child: const Text('Decrement'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
