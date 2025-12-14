import 'package:dalilak_app/features/compare/views/widgets/spec_row.dart';
import 'package:dalilak_app/features/compare/views/widgets/spec_section.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'compare_header_card.dart';

class CompareViewBody extends StatelessWidget {
  const CompareViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: SingleChildScrollView(

        child: Column(
          children: [
            SizedBox(height: MyResponsive.height(value: 140)),
            Text(AppStrings.compareCarsTitle, style: AppTextStyles.bold20),
            SizedBox(height: MyResponsive.height(value: 16)),
            const CompareHeaderCard(),
            SizedBox(height: MyResponsive.height(value: 16)),
            SpecsSection(
              sectionTitle: 'المحرك والقوة',
              specs: const [
                SpecRow(title: 'سعة المحرك (لتر)', leftValue: '2000', rightValue: '1499'),
                SpecRow(title: 'الاقتصاد في استهلاك الوقود (لتر/100كم)', leftValue: '11.0', rightValue: '5.0'),
                SpecRow(title: 'نوع الوقود', leftValue: 'Petrol', rightValue: 'Petrol'),
                SpecRow(title: 'قوة المحرك (حصان)', leftValue: '252', rightValue: '140'),
              ],
            ),
            SizedBox(height: MyResponsive.height(value: 16)),
            SpecsSection(
              sectionTitle: 'الأداء والتسارع',
              specs: const [
                SpecRow(title: 'سرعة قصوى (كم/س)', leftValue: '250', rightValue: '180'),
                SpecRow(title: 'زمن التسارع 0-100 كم/س', leftValue: '6.5', rightValue: '10.2'),
              ],
            ),
            SizedBox(height: MyResponsive.height(value: 100)),
          ],
        ),
      ),
    );
  }
}