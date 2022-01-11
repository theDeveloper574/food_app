


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myyapp/screens/detail_screen.dart';

class bottomContainer extends StatefulWidget {
  late final String image;
  late final String name;
  late final String price;
  late final Function onTab;
  bottomContainer({required this.image, required this.name, required this.price,required this.onTab,});
  @override
  _bottomContainerState createState() => _bottomContainerState();
}

class _bottomContainerState extends State<bottomContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Color(0xff3e3e3e), borderRadius: BorderRadius.circular(10)),
        // height: 270,
        // width: 220,
        width: MediaQuery.of(context).size.width * 0.43,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(widget.image),
            ),
            ListTile(
              leading: Text(
                widget.name,
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
              trailing: Text(
                widget.price,
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
