import 'package:fashionapp/common/utils/app_routes.dart';
import 'package:fashionapp/common/utils/environment.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/src/auth/controller/auth_notifier.dart';
import 'package:fashionapp/src/auth/controller/password_notifier.dart';
import 'package:fashionapp/src/cart/controller/cart_notifier.dart';
import 'package:fashionapp/src/category/controller/category_notifier.dart';
import 'package:fashionapp/src/entrypoint/controller/bottom_tab_notifier.dart';
import 'package:fashionapp/src/home/controller/home_tab_notifier.dart';
import 'package:fashionapp/src/onboarding/controller/onboarding_notifier.dart';
import 'package:fashionapp/src/products/controller/color_sized_notifier.dart';
import 'package:fashionapp/src/products/controller/products_notifier.dart';
import 'package:fashionapp/src/search/controller/search_notifier.dart';
import 'package:fashionapp/src/splashscreen/views/splashscreen__page.dart';
import 'package:fashionapp/src/wishlist/controller/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // load Env
  await dotenv.load(fileName: Environment.fileName);

  await GetStorage.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<OnboardingNotifier>(
          create: (_) => OnboardingNotifier(),
        ),
        ChangeNotifierProvider<TabNotifier>(
          create: (_) => TabNotifier(),
        ),
        ChangeNotifierProvider<CategoryNotifier>(
          create: (_) => CategoryNotifier(),
        ),
        ChangeNotifierProvider<HomeTabNotifier>(
          create: (_) => HomeTabNotifier(),
        ),
        ChangeNotifierProvider<ProductsNotifier>(
          create: (_) => ProductsNotifier(),
        ),
        ChangeNotifierProvider<ColorSizedNotifier>(
          create: (_) => ColorSizedNotifier(),
        ),
        ChangeNotifierProvider<PasswordNotifier>(
          create: (_) => PasswordNotifier(),
        ),
        ChangeNotifierProvider<AutthNotifier>(
          create: (_) => AutthNotifier(),
        ),
        ChangeNotifierProvider<SearchNotifier>(
          create: (_) => SearchNotifier(),
        ),
        ChangeNotifierProvider<WishlistNotifier>(
          create: (_) => WishlistNotifier(),
        ),
        ChangeNotifierProvider<CartNotifier>(
          create: (_) => CartNotifier(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: screenSize,
      minTextAdapt: true,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          title: AppText.ktitlApp,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        );
      },
      child: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Environment.apiKey,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
