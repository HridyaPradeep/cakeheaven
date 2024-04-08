import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Trend extends StatefulWidget {
  const Trend({super.key});

  @override
  State<Trend> createState() => _TrendState();
}

class _TrendState extends State<Trend> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 20),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Text('Trending Cakes',style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.bold,color: Colors.pinkAccent.shade200
            ),
            ),
            Text(
              'See All',style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,color: Colors.black45
            ),
            )
          ],
        ),),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i=1;i<5;i++)
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 8
                  )]

                ),
                child: Image.asset('asset/choco.webp'),
              )
            ],
          ),
        )
      ],
    );
  }
}
