import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/config/speech_to_text_service.dart';
import '../../../../core/helpers/spacing.dart';
import '../../data/models/meal_data.dart';
import '../../data/repo/home_repo.dart';
import '../../data/services/voice_meal_logging_service.dart';
import '../../data/services/meal_request_helper.dart';
import '../cubit/home_cubit.dart';
import '../widgets/today_info_card.dart';
import '../widgets/calories_card.dart';
import '../widgets/macronutrients_card.dart';
import '../widgets/mic_button_widget.dart';
import '../widgets/recording_timer_widget.dart';
import '../widgets/empty_meals_state.dart';
import '../widgets/logged_meals_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(homeRepo: getIt<HomeRepo>()),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent();

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final VoiceMealLoggingService _voiceService;
  final List<MealData> _loggedMeals = [];

  @override
  void initState() {
    super.initState();
    _voiceService = VoiceMealLoggingService(getIt<SpeechToTextService>());
    _checkSpeechServiceAvailability();
  }

  void _checkSpeechServiceAvailability() {
    if (!_voiceService.isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSnackBar(
          'Voice input is not available. Please check microphone permissions.',
          isError: true,
        );
      });
    }
  }

  void _toggleRecording() async {
    if (!_voiceService.isInitialized) {
      _showSnackBar('Speech service not available', isError: true);

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
      _showSnackBar(
        result.errorMessage ?? 'Failed to start recording',
        isError: true,
      );
    }
  }

  Future<void> _stopListening() async {
    final result = await _voiceService.stopListening();

    setState(() {});

    if (result.isSuccess && result.data != null) {
      _processMealInput(result.data!);
    } else if (!result.isSuccess) {
      _showSnackBar(result.errorMessage ?? 'Recording failed', isError: true);
    }
  }

  void _processMealInput(String mealText) {
    // Create request using helper
    final request = MealRequestHelper.createRequest(mealText);

    if (request == null) {
      _showSnackBar('User not authenticated', isError: true);

      return;
    }

    // Call cubit to get meal data from API
    context.read<HomeCubit>().getMealData(request: request);
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: isError ? 3 : 2),
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

    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeSuccess) {
          setState(() {
            _loggedMeals.insert(0, state.mealData);
          });
          _showSnackBar('Meal logged successfully!');
        } else if (state is HomeError) {
          _showSnackBar(
            state.apiErrorModel.message ?? 'Failed to log meal',
            isError: true,
          );
        }
      },
      child: Scaffold(
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
                      Expanded(
                        child: _loggedMeals.isEmpty
                            ? const EmptyMealsState()
                            : LoggedMealsList(meals: _loggedMeals),
                      ),
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
      ),
    );
  }
}
