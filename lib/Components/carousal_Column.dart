import 'package:flutter/material.dart';

class Carousal_Column extends StatelessWidget {
  const Carousal_Column({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
              height: 70,
              width: 70,
              child: Image.network('https://via.placeholder.com/150')),
          // Replace with song image
          title: Text('Naino Ne Baandhi'),
          subtitle: Text('Best Of Akshay Kumar'),
          trailing: Icon(Icons.more_vert),
        ),
        ListTile(
          leading: Container(
              height: 70,
              width: 70,
              child: Image.network('https://via.placeholder.com/150')),
          // Replace with song image
          title: Text('Jogi - Lyrical |Shaadi M...'),
          subtitle: Text('Shafqat Amanat Ali'),
          trailing: Icon(Icons.more_vert),
        ),
        ListTile(
          leading: Container(
              height: 70,
              width: 70,
              child: Image.network('https://via.placeholder.com/150')),
          // Replace with song image
          title: Text('World War (Lofi) (Lo...'),
          subtitle: Text('Saaaj Tomar, chaahat,...'),
          trailing: Icon(Icons.more_vert),
        ),
        ListTile(
          leading: Container(
              height: 70,
              width: 70,
              child: Image.network('https://via.placeholder.com/150')),
          // Replace with song image
          title: Text('Thar (Lofi) (Lo...'),
          subtitle: Text('Best Songs'),
          trailing: Icon(Icons.more_vert),
        ),
      ],
    );
  }
}