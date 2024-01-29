import 'package:presentation/common/widgets/svg_viewer.dart';
import 'package:presentation/import.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? errorText;
  final ValueChanged<String?>? onChanged;
  const CustomTextField({super.key, this.labelText, this.hintText, this.controller, this.obscureText = false, this.errorText, this.onChanged});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  late ValueNotifier<bool> hasClearNotifier;
  late TextEditingController _controller;
  late ValueNotifier<bool> _obscureNotifier;

  @override
  void initState() {
    _focusNode = FocusNode();
    hasClearNotifier = ValueNotifier(false);
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextEditingListener);
    _obscureNotifier = ValueNotifier(widget.obscureText);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    if (oldWidget.controller != widget.controller) {
      _controller = widget.controller ?? TextEditingController();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _obscureNotifier.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _onTap,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.inputField,
                border: Border.all(width: 1, color: AppColors.inputBorder),
                borderRadius: BorderRadius.circular(AppSizings.radius)),
            padding: const EdgeInsets.symmetric(vertical: AppSizings.padding + 2, horizontal: AppSizings.paddingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.labelText != null && widget.labelText != '')
                  Text(widget.labelText!, style: const TextStyle(fontSize: 12, color: AppColors.labelInputColor)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: _obscureNotifier,
                      builder: (context, obscure, child) => Expanded(
                        child: TextFormField(
                          focusNode: _focusNode,
                          controller: _controller,
                          obscureText: obscure,
                          obscuringCharacter: '•',
                          onChanged: widget.onChanged,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            hintText: widget.hintText,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    ValueListenableBuilder<bool>(
                      valueListenable: hasClearNotifier,
                      builder: (context, hasClear, child) => InkWell(
                        onTap: _onClearText,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.transparent,
                          child: AnimatedSwitcher(
                            duration: const ShortDuration(),
                            transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(scale: animation, child: child),
                            child: !hasClear ? const SizedBox.shrink() : const SvgViewer(AppIcons.icClearText),
                          ),
                        ),
                      ),
                    ),
                    if (widget.obscureText) ...[
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: _onToggleVisibility,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.transparent,
                          child: ValueListenableBuilder<bool>(
                            valueListenable: _obscureNotifier,
                            builder: (context, obscure, child) => AnimatedSwitcher(
                              duration: const ShortDuration(),
                              transitionBuilder: (Widget child, Animation<double> animation) => FadeTransition(opacity: animation, child: child),
                              child: SvgViewer(!obscure ? AppIcons.icVisibilityOn : AppIcons.icVisibilityOff, key: ValueKey('Visibility_$obscure')),
                            ),
                          ),
                        ),
                      )
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
        if (widget.errorText != null && widget.errorText != '') ...[
          const SizedBox(height: AppSizings.paddingSm),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SvgViewer(AppIcons.icErrorMessage),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  widget.errorText!,
                  style: const TextStyle(color: AppColors.errorTextColor, fontSize: AppSizings.tXs, fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _onTap() {
    if (_focusNode.hasFocus) return;
    _focusNode.requestFocus();
  }

  void _onTextEditingListener() {
    hasClearNotifier.value = _controller.text.trim().isNotEmpty;
  }

  void _onClearText() {
    _controller.clear();
    _focusNode.unfocus();
  }

  void _onToggleVisibility() {
    _obscureNotifier.value = !_obscureNotifier.value;
  }
}
