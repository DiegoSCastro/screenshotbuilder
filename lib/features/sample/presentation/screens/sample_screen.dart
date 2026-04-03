import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/ui_utils/snack_bar.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../../../common/widgets/generic_button.dart';
import '../../../../common/widgets/loading.dart';
import '../../../../core/extensions/theme_ext.dart';
import '../../../../core/theme/theme_service.dart';
import '../../domain/entities/user_entity.dart';
import '../blocs/sample_bloc/sample_bloc.dart';
import '../widgets/header_section.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  final TextEditingController _textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Trigger initial data fetch
    context.read<SampleBloc>().add(const SampleEvent.getCliDetails());
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Scaffold(
      body: BlocListener<SampleBloc, SampleState>(
        listener: (context, state) {
          if (state.userResponse != null) {
            _showGreetingDialog(context, state.userResponse!);
            context.read<SampleBloc>().add(
              const SampleEvent.clearUserResponse(),
            );
          }
          if (state.userError != null) {
            AppSnackBar.showSnackBar(
              context,
              message: state.userError!,
              isError: true,
            );
          }
          if (state.cliError != null) {
            AppSnackBar.showSnackBar(
              context,
              message: state.cliError!,
              isError: true,
            );
          }
        },
        child: BlocBuilder<SampleBloc, SampleState>(
          builder: (context, state) {
            return Loading(
              isLoading: state.isUserLoading || state.isCliLoading,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () {
                                      ThemeService.toggleTheme();
                                    },
                                    icon: Icon(
                                      context.isDarkTheme
                                          ? Icons.light_mode
                                          : Icons.dark_mode,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 64),
                                const HeaderSection(),
                                const SizedBox(height: 64),
                                CustomTextField(
                                  controller: _textController,
                                  hintText: "Enter Your Name",
                                  label: "Developer Name",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your name";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "This project is initialized with easy_init_cli. This sample feature demonstrates API call flow and UI styling. Once you understand the flow, you can remove this feature and start implementing your own.",
                                  textAlign: TextAlign.center,
                                  style: context.bodySmall(
                                    color: appColors?.subtext ?? Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GenericButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<SampleBloc>().add(
                              SampleEvent.getUser(_textController.text),
                            );
                          }
                        },
                        text: "Get Started",
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'easy_init_cli : v${state.cliDetails?.latestVersion ?? ''}',
                        style: context.bodySmall(color: appColors?.subtext),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  void _showGreetingDialog(BuildContext context, UserEntity data) {
    final appColors = context.appColors;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: appColors?.surfaceColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            _getGreeting(),
            style: context.headlineSmall(
              color: appColors?.primary ?? Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Message: ${data.message ?? 'No Message'}",
                style: context.bodyMedium(
                  color: appColors?.onSurface ?? Colors.black87,
                ),
              ),
              if (data.serverInfo != null) ...[
                const SizedBox(height: 8),
                Text(
                  "Server: ${data.serverInfo?.platform}",
                  style: context.labelSmall(
                    color: appColors?.subtext ?? Colors.grey,
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: context.labelLarge(
                  color: appColors?.primary ?? Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
