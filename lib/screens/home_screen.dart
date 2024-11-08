import 'package:flutter/material.dart';
import '../widgets/primary_app_bar.dart';
import '../widgets/unit_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(height: 30),
              UnitCard(unitName: 'Jaguar Unit'),
              SizedBox(height: 40),
              UnitCard(unitName: 'Tobias Unit'),
              SizedBox(height: 40),
              UnitCard(unitName: 'Apex Unit'),
            ],
          ),
        ),
      ),
    );
  }
}
