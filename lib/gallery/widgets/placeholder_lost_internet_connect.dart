import 'package:flutter/material.dart';
import 'package:flutter_sample_redux/gallery/resources/resources.dart';

class PlaceholderLostInternetConnect extends StatelessWidget {
  const PlaceholderLostInternetConnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppIcons.placeholderNetworkPng,
            width: 130,
            height: 130,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            child: Text(
              AppStrings.ohShucks,
              style: AppTextStyles.textMajorSubColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              AppStrings.slowOrNoInternetConnection,
              textAlign: TextAlign.center,
              style: AppTextStyles.textMinorSubColor,
            ),
          ),
        ],
      ),
    );
  }
}
