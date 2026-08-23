import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppLoadingSkeleton extends StatefulWidget {
  const AppLoadingSkeleton({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<AppLoadingSkeleton> createState() => _AppLoadingSkeletonState();
}

class _AppLoadingSkeletonState extends State<AppLoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final slide = _controller.value * 2 - 1;
            return LinearGradient(
              begin: Alignment(-1 + slide, 0),
              end: Alignment(1 + slide, 0),
              colors: [
                colorScheme.surfaceContainer,
                colorScheme.surfaceContainerHighest.withValues(alpha: 0.72),
                colorScheme.surfaceContainer,
              ],
              stops: const [0.2, 0.5, 0.8],
            ).createShader(bounds);
          },
          child: child,
        );
      },
    );
  }
}

class AppSkeletonBlock extends StatelessWidget {
  const AppSkeletonBlock({
    this.width,
    this.height = 16,
    this.radius,
    super.key,
  });

  final double? width;
  final double height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(radius ?? context.radii.sm),
      ),
      child: SizedBox(width: width, height: height),
    );
  }
}
