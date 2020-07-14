import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class Location {
  final String name;
  final String imageUrl;

  Location({this.name, this.imageUrl});
}

List featuredLocations = [
  Location(
      name: 'Tatra Mountains',
      imageUrl:
          'https://raw.githubusercontent.com/mivoligo/resources/master/tatry.jpg'),
  Location(
      name: 'Paris',
      imageUrl:
          'https://raw.githubusercontent.com/mivoligo/resources/master/france.jpg'),
  Location(
      name: 'Honsiu',
      imageUrl:
          'https://raw.githubusercontent.com/mivoligo/resources/master/japan.jpg'),
  Location(
      name: 'Manarola',
      imageUrl:
          'https://raw.githubusercontent.com/mivoligo/resources/master/italy.jpg')
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class LocationListTile extends StatelessWidget {
  final String title;
  final String description;

  const LocationListTile({
    Key key,
    this.title,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0x33000000),
                    offset: Offset(0.0, 5.0),
                    blurRadius: 12.0),
              ],
            ),
          ),
          Column(
            children: [
              Text(title),
              Text(description),
            ],
          )
        ],
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _appWidth;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    _appWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discover',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.black87,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: _appWidth * 0.8 * 0.7,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredLocations.length,
              itemBuilder: (context, index) => FeaturedCard(
                width: _appWidth * 0.8,
                text: featuredLocations[index].name,
                imageUrl: featuredLocations[index].imageUrl,
              ),
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class FeaturedCard extends StatelessWidget {
  final double width;
  final String text;
  final String imageUrl;

  const FeaturedCard(
      {Key key,
      this.width = 300,
      this.text = 'Tatra Mountains',
      this.imageUrl =
          'https://raw.githubusercontent.com/mivoligo/resources/master/tatry.jpg'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.lightBlue,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Container(
              width: width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
              )),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        end: Alignment.topCenter,
                        begin: Alignment.bottomCenter,
                        colors: [Color(0x99000000), Colors.transparent])),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                      Row(children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 16.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 16.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 16.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 16.0,
                        ),
                        Icon(
                          Icons.star_half,
                          color: Colors.yellow,
                          size: 16.0,
                        ),
                        Text(
                          '4.2',
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        )
                      ]),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
