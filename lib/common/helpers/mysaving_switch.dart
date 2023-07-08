import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';

class MysavingSwitch extends StatefulWidget {
  const MysavingSwitch({
    super.key,
    required this.isSwitchedValue,
    required this.onSwitchChanged,
  });

  final bool isSwitchedValue;
  final Function(bool) onSwitchChanged;
  @override
  State<MysavingSwitch> createState() => _MysavingSwitchState();
}

class _MysavingSwitchState extends State<MysavingSwitch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isIOS = Platform.isIOS;
    final Widget switchWidget = isIOS
        ? CupertinoSwitch(
            value: widget.isSwitchedValue,
            onChanged: (value) {
              widget.onSwitchChanged(value);
            },
          )
        : Switch(
            value: widget.isSwitchedValue,
            onChanged: (value) {
              widget.onSwitchChanged(value);
            },
          );

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        FittedBox(
          fit: BoxFit.fill,
          child: Container(
            child: Row(
              children: [
                Text('Light',
                    style:
                        TextStyle(color: MySavingColors.defaultThemeTextLight)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: switchWidget,
                ),
                Text('Dark',
                    style:
                        TextStyle(color: MySavingColors.defaultThemeTextDark))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
