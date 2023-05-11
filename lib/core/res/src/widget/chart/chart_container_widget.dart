import 'package:eighty_three_native_component/core/res/src/constant/widget_keys.dart';
import 'package:eighty_three_native_component/core/res/src/widget/container_with_shadow_widget.dart';
import 'package:eighty_three_native_component/core/res/src/widget/dropdown_widget.dart';
import 'package:eighty_three_native_component/core/res/theme/font_styles.dart';
import 'package:eighty_three_native_component/eighty_three_native_component.dart';
import 'package:flutter/material.dart';

class ChartContainerWidget extends StatelessWidget {
  const ChartContainerWidget({
    super.key,
    required this.type,
    this.onDurationChanged,
    required this.duration,
    required this.data,
    required this.total,
  });
  final String type;
  final ValueChanged<String?>? onDurationChanged;
  final String duration;
  final Map<String, dynamic> data;
  final double total;

  @override
  Widget build(BuildContext context) {
    return ContainerWithShadow(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "$total",
                          style: header5Style,
                        ),
                        TextSpan(
                          text: " ${tr('sar')}",
                          style: bodyStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    tr("${type}_in_this_month"),
                    style: smallStyle.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 120,
                child: CustomDropdown<String>(
                  key: budgetFilterDropdownKey,
                  itemToString: (String value) => tr(value),
                  items: const <String>[
                    "weekly",
                    "monthly",
                    "yearly",
                  ],
                  onChanged: onDurationChanged,
                  value: duration,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ChartWidget(
              data: data,
            ),
          ),
        ],
      ),
    );
  }
}
