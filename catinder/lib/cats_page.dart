import 'package:swipable_stack/swipable_stack.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class CardStackPage extends StatefulWidget {
  final List images;
  CardStackPage(this.images);

  @override
  State<CardStackPage> createState() => _CardStackPageState();
}

class _CardStackPageState extends State<CardStackPage> {
  SwipableStackController controller = SwipableStackController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 600,
            padding: EdgeInsets.all(20),
            child: SwipableStack(
              controller: controller,
              itemCount: widget.images.length,
              stackClipBehaviour: Clip.none,
              builder: (context, props) {
                var image = widget.images[props.index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    image["url"],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              },
              onSwipeCompleted: (index, direction) {
                if (direction == SwipeDirection.right) {
                  MyHomePage.of(context)?.favorite(index);
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.close),
                  onPressed: () {
                    controller.next(swipeDirection: SwipeDirection.left);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  color: Colors.green,
                  icon: Icon(Icons.check),
                  onPressed: () {
                    controller.next(swipeDirection: SwipeDirection.right);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}