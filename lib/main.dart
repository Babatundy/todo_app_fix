import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/provider.dart';

import 'package:fixingtodoapp/screens/first_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Task_data_provider()),
      ],
      child: MaterialApp(
        initialRoute: "main_screen",
        routes: {
          "main_screen": (context) => Main_screen(),
        },
      ),
    ),
  );
}
