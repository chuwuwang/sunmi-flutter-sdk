import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/pages/base_stateless_widget.dart';
import 'package:sun_mi_flutter_sdk/theme/colors.dart';

class BasicScreenExclusivePage extends BaseStatelessWidget {

  const BasicScreenExclusivePage( { Key ? key } ) : super(key: key);

  @override
  String getTitleString() => "Set screen exclusive";

  @override
  Widget onCreateChild(BuildContext context) {
    var content = _content(context);
    var container = Container(padding: const EdgeInsets.all(16), child: content);
    return SingleChildScrollView(child: container);
  }

  Widget _content(BuildContext context) {
    var radius = const Radius.circular(4);
    var borderRadius = BorderRadius.all(radius);
    var border = Border.all(color: ColorHelper.accentColor, width: 1, style: BorderStyle.solid);
    var boxDecoration = BoxDecoration(border: border, shape: BoxShape.rectangle, borderRadius: borderRadius);
    var padding = const EdgeInsets.all(8);
    var marginEnd = const SizedBox(width: 8);
    var marginTop = const SizedBox(height: 16);
    var innerPaddingTop = const SizedBox(height: 8);
    var textStyle = const TextStyle(fontSize: 14, color: ColorHelper.textContentColor);

    emptyAction() => {};

    var textScreenExclusive = Text("Screen exclusive\nPower key disabled\nVolume key disabled\nSystem status bar disabled\nSystem navigation bar disabled", style: textStyle, textAlign: TextAlign.start);
    var enableScreenExclusiveButton = _button("Set screen monopoly", emptyAction);
    var disableScreenExclusiveButton = _button("Clear screen monopoly", emptyAction);
    List<Widget> rowScreenExclusiveList = [enableScreenExclusiveButton, marginEnd, disableScreenExclusiveButton];
    var rowScreenExclusive = Row(children: rowScreenExclusiveList);
    List<Widget> columnScreenExclusiveList = [textScreenExclusive, innerPaddingTop, rowScreenExclusive];
    var columnScreenExclusive = Column(crossAxisAlignment: CrossAxisAlignment.start, children: columnScreenExclusiveList);
    var containerScreenExclusive = Container(padding: padding, decoration: boxDecoration, child: columnScreenExclusive);

    var textStatusBar = Text("Set status bar drop down mode", style: textStyle, textAlign: TextAlign.start);
    var enableStatusBar = _button("Enable", emptyAction);
    var disableStatusBar = _button("Disable", emptyAction);
    List<Widget> rowStatusBarList = [disableStatusBar, marginEnd, enableStatusBar];
    var rowStatusBar = Row(children: rowStatusBarList);
    List<Widget> columnStatusBarList = [textStatusBar, innerPaddingTop, rowStatusBar];
    var columnStatusBar = Column(crossAxisAlignment: CrossAxisAlignment.start, children: columnStatusBarList);
    var containerStatusBar = Container(padding: padding, decoration: boxDecoration, child: columnStatusBar);

    var textNavigationBar = Text("Set navigation bar or item key visibility", style: textStyle, textAlign: TextAlign.start);
    var hideNavigationBar = _button("Hide navigation bar", emptyAction);
    var showNavigationBar = _button("Show navigation bar", emptyAction);
    List<Widget> rowNavigationBarList = [hideNavigationBar, marginEnd, showNavigationBar];
    var rowNavigationBar = Row(children: rowNavigationBarList);

    var hideBackKey = _button("Hide Back key", emptyAction);
    var hideHomeKey = _button("Hide Home key", emptyAction);
    var hideRecentKey = _button("Hide Recent key", emptyAction);
    List<Widget> rowHideKeyList = [hideBackKey, marginEnd, hideHomeKey, marginEnd, hideRecentKey];
    var rowHideKey = Row(children: rowHideKeyList);

    var hideBackHomeKey = _button("Hide Back and Home key", emptyAction);
    var hideBackRecentKey = _button("Hide Back and Recent key", emptyAction);
    var hideHomeRecentKey = _button("Hide Home and Recent key", emptyAction);
    List<Widget> rowHide2KeyList = [hideBackHomeKey, marginEnd, hideBackRecentKey, marginEnd, hideHomeRecentKey];
    var rowHide2Key = Row(children: rowHide2KeyList);

    var hideAll = _button("Hide all", emptyAction);
    var showAll = _button("Show all", emptyAction);
    List<Widget> rowHideShowList = [hideAll, marginEnd, showAll];
    var rowHideShow = Row(children: rowHideShowList);

    List<Widget> columnNavigationBarList = [
      textNavigationBar,
      innerPaddingTop, rowNavigationBar,
      innerPaddingTop, rowHideKey,
      innerPaddingTop, rowHide2Key,
      innerPaddingTop, rowHideShow,
    ];
    var columnNavigationBar = Column(crossAxisAlignment: CrossAxisAlignment.start, children: columnNavigationBarList);
    var containerNavigationBar = Container(padding: padding, decoration: boxDecoration, child: columnNavigationBar);

    List<Widget> children = [containerScreenExclusive, marginTop, containerStatusBar, marginTop, containerNavigationBar];
    return Column(children: children);
  }

  _button(String data, VoidCallback onPressed) {
    var borderRadius = BorderRadius.circular(4);
    var roundedRectangleBorder = RoundedRectangleBorder(borderRadius: borderRadius);
    var textStyle = const TextStyle(color: Colors.white, fontSize: 14);
    var text = Text(data, style: textStyle, textAlign: TextAlign.center);
    var button = MaterialButton(padding: EdgeInsets.zero, color: ColorHelper.themeColor, onPressed: onPressed, child: text, shape: roundedRectangleBorder);
    var container = SizedBox(height: 40, child: button);
    return Expanded(flex: 1, child: container);
  }

}