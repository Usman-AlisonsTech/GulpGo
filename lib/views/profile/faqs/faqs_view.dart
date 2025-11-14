import 'package:aqua_flow/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';

class FaqsView extends StatelessWidget {
  const FaqsView({super.key});

  final List<Map<String, String>> faqs = const [
    {
      'question': 'How does the water bottle delivery work?',
      'answer':
          'Simply place your order through the app, select your preferred bottle size, and choose a delivery time. Our rider will deliver it right to your doorstep.'
    },
    {
      'question': 'Can I schedule my bottle deliveries?',
      'answer':
          'Yes, you can schedule daily, weekly, or monthly deliveries to ensure you never run out of water.'
    },
    {
      'question': 'What if I need to cancel or reschedule my order?',
      'answer':
          'You can easily cancel or reschedule from the “My Orders” section before your delivery is dispatched.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenConstants.horizontalPadding,
              vertical: ScreenConstants.verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      borderRadius: BorderRadius.circular(50),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SvgPicture.asset('assets/svg/back.svg'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomText(
                      text: 'FAQs',
                      fontSize: 20,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(color: Color(0xffD1D4D9)),

                const SizedBox(height: 20),

                // FAQ List
                ...faqs.map((faq) => _FaqCard(
                      question: faq['question']!,
                      answer: faq['answer']!,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FaqCard extends StatefulWidget {
  final String question;
  final String answer;

  const _FaqCard({required this.question, required this.answer});

  @override
  State<_FaqCard> createState() => _FaqCardState();
}

class _FaqCardState extends State<_FaqCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorConstants.lightGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomText(
                    text: widget.question,
                    fontSize: 15,
                    weight: FontWeight.w500,
                  ),
                ),
                AnimatedRotation(
                  turns: _expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: Colors.black54),
                ),
              ],
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomText(
                text: widget.answer,
                fontSize: 14,
                color: ColorConstants.greyColor,
              ),
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
