import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/time_list_cubit.dart';

class TimePickerListWidget extends StatelessWidget {
  const TimePickerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeListCubit, List<TextEditingController>>(
      builder: (context, pickTimes) {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: pickTimes.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return TextFormField(
              controller: pickTimes[index],
              readOnly: true,
              onTap: () async {
                final TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  pickTimes[index].text = time.format(context);
                }
              },
              decoration: InputDecoration(
                hintText: 'Select time #${index + 1}',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (index == pickTimes.length - 1) {
                      context.read<TimeListCubit>().addTime();
                    } else {
                      context.read<TimeListCubit>().removeTime(index);
                    }
                  },
                  icon: Icon(
                    index == pickTimes.length - 1
                        ? HugeIcons.strokeRoundedAdd01
                        : HugeIcons.strokeRoundedDelete02,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Time #${index + 1} is required';
                }
                return null;
              },
            );
          },
        );
      },
    );
  }
}
