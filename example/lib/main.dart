import 'package:flutter/material.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Widget>(
          future: _buildWidget(context),
          //future: _buildWidget(context),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? SizedBox.expand(
                    child: snapshot.data,
                  )
                : Text("Loading...");
          },
        ),
      ),
    );
  }

  
}

Future<Widget> _buildWidget(BuildContext context) async {

  String _url = "https://raw.githubusercontent.com/farukx/dynamic_widget/master/sablon.json";

  http.Response response = await http.get(_url);

  return DynamicWidgetBuilder()
      .build(response.body, context, new DefaultClickListener());
}

class DefaultClickListener implements ClickListener {
  @override
  void onClicked(String event) {
    print("Receive click event: " + event);
  }
}
