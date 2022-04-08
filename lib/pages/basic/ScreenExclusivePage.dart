import 'package:flutter/material.dart';
import 'package:sun_mi_flutter_sdk/plugins/DeviceInfoEngine.dart';

class ScreenExclusivePage extends StatelessWidget {

  const ScreenExclusivePage( { Key ? key } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen Exclusive'), ),
      body: _mainView(context),
    );
  }

  _mainView(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2, style: BorderStyle.solid),
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(4), ), ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Screen exclusive\nPower key disabled\nVolume key disabled\nSystem status bar disabled\nSystem navigation bar disabled',
                    style: TextStyle(fontSize: 12, height: 1.5),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    children: [
                      _tabItem('Enable', false, () { DeviceInfoEngine.enableScreenMonopoly(); } ),
                      _tabItem('Disable', true, () { DeviceInfoEngine.disableScreenMonopoly(); } ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2, style: BorderStyle.solid),
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(4), ), ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Set status bar drop down mode',
                    style: TextStyle(fontSize: 12, height: 1.5),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    children: [
                      _tabItem('Enable', false, () { DeviceInfoEngine.enableStatusBarDropDown(); } ),
                      _tabItem('Disable', true, () { DeviceInfoEngine.disableStatusBarDropDown(); } ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2, style: BorderStyle.solid),
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(4), ), ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Set navigation bar and item key visibility',
                    style: TextStyle(fontSize: 12, height: 1.5),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    children: [
                      _tabItem('Show NavigationBar', false, () { DeviceInfoEngine.showNavigationBar(); } ),
                      _tabItem('Hide NavigationBar', true, () { DeviceInfoEngine.hideNavigationBar(); } ),
                    ],
                  ),
                  Row(
                    children: [
                      _tabItem('Hide Back Key', false, () { DeviceInfoEngine.hideNavigationBarItemKey(DeviceInfoEngine.navigationBarItemKeyBack); } ),
                      _tabItem('Hide Home Key', false, () { DeviceInfoEngine.hideNavigationBarItemKey(DeviceInfoEngine.navigationBarItemKeyHome); } ),
                      _tabItem('Hide Recent Key', true, () { DeviceInfoEngine.hideNavigationBarItemKey(DeviceInfoEngine.navigationBarItemKeyRecent); } ),
                    ],
                  ),
                  Row(
                    children: [
                      _tabItem('Hide Back/Home Key', false, () { DeviceInfoEngine.hideNavigationBarItemKey(DeviceInfoEngine.navigationBarItemKeyBack | DeviceInfoEngine.navigationBarItemKeyHome); } ),
                      _tabItem('Hide Back/Recent Key', false, () { DeviceInfoEngine.hideNavigationBarItemKey(DeviceInfoEngine.navigationBarItemKeyBack | DeviceInfoEngine.navigationBarItemKeyRecent); } ),
                      _tabItem('Hide Home/Recent Key', true, () { DeviceInfoEngine.hideNavigationBarItemKey(DeviceInfoEngine.navigationBarItemKeyHome | DeviceInfoEngine.navigationBarItemKeyRecent); } ),
                    ],
                  ),
                  Row(
                    children: [
                      _tabItem('Show All Key', false, () { DeviceInfoEngine.hideNavigationBarItemKey(0); } ),
                      _tabItem('Hide All Key', true, () { DeviceInfoEngine.hideNavigationBarItemKey(DeviceInfoEngine.navigationBarItemKeyBack | DeviceInfoEngine.navigationBarItemKeyHome | DeviceInfoEngine.navigationBarItemKeyRecent); } ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _tabItem(String text, bool end, VoidCallback onPressed) {
    double marginEnd = 8;
    if (end) {
      marginEnd = 0;
    }
    return Expanded(
        flex: 1,
        child: Container(
          height: 40,
          margin: EdgeInsets.fromLTRB(0, 8, marginEnd, 0),
          child: MaterialButton(
            padding: EdgeInsets.zero,
            color: Colors.blueAccent,
            onPressed: onPressed,
            child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 14), textAlign: TextAlign.center, ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), ),
          ),
        )
    );
  }

}