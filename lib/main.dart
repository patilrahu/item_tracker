import 'package:flutter/material.dart';
import 'package:item_tracker/feature/create_item/create_item.dart';
import 'package:item_tracker/viewmodel/createitemviewmodel.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return const Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: Colors.deepPurple,
            ),
          ),
        );
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CreateItemViewModel()),
        ],
        child: const MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home: CreateItem(),
        ),
      ),
    );
  }
}
