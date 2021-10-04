import 'package:flutter/material.dart';

class BotNav extends StatefulWidget {
  const BotNav({Key? key}) : super(key: key);

  @override
  _BotNavState createState() => _BotNavState();
}

class _BotNavState extends State<BotNav> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController!.addListener(() {});
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return 
      Stack(
        children: [
          Positioned(
            bottom: 0, left: 0, 
            child: Container(
              width: size.width,
              // height: 80,
              color: Colors.white,
              child: Stack(
                children: [
                  Center(
                    heightFactor: 0.6,
                    child: FlatButton(
                      padding: EdgeInsets.all(30),
                      shape: const CircleBorder(),
                      color: Colors.green,
                      onPressed: () {}, 
                      child: const Icon(Icons.add)),
                  ),
                  SizedBox(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: () {}, child: const Icon(Icons.add)),
                        ElevatedButton(onPressed: () {}, child: const Icon(Icons.add)),

                        SizedBox(width: size.width*0.2),
                        ElevatedButton(onPressed: () {}, child: const Icon(Icons.add)),
                        ElevatedButton(onPressed: () {}, child: const Icon(Icons.add)),
                        
                      ],
                    ),
                  )
                ],
              ),
        ))],
      )
    ;
  }
}
