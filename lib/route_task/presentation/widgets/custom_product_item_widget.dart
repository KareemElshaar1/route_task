// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:route_task/core/utils/app_colors.dart';

import '../../../core/animation/shimmer_product_item_image.dart';
import '../../../core/utils/app_text_style.dart';

class ProductItem extends StatelessWidget {
  final String? pathImage;
  final String? descriptionImage;
  final double? price;
  final num? priceOld;
  final double? rating;

  final void Function()? onTapLove;
  final void Function()? onTapAddCard;

  const ProductItem({
    Key? key,
    required this.pathImage,
    required this.descriptionImage,
    required this.price,
    required this.onTapLove,
    required this.onTapAddCard,
    required this.priceOld,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.primaryColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  topRight: Radius.circular(15.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: pathImage ?? "",
                  placeholder: (context, url) =>
                      const ShimmerProductItemImage(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: double.infinity,
                  height: 100.h,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                right: -3,
                child: InkWell(
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: onTapLove,
                  child: SvgPicture.asset(
                    'assets/icons/icon-unselected-love.svg',
                    width: 46.w,
                    height: 46.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: Text(
              descriptionImage ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.textStyle12.copyWith(
                fontSize: 13.sp,
                color: const Color(0xff06004F),
                height: 0,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: Text.rich(
              TextSpan(
                text: 'EGP ',
                style: AppTextStyle.textStyle14.copyWith(
                  fontSize: 14.sp,
                  color: const Color(0xff06004F),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "$price   ",
                  ),
                  TextSpan(
                    text: " $priceOld EGP",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blueColor.withAlpha(100),
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.blueColor,
                      decorationStyle: TextDecorationStyle.solid,
                      overflow: TextOverflow.ellipsis,
                      decorationThickness: 1,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: Row(
              children: [
                Text(
                  "Review ($rating)",
                  style: const TextStyle(
                    color: Color(0xff06004F),
                  ),
                ),
                const Icon(Icons.star, color: Colors.yellow, size: 20),
                const Spacer(),
                InkWell(
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: onTapAddCard,
                  child: SvgPicture.asset(
                    'assets/icons/icon-add.svg',
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
