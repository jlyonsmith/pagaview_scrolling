import 'package:flutter/material.dart';
import 'package:pageview_scrolling/notifying_pageview.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageView Scrolling',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  ValueNotifier<double> _notifier;


  @override
  void dispose() {
    _notifier?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _notifier = ValueNotifier<double>(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drag and rotate!"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:48.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: NotifyingPageView(
                notifier: _notifier,
              ),
            ),
            Expanded(
              flex: 8,
              child: Center(
                child: AnimatedBuilder(
                  animation: _notifier,
                  builder: (context, _) {
                    return Transform.rotate(
                      angle: 2 * pi * _notifier.value,
                      child: Container(
                        color: Colors.blue,
                        width: 200,
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                            ),
                            Text(
                              "TOP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
