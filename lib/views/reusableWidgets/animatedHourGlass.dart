import '../../utilities/imports/generalImport.dart';

class AnimatedHourglass extends StatefulWidget {
  @override
  _AnimatedHourglassState createState() => _AnimatedHourglassState();
}

class _AnimatedHourglassState extends State<AnimatedHourglass>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: const Icon(
        Icons.hourglass_empty_rounded,
        color: AppColors.whiteLight,
        size: 20,
      ),
    );
    
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}