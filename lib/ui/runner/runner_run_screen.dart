import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:runner_sos/utils/app_colors.dart';
import 'package:runner_sos/widgets/common/app_bar_builder.dart';

class RunnerRunScreen extends StatefulWidget {
  const RunnerRunScreen({super.key});

  State<RunnerRunScreen> createState() => _RunnerRunScreenState();
}

class _RunnerRunScreenState extends State<RunnerRunScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.build(
        context: context,
        showBackButton: true,
        showQrButton: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: Container(color: AppColors.light)),
            Expanded(flex: 2, child: _buildRunInfo()),
          ],
        ),
      ),
    );
  }

  Widget _buildRunInfo() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text("00:00:00", textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 5,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.pause)),
                ),
                Expanded(
                  flex: 3,
                  child: RawGestureDetector(
                    gestures: <Type, GestureRecognizerFactory>{
                      LongPressGestureRecognizer:
                          GestureRecognizerFactoryWithHandlers<
                            LongPressGestureRecognizer
                          >(
                            () => LongPressGestureRecognizer(
                              debugOwner: this,
                              duration: const Duration(seconds: 3),
                            ),
                            (LongPressGestureRecognizer instance) {
                              instance.onLongPress = () {
                                print(
                                  '3-Second Long Press Recognized! **SUCCESS**',
                                );
                              };
                            },
                          ),
                    },
                    child: InkWell(
                      onTap: () {
                        print('Short Tap avoided accidental stop.');
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: AppColors.sos,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'SOS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: Icon(Icons.stop)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
