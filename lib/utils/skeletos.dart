// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeletos {

  static Widget sckeletoCategories() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          direction: ShimmerDirection.ltr,
          child: Container(
            height: 20,
            child: ListView.builder(
                itemCount: 5,
                itemExtent: 120,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    height: 100,
                    width: 100,
                  );
                }),
          )),
    );
  }

  
   static Widget sckeletoPlace() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          direction: ShimmerDirection.ltr,
          child: Container(
            height: 230,
            child: ListView.builder(
                itemCount: 3,
                itemExtent: 140,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: 100,
                    width: 100,
                  );
                }),
          )),
    );
  }

  static   Widget sckeletoEvents() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          direction: ShimmerDirection.ltr,
          child: Container(
            height: 230,
            child: ListView.builder(
                itemCount: 3,
                itemExtent: 220,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: 100,
                    width: 100,
                  );
                }),
          )),
    );
  }

 
}
