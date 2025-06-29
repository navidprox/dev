import 'package:flutter/foundation.dart';
import 'package:portfolio/utils/utils.dart';
import 'package:url_launcher/link.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'theme.dart';

/// For <a> hyperlinks in Web
class LinkWrap extends StatelessWidget {
  const LinkWrap({
    super.key,
    required this.url,
    required this.builder,
  });

  final String? url;
  final Widget Function(BuildContext context, Function? onClick) builder;

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Link(
            target: LinkTarget.blank,
            uri: url == null ? null : (Uri.tryParse(url!) ?? Uri.tryParse('about:blank')),
            builder: builder,
          )
        : builder(context, url == null ? null : (() => launchUrlString(url!, mode: LaunchMode.externalApplication)));
  }
}

/// To reuses a calculation in builds
class CalculatedBuilder<T> extends StatefulWidget {
  const CalculatedBuilder({
    required super.key,
    required this.calculate,
    required this.builder,
  });

  final T Function() calculate;
  final Widget Function(BuildContext context, T value) builder;

  @override
  State<CalculatedBuilder<T>> createState() => _CalculatedBuilderState<T>();
}

class _CalculatedBuilderState<T> extends State<CalculatedBuilder<T>> {
  late final T value = widget.calculate();

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value);
  }
}

/// To let fonts, images, etc. load
class DelayWidget extends StatefulWidget {
  const DelayWidget({super.key, required this.child, required this.duration});

  final Widget child;
  final Duration duration;

  @override
  State<DelayWidget> createState() => _DelayWidgetState();
}

class _DelayWidgetState extends State<DelayWidget> {
  final childKey = GlobalKey();
  bool delay = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.duration, () {
      delay = false;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final child = KeyedSubtree(
      key: childKey,
      child: widget.child,
    );

    return switch(delay) {
      false => child,
      true => Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: child,
          ),
          Positioned.fill(
            child: Container(
              color: containerLeftBackgroundColor,
              child: Center(
                child: SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(color: containerLeftBackgroundColor.contrastWB()),
                ),
              ),
            ),
          ),
        ],
      ),
    };
  }
}
