import 'package:flutter/material.dart';
import 'package:notf_demo/notification_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationServices notificationServices = NotificationServices();
  await notificationServices.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                NotificationServices services = NotificationServices();
                await services.testNotification();
              },
              child: const Text("Set notification"),
            )
          ],
        ),
      ),
    );
  }
}


