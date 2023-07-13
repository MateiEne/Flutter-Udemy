import 'package:flutter/material.dart';

class ResultsSummary extends StatelessWidget {
  const ResultsSummary({Key? key, required this.summaryData}) : super(key: key);

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    decoration: BoxDecoration(
                        color: item['selected_answer'] == item['correct_answer']
                            ? Colors.lightBlueAccent
                            : Colors.purpleAccent,
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      ((item['question_index'] as int) + 1).toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item['question'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          item['selected_answer'] as String,
                          style: const TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          item['correct_answer'] as String,
                          style: const TextStyle(
                            color: Colors.lightBlue,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
