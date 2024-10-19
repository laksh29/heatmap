import 'package:flutter/material.dart';
import 'package:scapia/presentation/typography/text_style.dart';
import 'package:scapia/presentation/widgets/custom_button.dart';
import 'package:scapia/presentation/widgets/subheading_body_text.dart';
import 'package:scapia/screens/home_screen.dart';
import 'package:scapia/services/task_content.dart';
import 'package:scapia/utils/extensions.dart';
import 'package:scapia/utils/size_constants.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        padding: SizeConst.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.whitespaceHeight,
            Text(
              "Transaction Heatmap",
              style: EzTextStyle.headline.large.copyWith(color: Colors.orange),
            ),
            5.whitespaceHeight,
            Text(
              '''This is my submission to Scapia's Assignment for the role of a Flutter Developer.''',
              style: EzTextStyle.body.largeRegular,
            ),
            30.whitespaceHeight,
            Text(
              "Task:",
              style: EzTextStyle.headline.large.copyWith(color: Colors.orange),
            ),
            15.whitespaceHeight,
            ...List.generate(
              taskContent.length,
              (index) => SubheadingBodyText(
                subHeading: taskContent.keys.elementAt(index),
                body: taskContent.values.elementAt(index),
              ),
            ).addSeparator(15.whitespaceHeight),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 15.0),
        height: 80,
        child: CustomButton(
          ctaText: "VIEW THE HEATMAP",
          onTap: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (_) => false,
          ),
        ),
      ),
    );
  }
}
