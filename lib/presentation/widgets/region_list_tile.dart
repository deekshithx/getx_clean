import 'package:flutter/material.dart';
import 'package:zetexa_assignment/domain/entity/home_page_entity/region_model.dart';

class RegionListTile extends StatelessWidget {
  const RegionListTile({super.key, required this.region, this.onTap});

  final Region region;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(children: [
          Image.asset(
            region.imagePath,
            width: 100,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    region.name,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'From \$ ${region.startPrice} USD per day',
                    style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xffA7A7A7),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
          )
        ]),
      ),
    );
  }
}
