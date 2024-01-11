import 'package:flutter/material.dart';
import 'package:zetexa_assignment/presentation/general/toast.dart';

// ignore: must_be_immutable
class OptionsSelector extends StatefulWidget {
  OptionsSelector(
      {required this.options,
      required this.onChanged,
      Key? key,
      this.selectedOption,
      this.fitToWidth = false,
      this.optionsConstraints,
      this.sizeFactor = 1.0,
      this.fontSizeFactor = 1.0,
      this.optionsSpacing = 1.0,
      this.paddingFactor = 1.0,
      this.optionsHeightFactor = 1.0,
      this.optionsWidthFactor = 1.0,
      this.height,
      this.selectedTabcolor = Colors.blue,
      this.optionsBGColor,
      this.optionsTextColor,
      this.outerBorderRadius = 5,
      this.optionsRadius = 5,
      this.unselectedOptionTextColor,
      this.disableOptionClick = false,
      this.disableOptionMessage = '',
      this.optionsTitle = ''})
      : super(key: key);

  @override
  State<OptionsSelector> createState() => _OptionsSelectorState();

  List<String> options;
  String? selectedOption;
  String? optionsTitle;
  String disableOptionMessage;
  bool disableOptionClick, fitToWidth;
  BoxConstraints? optionsConstraints;
  double? height;
  double sizeFactor;
  double fontSizeFactor;
  double optionsHeightFactor;
  double optionsWidthFactor;
  Color? optionsBGColor;
  Color? optionsTextColor;
  Color? selectedTabcolor;
  double optionsSpacing;
  double outerBorderRadius;
  Color? unselectedOptionTextColor;
  double optionsRadius;
  double paddingFactor;
  final ValueChanged<String> onChanged;
}

class _OptionsSelectorState extends State<OptionsSelector> {
  late bool isListEmpty;
  ScrollController scrollController = ScrollController();
  List<String> optn = [];

  @override
  void initState() {
    super.initState();
    isListEmpty = widget.options.isEmpty;
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.optionsBGColor ?? const Color(0xffEEEEEE),
            borderRadius:
                BorderRadius.all(Radius.circular(widget.outerBorderRadius)),
          ),
          child: widget.fitToWidth
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widget.options
                      .map((option) => Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: widget.selectedOption == option
                                      ? widget.selectedTabcolor
                                      : null,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(widget.optionsRadius))),
                              child: InkWell(
                                onTap: widget.disableOptionClick
                                    ? () {
                                        if (widget
                                            .disableOptionMessage.isNotEmpty) {
                                          customTextToast(
                                              widget.disableOptionMessage);
                                        }
                                      }
                                    : () {
                                        setState(() {
                                          widget.selectedOption = option;
                                        });
                                        widget.onChanged(option);
                                      },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10 *
                                        widget.sizeFactor *
                                        widget.optionsHeightFactor,
                                    horizontal: 10 *
                                        widget.sizeFactor *
                                        widget.optionsSpacing *
                                        widget.optionsWidthFactor,
                                  ),
                                  child: Text(
                                    option,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: widget.selectedOption == option
                                            ? Colors.white
                                            : widget.optionsTextColor ??
                                                Colors.black,
                                        fontSize: 16 *
                                            widget.sizeFactor *
                                            widget.fontSizeFactor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                )
              : SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  controller: scrollController,
                  padding: EdgeInsets.all(
                      4 * widget.sizeFactor * widget.paddingFactor),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Visibility(
                        visible: widget.optionsTitle != '',
                        child: Padding(
                          padding: EdgeInsets.only(
                              left:
                                  5 * widget.sizeFactor * widget.paddingFactor,
                              right: 13 *
                                  widget.sizeFactor *
                                  widget.paddingFactor),
                          child: Text(
                            widget.optionsTitle!,
                            style: TextStyle(
                                fontSize: 14 * widget.sizeFactor,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ...widget.options
                          .map((option) => Container(
                                constraints: widget.optionsConstraints,
                                decoration: BoxDecoration(
                                    color: widget.selectedOption == option
                                        ? widget.selectedTabcolor
                                        : null,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(widget.optionsRadius))),
                                child: Center(
                                  child: InkWell(
                                    onTap: widget.disableOptionClick
                                        ? () {
                                            if (widget.disableOptionMessage
                                                .isNotEmpty) {
                                              customTextToast(
                                                  widget.disableOptionMessage);
                                            }
                                          }
                                        : () {
                                            setState(() {
                                              widget.selectedOption = option;
                                            });
                                            widget.onChanged(option);
                                          },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10 * widget.sizeFactor,
                                        horizontal: 10 *
                                            widget.sizeFactor *
                                            widget.optionsSpacing,
                                      ),
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                            color: widget.selectedOption ==
                                                    option
                                                ? Colors.white
                                                : widget.unselectedOptionTextColor ??
                                                    Colors.white,
                                            fontSize: 16 *
                                                widget.sizeFactor *
                                                widget.fontSizeFactor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
