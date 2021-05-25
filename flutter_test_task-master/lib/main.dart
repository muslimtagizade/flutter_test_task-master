import 'package:flutter/material.dart';
import 'package:flutter_test_task/button.dart';
import 'package:flutter_test_task/provider.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var btc;
  String text = 'Press Me';
  final items = List<bool>.generate(500, (i) => false);
  void initState() {
    getIt.registerSingleton<BtcModel>(BtcModelImplementation(),
        signalsReady: true);

    getIt
        .isReady<BtcModel>()
        .then((_) => getIt<BtcModel>().addListener(update));
    getIt<BtcModel>().cartGet();
    // Alternative
    // getIt.getAsync<AppModel>().addListener(update);

    super.initState();
  }

  void update() {
    setState(() => {
          btc = getIt<BtcModel>().btcv,
          print(btc),
        });
  }

  @override
  void dispose() {
    getIt<BtcModel>().removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 45,
                    padding: EdgeInsets.all(4),
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.blueGrey,
                      onPressed: () {
                        getIt<BtcModel>().cartGet();
                        setState(() {
                          items[index] = !items[index];
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      label: Text(
                        items[index]
                            ? double.parse(btc).toStringAsFixed(2).toString()
                            : 'Press Me',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
