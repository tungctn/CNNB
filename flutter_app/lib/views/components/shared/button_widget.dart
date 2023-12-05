import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/color_palatte.dart';
import 'package:flutter_app/core/constants/dismention_constants.dart';
import 'package:flutter_app/core/constants/textstyle_constants.dart';

class ButtonWidget extends StatefulWidget {
  final double scaleUp = 0.7;
  final String title;
  final Function()? ontap;

  const ButtonWidget({super.key, required this.title, this.ontap});

  @override
  ButtonWidgetState createState() => ButtonWidgetState();
}

class ButtonWidgetState extends State<ButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (widget.ontap),
      // onTapDown: (TapDownDetails details) {
      //   _controller.forward();
      //   Future.delayed(const Duration(milliseconds: 200), () {
      //     _controller.reverse();
      //   });
      // },
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.0,
          end: widget.scaleUp,
        ).animate(_controller),
        child: Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kMediumPadding),
              color: ColorPalette.buttonColor,
            ),
            alignment: Alignment.center,
            child: Text(widget.title,
                style: widget.title != "Reset"
                    ? TextStyles.defaultStyle.bold.whiteTextColor
                    : TextStyles.defaultStyle.bold.primaryTextColor)),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
