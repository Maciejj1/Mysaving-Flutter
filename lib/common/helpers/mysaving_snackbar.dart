import 'package:flutter/material.dart';

class MysavingSnackBar extends StatefulWidget {
  const MysavingSnackBar.success({
    Key? key,
    required this.message,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 24),
    this.maxLines = 2,
    this.backgroundColor = Colors.green,
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  const MysavingSnackBar.error({
    Key? key,
    required this.message,
    this.messagePadding =
        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.maxLines = 2,
    this.backgroundColor = Colors.red,
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  final String message;
  final Color backgroundColor;
  final int maxLines;
  final List<BoxShadow> boxShadow;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry messagePadding;
  final double textScaleFactor;
  final TextAlign textAlign;

  @override
  State<MysavingSnackBar> createState() => _MysavingSnackBarState();
}

class _MysavingSnackBarState extends State<MysavingSnackBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      // height: 80,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow,
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Center(
          child: Text(
            widget.message,
            style: theme.textTheme.bodyText2?.merge(
              const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            textAlign: widget.textAlign,
            overflow: TextOverflow.ellipsis,
            maxLines: widget.maxLines,
            textScaleFactor: widget.textScaleFactor,
          ),
        ),
      ),
    );
  }
}

const kDefaultBoxShadow = [
  BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 8),
    spreadRadius: 1,
    blurRadius: 30,
  ),
];

const kDefaultBorderRadius = BorderRadius.all(Radius.circular(11));
