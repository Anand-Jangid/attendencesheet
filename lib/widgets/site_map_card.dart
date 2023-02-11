import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/site_map_card_model.dart';

class SiteMapCard extends StatelessWidget {
  final SiteMapCardModel siteMapCardModel;
  const SiteMapCard({Key? key, required this.siteMapCardModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.0,
      child: GestureDetector(
        onTap: () {
          Get.to(() =>siteMapCardModel.page);
        },
        child: Card(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    siteMapCardModel.leadingIcon,
                    const SizedBox(width:3),
                    Text(siteMapCardModel.title)
                  ]),
                ),
                const Icon(Icons.navigate_next)
              ]),
        ),
      ),
    );
  }
}
