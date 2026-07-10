import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  final List<String> message;

  const LoadingWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingAnimationWidget.staggeredDotsWave(
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            ),
            const SizedBox(width: 16),
            _AnimatedLoadingText(
              messages: message,
              interval: const Duration(milliseconds: 800),
            )
            // Text(
            //   message,
            //   style: const TextStyle(
            //     decoration: TextDecoration.none,
            //     fontSize: 15,
            //     color: Colors.black,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedLoadingText extends StatefulWidget {
  final List<String> messages;
  final Duration interval;
  final TextStyle? style;

  const _AnimatedLoadingText({
    required this.messages, required this.interval, this.style
  });

  @override
  State<_AnimatedLoadingText> createState() => _AnimatedLoadingTextState();
}

class _AnimatedLoadingTextState extends State<_AnimatedLoadingText>
    with SingleTickerProviderStateMixin {

  int _index = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(widget.interval, (_) {
      if (!mounted) return;

      if (_index < widget.messages.length - 1) {
        setState(() => _index++);
      } else {
        if (_index == 3) {
          _timer.cancel(); // ⭐ para no último
        } else {
          _timer.cancel(); // ⭐ para no último
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0, 0.4),
          end: Offset.zero,
        ).animate(animation);

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: offsetAnimation,
            child: child,
          ),
        );
      },
      child: Text(
        widget.messages[_index],
        key: ValueKey(_index),
        style: const TextStyle(
          decoration: TextDecoration.none,
          fontSize: 15,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

