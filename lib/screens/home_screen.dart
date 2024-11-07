import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF17192D),
        centerTitle: true,
        title: const Text(
          'TRACTIAN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 48,
      ),
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

class UnitCard extends StatelessWidget {
  final String unitName;

  const UnitCard({super.key, required this.unitName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 317, // Largura fixa dos botões
      height: 76, // Altura fixa dos botões
      decoration: BoxDecoration(
        color: const Color(0xFF2188FF), // Cor de fundo do botão
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5), // Borda superior esquerda arredondada
        ),
      ),
      padding: const EdgeInsets.fromLTRB(32, 24, 32, 24), // Padding interno
      child: Row(
        children: [
          const Icon(
            Icons.account_tree,
            color: Colors.white,
          ),
          const SizedBox(width: 16), // Espaçamento entre o ícone e o texto
          Text(
            unitName,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 28 /
                  18, // line-height em Flutter é ajustado pela altura da fonte
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
