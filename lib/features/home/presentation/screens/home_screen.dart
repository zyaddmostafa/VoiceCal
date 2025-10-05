import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/speech_to_text_service.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/helpers/custom_snackbar.dart';
import '../../data/models/meal_data.dart';
import '../../data/repo/home_repo.dart';
import '../../data/services/meal_request_helper.dart';
import '../../data/services/voice_meal_logging_service.dart';
import '../cubit/home_cubit.dart';
import '../widgets/home_body_content.dart';
import '../widgets/voice_recording_fab.dart';

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
  bool _isLoadingMeal = false;

  @override
  void initState() {
    super.initState();
    _initializeVoiceService();
  }

  void _initializeVoiceService() {
    _voiceService = VoiceMealLoggingService(getIt<SpeechToTextService>());

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
    if (request == null) {
      CustomSnackbar.showError(context, 'User not authenticated');

      return;
    }
    context.read<HomeCubit>().getMealData(request: request);
  }

  void _onMealLogged(MealData mealData) {
    setState(() => _loggedMeals.insert(0, mealData));
    CustomSnackbar.showSuccess(context, 'Meal logged successfully!');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeLoading) {
          setState(() => _isLoadingMeal = true);
        } else if (state is HomeSuccess) {
          setState(() => _isLoadingMeal = false);
          _onMealLogged(state.mealData);
        } else if (state is HomeError) {
          setState(() => _isLoadingMeal = false);
          CustomSnackbar.showError(
            context,
            state.apiErrorModel.message ?? 'Failed to log meal',
          );
        }
      },
      child: Scaffold(
        body: HomeBodyContent(
          loggedMeals: _loggedMeals,
          isLoadingMeal: _isLoadingMeal,
        ),
        floatingActionButton: VoiceRecordingFab(
          isRecording: _voiceService.isRecording,
          onPressed: _toggleRecording,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  @override
  void dispose() {
    _voiceService.dispose();
    super.dispose();
  }
}
