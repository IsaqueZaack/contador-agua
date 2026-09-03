import 'package:flutter/material.dart';
import '../services/preferences_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PreferencesService _preferencesService = PreferencesService();

  int _totalCups = 0;
  int _goalCups = 8;
  bool _isLoading = true;

  static const int _mlPerCup = 250;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final totalCups = await _preferencesService.getTotalCups();
    final goalCups = await _preferencesService.getGoalCups();

    setState(() {
      _totalCups = totalCups;
      _goalCups = goalCups;
      _isLoading = false;
    });
  }

  Future<void> _drinkWater() async {
    final newTotal = _totalCups + 1;

    setState(() {
      _totalCups = newTotal;
    });

    await _preferencesService.saveTotalCups(newTotal);
  }

  Future<void> _removeWater() async {
    if (_totalCups == 0) return;

    final newTotal = _totalCups - 1;

    setState(() {
      _totalCups = newTotal;
    });

    await _preferencesService.saveTotalCups(newTotal);
  }

  Future<void> _resetCounter() async {
    setState(() {
      _totalCups = 0;
    });

    await _preferencesService.saveTotalCups(0);
  }

  Future<void> _editGoal() async {
    final controller = TextEditingController(
      text: _goalCups.toString(),
    );

    final result = await showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Definir meta diária'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Total de copos',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final value = int.tryParse(controller.text);

                if (value != null && value > 0) {
                  Navigator.pop(context, value);
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _goalCups = result;
      });

      await _preferencesService.saveGoalCups(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = _goalCups == 0
        ? 0.0
        : (_totalCups / _goalCups).clamp(0.0, 1.0);

    final totalMl = _totalCups * _mlPerCup;
    final totalLiters = totalMl / 1000;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    const SizedBox(height: 24),

                    const Text(
                      'Contador de Água',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Beba água, cuide de você! 💙',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      width: 210,
                      height: 210,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 210,
                            height: 210,
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 12,
                              backgroundColor: Colors.grey.shade200,
                              strokeCap: StrokeCap.round,
                            ),
                          ),

                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '$_totalCups',
                                style: const TextStyle(
                                  fontSize: 52,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                'de $_goalCups copos',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                '$totalMl ml',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade700,
                                ),
                              ),

                              Text(
                                '${totalLiters.toStringAsFixed(2)} L',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue.shade400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextButton.icon(
                      onPressed: _editGoal,
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Editar meta diária'),
                    ),

                    const Spacer(),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: _drinkWater,
                        icon: const Icon(Icons.local_drink_outlined),
                        label: const Text(
                          'Beber água',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Expanded(
                          child: TextButton.icon(
                            onPressed:
                                _totalCups > 0 ? _removeWater : null,
                            icon: const Icon(
                              Icons.remove_circle_outline,
                            ),
                            label: const Text('Remover 1'),
                          ),
                        ),
                        Expanded(
                          child: TextButton.icon(
                            onPressed: _resetCounter,
                            icon: const Icon(Icons.restart_alt),
                            label: const Text('Reiniciar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}