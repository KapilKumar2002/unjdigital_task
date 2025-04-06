import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:unjdigital_flutask/presentation/widgets/custom_button.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> extra =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String errorMessage = extra['errorMessage'];
    final Function onRetry = extra['onRetry'];
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'assets/error.json', // Add this Lottie file to your assets
                height: 200,
                repeat: true,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                errorMessage,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: "Retry",
              onPressed: () {
                onRetry();
              },
            )
          ],
        ),
      ),
    );
  }
}
