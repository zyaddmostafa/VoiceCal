import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/speech_to_text_service.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/helpers/custom_snackbar.dart';
import '../../data/models/meal_data.dart';
import '../../data/services/meal_request_helper.dart';
import '../../../../core/config/voice_logging_service.dart';
import '../cubit/home_cubit.dart';
import 'home_screen_bloc_listener.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => HomeScreenContentState();
}

class HomeScreenContentState extends State<HomeScreenContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final VoiceLoggingService _voiceService;
  final List<MealData> _loggedMeals = [];
  bool _isLoadingMeal = false;

  @override
  void initState() {
    super.initState();
    _initializeVoiceService();
  }

  void _initializeVoiceService() {
    _voiceService = VoiceLoggingService(getIt<SpeechToTextService>());

    if (!_voiceService.isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomSnackbar.showError(
          context,
          'Voice input unavailable. Check microphone permissions.',
        );
      });
    }
  }

  // Voice Recording Methods
  Future<void> _toggleRecording() async {
    if (!_voiceService.isInitialized) {
      CustomSnackbar.showError(context, 'Speech service not available');

      return;
    }

    _voiceService.isRecording
        ? await _stopRecording()
        : await _startRecording();
  }

  Future<void> _startRecording() async {
    final result = await _voiceService.startListening(
      onTextUpdate: (_) => setState(() {}),
    );

    if (result.isSuccess) {
      setState(() {});
    } else {
      CustomSnackbar.showError(
        context,
        result.errorMessage ?? 'Failed to start recording',
      );
    }
  }

  Future<void> _stopRecording() async {
    final result = await _voiceService.stopListening();
    setState(() {});

    if (result.isSuccess && result.data != null) {
      _logMeal(result.data!);
    } else if (!result.isSuccess) {
      CustomSnackbar.showError(
        context,
        result.errorMessage ?? 'Recording failed',
      );
    }
  }

  void _logMeal(String mealText) {
    final request = MealRequestHelper.createRequest(mealText);

    context.read<HomeCubit>().getMealData(request: request!);
  }

  void _onMealLogged(MealData mealData) {
    setState(() => _loggedMeals.insert(0, mealData));
    CustomSnackbar.showSuccess(context, 'Meal logged successfully!');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return HomeScreenBlocListener(
      loggedMeals: _loggedMeals,
      isLoadingMeal: _isLoadingMeal,
      isRecording: _voiceService.isRecording,
      onMealLogged: _onMealLogged,
      onLoadingChanged: (isLoading) =>
          setState(() => _isLoadingMeal = isLoading),
      onToggleRecording: _toggleRecording,
    );
  }

  @override
  void dispose() {
    _voiceService.dispose();
    super.dispose();
  }
}
