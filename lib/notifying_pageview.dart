import 'package:flutter/material.dart';

class NotifyingPageView extends StatefulWidget {
  final ValueNotifier<double> notifier;

  const NotifyingPageView({Key? key, required this.notifier}) : super(key: key);

  @override
  _NotifyingPageViewState createState() => _NotifyingPageViewState();
}

class _NotifyingPageViewState extends State<NotifyingPageView> {
  int _previousPage = 0;
  late PageController _pageController;

  void _onScroll() {
    // Consider the page changed when the end of the scroll is reached
    // Using onPageChanged callback from PageView causes the page to change when
    // the half of the next card hits the center of the viewport, which is not
    // what I want

    if (_pageController.page != null) {
      final page = _pageController.page!.toInt();

      if (page == _pageController.page) {
        _previousPage = page;
      }

      widget.notifier.value = _pageController.page! - _previousPage;
    }
  }

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    )..addListener(_onScroll);

    _previousPage = _pageController.initialPage;
    super.initState();
  }

  final List<Widget> _pages = List.generate(
    3,
    (index) {
      return Card(
        child: Container(
          alignment: Alignment.center,
          color: Colors.lightBlue,
          child: Text(
            "Card number $index",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: _pages,
      controller: _pageController,
    );
  }
}
