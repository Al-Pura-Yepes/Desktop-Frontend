import 'package:al_pura_frontend/feature/reservation/domain/model/status.dart';
import 'package:flutter/material.dart';

class StateButton extends StatelessWidget {
  final Status status;
  final Color color;
  final Color secondaryColor;
  final Color textColor;
  final Function? onChange;
  final Function? revertState;

  const StateButton({
    super.key,
    required this.status,
    this.color = Colors.blue,
    this.secondaryColor = Colors.black38,
    this.textColor = Colors.white,
    this.onChange,
    this.revertState
  });

  bool existForward() {
    switch (status) {
      case Status.pending:
        return true;
      case Status.ready:
        return false;
      case Status.completed:
        return false;
    }
  }

  bool existBack() {
    switch (status) {
      case Status.pending:
        return false;
      case Status.ready:
        return true;
      case Status.completed:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Row(
        children: [
          existBack() ? GestureDetector(
            onTap: () {
              if (revertState != null) {
                revertState!();
              }
            },
            child: Container(
                width: 50,
                height: 40,
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)
                    )
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,)
            ),
          ) : const SizedBox.shrink(),
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                    topLeft: status == Status.pending ? const Radius.circular(5) : const Radius.circular(0),
                    topRight: status == Status.pending ? const Radius.circular(0) : const Radius.circular(5),
                    bottomLeft: status == Status.pending ? const Radius.circular(5) : const Radius.circular(0),
                    bottomRight: status == Status.pending ? const Radius.circular(0) : const Radius.circular(5),
                )
              ),
              child: Text(statusToString(status), style: textTheme.titleSmall!.copyWith(color: textColor),)
            ),
          ),
          existForward() ? GestureDetector(
            onTap: () {
              if (onChange != null) {
                onChange!();
              }
            },
            child: Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)
                  )
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,)
            ),
          ) : const SizedBox.shrink()
        ],
      ),
    );
  }
}
