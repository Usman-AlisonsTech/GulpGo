import 'package:aqua_flow/models/all_product_model.dart';
import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/order/order_controller.dart';
import 'package:aqua_flow/views/order/widgets/dropdown_field_widget.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstStepWidget extends StatelessWidget {
  FirstStepWidget({super.key});

  final controller = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: Container(
            margin: const EdgeInsets.only(top: 180),
            child: const CircularProgressIndicator(),
          ),
        );
      }

      final allProducts = controller.allProductData.value?.products ?? [];

      final products = controller.isRecurring.value
          ? allProducts.where((p) => p.isReusable == true).toList()
          : allProducts;

      if (products.isEmpty) {
        return Center(
          child: Container(
            margin: const EdgeInsets.only(top: 180),
            child: const CustomText(text: 'No products found'),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          const CustomText(
            text: "Select Bottle Size & Quantity",
            fontSize: 17,
            weight: FontWeight.w500,
          ),

          const SizedBox(height: 12),

          _orderSettingsCard(),

          const SizedBox(height: 20),

          /// 🔥 PRODUCTS
          ListView.builder(
            itemCount: products.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildBottleRow(product),
              );
            },
          ),
        ],
      );
    });
  }

  // ---------------- ORDER SETTINGS CARD ----------------

  Widget _orderSettingsCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorConstants.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: "Order Settings",
            fontSize: 13,
            weight: FontWeight.w500,
          ),
          const SizedBox(height: 10),
          Obx(() => Row(
                children: [
                  Checkbox(
                    value: controller.isRecurring.value,
                    onChanged: (val) {
                      controller.isRecurring.value = val ?? false;

                      if (!controller.isRecurring.value) {
                        controller.recurrence.value = '';
                        controller.preferredTime.value = '';
                      }
                      controller.recalculate(controller.withBottles.value,
                          isRecurring: controller.isRecurring.value);
                    },
                  ),
                  const CustomText(
                    text: "Sales is a recurring order?",
                    fontSize: 13,
                  ),
                ],
              )),
          Obx(() => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: controller.withBottles.value,
                    onChanged: (val) {
                      controller.withBottles.value = val ?? false;
                      controller.recalculate(controller.withBottles.value,
                          isRecurring: controller.isRecurring.value);
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CustomText(text: "With Bottles?", fontSize: 13),
                      SizedBox(height: 2),
                      CustomText(
                        text: "Include bottles with the delivery order",
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              )),
          Obx(() {
            if (!controller.isRecurring.value) return const SizedBox();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                const CustomText(
                  text: "Recurrence Pattern *",
                  fontSize: 12,
                ),
                const SizedBox(height: 4),
                dropdownField(
                  hint: "Select recurrence",
                  value: controller.recurrence.value.isEmpty
                      ? null
                      : controller.recurrence.value,
                  items: const [
                    "WEEKLY",
                    "BI_WEEKLY",
                    "MONTHLY",
                  ],
                  onChanged: (val) {
                    controller.recurrence.value = val ?? '';
                  },
                ),
                const SizedBox(height: 10),
                const CustomText(
                  text: "Preferred Delivery Time *",
                  fontSize: 12,
                ),
                const SizedBox(height: 4),
                dropdownField(
                  hint: "Select time",
                  value: controller.preferredTime.value.isEmpty
                      ? null
                      : controller.preferredTime.value,
                  items: const [
                    "Morning",
                    "Afternoon",
                    "Evening",
                  ],
                  onChanged: (val) {
                    controller.preferredTime.value = val ?? '';
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  // ---------------- PRODUCT CARD ----------------

  Widget _buildBottleRow(Product product) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.lightGrey),
      ),
      child: Column(
        children: [
          Row(
            children: [
              /// IMAGE
              Container(
                width: 55,
                height: 55,
                color: const Color(0xFFE3F2FD),
                child: CachedNetworkImage(
                  imageUrl: product.image != null
                      ? "http://192.168.50.227:8001${product.image}"
                      : '',
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.error_outline,
                    color: Colors.redAccent,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: product.name ?? '',
                      fontSize: 15,
                      weight: FontWeight.w500,
                    ),
                    CustomText(
                      text: product.size ?? '',
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                    Obx(() {
                      if (!controller.withBottles.value ||
                          (product.depositAmount ?? 0) == 0) {
                        return const SizedBox();
                      }
                      return CustomText(
                        text: "+PKR ${product.depositAmount} Deposit",
                        fontSize: 10,
                        color: ColorConstants.redColor,
                      );
                    }),
                  ],
                ),
              ),

              /// PRICE
              CustomText(
                text: "Rs. ${product.price}",
                fontSize: 16,
                color: ColorConstants.themeColor,
              ),
            ],
          ),

          const SizedBox(height: 15),

          /// Quantity UI
          Obx(() {
            final qty = controller.quantities[product.id] ?? 0;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.updateQuantity(
                        product, false, controller.withBottles.value);
                  },
                  child: _qtyBtn(Icons.remove),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CustomText(
                    text: qty.toString(),
                    fontSize: 17,
                    weight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.updateQuantity(
                        product, true, controller.withBottles.value);
                  },
                  child: _qtyBtn(Icons.add, isAdd: true),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon, {bool isAdd = false}) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isAdd ? ColorConstants.themeColor : const Color(0xFFE3F2FD),
      ),
      child: Icon(
        icon,
        size: 22,
        color: isAdd ? Colors.white : Colors.black,
      ),
    );
  }
}
