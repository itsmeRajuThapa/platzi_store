import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryLoagingShimmer extends StatelessWidget {
  const CategoryLoagingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      //backgroundBlendMode: BlendMode.darken,
                      color: Colors.grey))),
          Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      //backgroundBlendMode: BlendMode.darken,
                      color: Colors.grey))),
          Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      //backgroundBlendMode: BlendMode.darken,
                      color: Colors.grey))),
        ],
      ),
    );
  }
}

class AllProductLoadingShimmer extends StatelessWidget {
  const AllProductLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            mainAxisExtent: 280,
          ),
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.inversePrimary,
            ));
          },
        ));
  }
}
