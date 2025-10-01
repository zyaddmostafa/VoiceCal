import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/config/speech_to_text_service.dart';
import '../../../../core/helpers/spacing.dart';
import '../../data/services/voice_meal_logging_service.dart';
import '../widgets/today_info_card.dart';
import '../widgets/calories_card.dart';
import '../widgets/macronutrients_card.dart';
import '../widgets/meals_section.dart';
import '../widgets/mic_button_widget.dart';
import '../widgets/recording_timer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // Voice meal logging service
  late final VoiceMealLoggingService _voiceService;

  final List<Map<String, dynamic>> _meals = [
    {
      'icon': Icons.restaurant_rounded,
      'iconColor': const Color(0xFF66BB6A),
      'name': 'Grilled Salmon',
      'description': 'Salmon with quinoa & vegetables',
      'calories': 520,
      'isCompleted': true,
    },
    {
      'icon': Icons.local_dining_rounded,
      'iconColor': const Color(0xFF42A5F5),
      'name': 'Mediterranean Bowl',
      'description': 'Chickpeas, feta, olives & greens',
      'calories': 380,
      'isCompleted': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _voiceService = VoiceMealLoggingService(getIt<SpeechToTextService>());
    _checkSpeechServiceAvailability();
  }

  /// Check if speech service is properly initialized
  void _checkSpeechServiceAvailability() {
    if (!_voiceService.isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorSnackBar(
          'Voice input is not available. Please check microphone permissions.',
        );
      });
    }
  }

  void _toggleRecording() async {
    if (!_voiceService.isInitialized) {
      _showErrorSnackBar('Speech service not available');

      return;
    }

    if (_voiceService.isRecording) {
      await _stopListening();
    } else {
      await _startListening();
    }
  }

  Future<void> _startListening() async {
    final result = await _voiceService.startListening(
      onTextUpdate: (text) {
        setState(() {});
      },
    );

    if (result.isSuccess) {
      setState(() {});
    } else {
      _showErrorSnackBar(result.errorMessage ?? 'Failed to start recording');
    }
  }

  Future<void> _stopListening() async {
    final result = await _voiceService.stopListening();

    setState(() {});

    if (result.isSuccess && result.data != null) {
      _processMealInput(result.data!);
    } else if (!result.isSuccess) {
      _showErrorSnackBar(result.errorMessage ?? 'Recording failed');
    }
  }

  void _processMealInput(String mealDescription) {
    // TODO: Integrate with your food parsing/nutrition API
    _addNewMeal(mealDescription);
    _showSuccessSnackBar('Meal logged: $mealDescription');
  }

  void _addNewMeal([String? description]) {
    final newMeal = {
      'icon': Icons.fastfood_rounded,
      'iconColor': const Color(0xFFFF7043),
      'name': description ?? 'Voice Logged Meal',
      'description': description ?? 'Added via voice recording',
      'calories': 350, // TODO: Calculate from API
      'isCompleted': false,
    };

    setState(() {
      _meals.insert(0, newMeal);
    });
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _voiceService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    verticalSpace(20),
                    const TodayInfoCard(),
                    verticalSpace(16),
                    const CaloriesCard(consumed: 1450, goal: 2000),
                    verticalSpace(16),
                    const MacronutrientsCard(),
                    verticalSpace(16),
                    Expanded(child: MealsSection(meals: _meals)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RecordingTimerWidget(
            isRecording: _voiceService.isRecording,
            maxDuration: 30,
          ),
          if (_voiceService.isRecording) verticalSpace(16),
          MicButtonWidget(
            isRecording: _voiceService.isRecording,
            onPressed: _toggleRecording,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
