import 'package:aqua_flow/utils/constants.dart';
import 'package:aqua_flow/views/order/order_controller.dart';
import 'package:aqua_flow/views/order/widgets/first_step_widget.dart';
import 'package:aqua_flow/views/order/widgets/fourth_step_widget.dart';
import 'package:aqua_flow/views/order/widgets/second_step_widget.dart';
import 'package:aqua_flow/views/order/widgets/third_step_widget.dart';
import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:aqua_flow/widgets/common_button.dart';
import 'package:get/get.dart';

class OrderView extends StatefulWidget {
  OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final OrderController controller = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    controller.fetchAllProducts(context);
    controller.loadCustomerFromLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenConstants.horizontalPadding,
            vertical: ScreenConstants.verticalPadding,
          ),
          child: Obx(() {
            final currentStep = controller.currentStep.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Request Water',
                  fontSize: 18,
                  weight: FontWeight.w500,
                ),
                CustomText(
                  text: 'Place your order',
                  fontSize: 13,
                  color: const Color(0xff4A4A4A),
                  weight: FontWeight.w500,
                ),
                const SizedBox(height: 5),
                const Divider(color: Color(0xffD1D4D9)),
                const SizedBox(height: 10),

                /// -------- STEPS HEADER --------
                Row(
                  children: [
                    stepCircle(1, 'Bottles', currentStep),
                    stepDivider(),
                    stepCircle(2, 'Details', currentStep),
                    stepDivider(),
                    stepCircle(3, 'Confirm', currentStep),
                  ],
                ),

                const SizedBox(height: 10),
                const Divider(color: Color(0xffD1D4D9)),

                /// -------- STEP UI --------
                Expanded(
                  child: SingleChildScrollView(
                    child: getStepUi(currentStep),
                  ),
                ),

                if (currentStep != 4) const SizedBox(height: 10),

                /// -------- BUTTONS --------
                if (currentStep != 4)
                  Obx(() {
                    bool canProceed = true;

                    if (currentStep == 1) {
                      canProceed = controller.canProceedFromStep1();
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentStep != 1)
                          Expanded(
                            child: CommonButton(
                              title: 'Back',
                              onPressed: controller.backStep,
                              bgColor: Colors.white,
                              textColor: Colors.black,
                              borderColor: ColorConstants.greyColor,
                              verticalPadding: 8,
                            ),
                          ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Opacity(
                            opacity: canProceed ? 1.0 : 0.5,
                            child: CommonButton(
                              title: currentStep == 3 ? 'Place Order' : 'Next',
                              verticalPadding: 8,
                              onPressed: canProceed
                                  ? () {
                                      if (currentStep == 3) {
                                        controller.createOrder(context);
                                      } else {
                                        controller.nextStep();
                                      }
                                    }
                                  : () {},
                            ),
                          ),
                        ),
                      ],
                    );
                  }),

                const SizedBox(height: 10),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget stepCircle(int step, String label, int currentStep) {
    final isActive = step == currentStep;
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor:
              isActive ? ColorConstants.themeColor : Colors.grey[300],
          child: CustomText(
            text: step.toString(),
            fontSize: 14,
            weight: FontWeight.w500,
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        CustomText(
          text: label,
          fontSize: 12,
          weight: FontWeight.w500,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget stepDivider() {
    return Expanded(
      child: Divider(
        color: Colors.grey[300],
        thickness: 2,
      ),
    );
  }

  Widget getStepUi(int step) {
    switch (step) {
      case 1:
        return FirstStepWidget();
      case 2:
        return SecondStepWidget();
      case 3:
        return ThirdStepWidget();
      case 4:
        return FourthStepWidget();
      default:
        return const SizedBox();
    }
  }
}