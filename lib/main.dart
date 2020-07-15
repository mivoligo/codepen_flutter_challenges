import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Location {
  final String name;
  final String imageUrl;

  Location({this.name, this.imageUrl});
}

List images = [
  'https://raw.githubusercontent.com/mivoligo/resources/master/1.jpg',
  'https://raw.githubusercontent.com/mivoligo/resources/master/2.jpg',
  'https://raw.githubusercontent.com/mivoligo/resources/master/3.jpg',
  'https://raw.githubusercontent.com/mivoligo/resources/master/4.jpg',
  'https://raw.githubusercontent.com/mivoligo/resources/master/5.jpg',
  'https://raw.githubusercontent.com/mivoligo/resources/master/6.jpg',
  'https://raw.githubusercontent.com/mivoligo/resources/master/7.jpg',
  'https://raw.githubusercontent.com/mivoligo/resources/master/8.jpg',
  'https://raw.githubusercontent.com/mivoligo/resources/master/9.jpg',
  'https://raw.githubusercontent.com/mivoligo/resources/master/10.jpg',
  'https://raw.githubusercontent.com/mivoligo/resources/master/11.jpg',
];

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

List mainMenu = [
  'Trending',
  'Africa',
  'America',
  'Asia',
  'Australia',
  'Europe',
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discover',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _appWidth;
  double _appHeight;

  bool get _isPortrait => _appWidth < _appHeight;

  double get _locationListWidth =>
      _isPortrait ? _appWidth : _appWidth - min(_appWidth / 2, 400);

  @override
  Widget build(BuildContext context) {
    _appWidth = MediaQuery.of(context).size.width;
    _appHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discover',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xffeff0fd),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topCenter,
              colors: [Color(0xffe8edfd), Color(0xffeff0fd)]),
        ),
        child: Column(
          children: [
            MainMenu(),
            Expanded(
              child: Flex(
                direction: _isPortrait ? Axis.vertical : Axis.horizontal,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth:
                          _isPortrait ? _appWidth : min(_appWidth / 2, 400),
                      maxHeight: _isPortrait
                          ? min(_appWidth * 0.6, 300)
                          : _appHeight - 100,
                    ),
                    child: ListView.builder(
                      scrollDirection:
                          _isPortrait ? Axis.horizontal : Axis.vertical,
                      itemCount: featuredLocations.length,
                      itemBuilder: (context, index) => FeaturedCard(
                        text: featuredLocations[index].name,
                        imageUrl: featuredLocations[index].imageUrl,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                'Top Locations',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text('View All')
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: _locationListWidth < 600
                                  ? _locationListWidth / 100
                                  : _locationListWidth / 200,
                              crossAxisCount: _locationListWidth < 600 ? 1 : 2,
                            ),
                            itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: LocationListTile(
                                title: 'Location ${index + 1}',
                                imageUrl: images[index % 11],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: mainMenu.length,
          itemBuilder: (context, index) => FlatButton(
                child: Text(
                  mainMenu[index],
                  style: TextStyle(
                      color: index == 0 ? Colors.deepPurple[800] : Colors.grey,
                      fontSize: 16.0),
                ),
                onPressed: () {},
              )),
    );
  }
}

class FeaturedCard extends StatelessWidget {
  final String text;
  final String imageUrl;

  const FeaturedCard({
    Key key,
    this.text,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Card(
          color: Colors.lightBlue,
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
              ),
            ),
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
          ),
        ),
      ),
    );
  }
}

class LocationListTile extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const LocationListTile({
    Key key,
    this.title,
    this.description =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis',
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(width: 16.0),
          Container(
            width: 90,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0xaa000000),
                    offset: Offset(0.0, 5.0),
                    blurRadius: 12.0)
              ],
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.0),
        ],
      ),
    );
  }
}
