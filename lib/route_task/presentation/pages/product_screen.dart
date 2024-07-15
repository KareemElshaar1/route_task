import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:route_task/route_task/domain/use_cases/product_use_case.dart';
import 'package:route_task/route_task/presentation/view_model/products_view_model_cubit.dart';

import '../../../core/animation/shimmer_product_screen.dart';
import '../../../core/utils/app_text_style.dart';
import '../../domain/entities/product_entity.dart';
import '../widgets/custom_product_item_widget.dart';
import '../widgets/custom_text_form_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductsViewModelCubit viewModel = ProductsViewModelCubit(
      getAllProductUseCase: injectGetAllProductUseCase());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    viewModel.searchController.dispose();
    viewModel.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //? section search
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormFieldWidget(
                      controller: viewModel.searchController,
                      myValidator: (text) => null,
                      keyboardType: TextInputType.text,
                      onChanged: (text) {
                        viewModel.searchTextInList(text);
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: null,
                    icon: SvgPicture.asset(
                      "assets/icons/icon-cart.svg",
                      height: 25.h,
                      width: 25.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),

              BlocBuilder<ProductsViewModelCubit, ProductsViewModelState>(
                bloc: viewModel..getProducts(),
                builder: (context, state) {
                  if (state is ProductsViewModelError) {
                    return Center(
                      child: Text(
                        state.error ?? "",
                        style: AppTextStyle.textStyle16,
                      ),
                    );
                  }

                  if (state is ProductsViewModelSuccess) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Gap(20.h),
                        //? section products
                        _gridViewProductWidget(context, viewModel.productsList),
                      ],
                    );
                  }
                  if (state is SearchViewModelSuccess) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Gap(20.h),
                        //? section search
                        _gridViewProductWidget(
                            context, viewModel.productsListSearch),
                      ],
                    );
                  }
                  return const ShimmerProductScreen();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _gridViewProductWidget(
    BuildContext context,
    List<ProductsEntity> productsList,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.79,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.80590,
        ),
        itemBuilder: (context, index) {
          return ProductItem(
            priceOld: productsList[index].discountPercentage,
            descriptionImage: productsList[index].title,
            pathImage: productsList[index].images?[0],
            onTapAddCard: () {},
            onTapLove: () {},
            price: productsList[index].price,
            rating: productsList[index].rating,
          );
        },
        itemCount: productsList.length,
      ),
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      title: SvgPicture.asset(
        "assets/icons/icon-logo-route.svg",
        height: 25.h,
        width: 50.w,
      ),
    );
  }
}
