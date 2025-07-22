import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final double size;
  final Color color;
  final bool filled;
  final IconData icon;
  final Color iconColor;
  final void Function()? onPress;
  final bool isActive;

  const CustomButton({
    super.key,
    required this.size,
    this.color = Colors.red,
    this.filled = true,
    this.icon = Icons.add,
    this.iconColor = Colors.white,
    this.onPress,
    this.isActive = true
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.9;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPress,
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          child: LayoutBuilder(builder: (context, constraints) {
            final size = constraints.maxHeight > constraints.maxWidth ? constraints.maxWidth : constraints.maxHeight;
            return Center(
              child: SizedBox(
                width: size,
                height: size,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: widget.filled ? widget.color : null,
                    border: widget.filled
                        ? null
                        : Border.all(color: widget.color, width: 3),
                  ),
                  child: Icon(
                    widget.icon,
                    size: size * 0.7,
                    color: widget.iconColor,
                  ),
                ),
              ),
            );
          },)
        ),
      ),
    );
  }
}
