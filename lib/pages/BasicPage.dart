import 'package:flutter/material.dart';

class BasicPage extends StatelessWidget {

  const BasicPage( { Key ? key } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic'),
      ),
      body: Text('Basic'),
    );
  }

}