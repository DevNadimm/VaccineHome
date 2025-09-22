import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;
  final String publishedDate;

  const VideoPlayerPage({
    super.key,
    required this.videoUrl,
    required this.videoTitle,
    required this.publishedDate,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;
  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
        hideControls: true,
        controlsVisibleAtStart: false,
        showLiveFullscreenButton: false,
      ),
    );

    _controller.addListener(() {
      if (mounted) {
        setState(() {
          isPlaying = _controller.value.isPlaying;
          currentPosition = _controller.value.position;
          totalDuration = _controller.metadata.duration;
        });
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void _playPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  void _seekBackward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition - const Duration(seconds: 10);
    _controller.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
  }

  void _seekForward() {
    final currentPosition = _controller.value.position;
    final totalDuration = _controller.metadata.duration;
    final newPosition = currentPosition + const Duration(seconds: 10);
    _controller.seekTo(newPosition < totalDuration ? newPosition : totalDuration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Video Player'
        ),
        leading: const AppBarBackBtn()
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                color: AppColors.backgroundColor,
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: false,
                  progressIndicatorColor: Colors.transparent,
                  topActions: const [],
                  bottomActions: const [],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(currentPosition),
                      style: const TextStyle(
                        color: AppColors.secondaryFontColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: LinearPercentIndicator(
                        lineHeight: 6.0,
                        percent: totalDuration.inMilliseconds > 0 ? (currentPosition.inMilliseconds / totalDuration.inMilliseconds).clamp(0.0, 1.0) : 0.0,
                        backgroundColor: AppColors.cardColorBold,
                        progressColor: AppColors.primaryColor,
                        animation: false,
                        barRadius: const Radius.circular(3),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _formatDuration(totalDuration),
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: AppColors.secondaryFontColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(
                  icon: HugeIcons.strokeRoundedGoBackward10Sec,
                  onPressed: _seekBackward,
                ),
                _buildControlButton(
                  icon: isPlaying
                      ? HugeIcons.strokeRoundedPause
                      : HugeIcons.strokeRoundedPlay,
                  onPressed: _playPause,
                  isMainButton: true,
                ),
                _buildControlButton(
                  icon: HugeIcons.strokeRoundedGoForward10Sec,
                  onPressed: _seekForward,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.videoTitle,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: AppColors.primaryFontColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Published: ${widget.publishedDate}',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: AppColors.secondaryFontColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    bool isMainButton = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isMainButton ? AppColors.primaryColor : Colors.transparent,
      ),
      child: IconButton(
        splashColor: Colors.transparent,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: isMainButton ? Colors.white : AppColors.secondaryFontColor,
          size: isMainButton ? 26 : 26,
        ),
        padding: EdgeInsets.all(isMainButton ? 12 : 12),
      ),
    );
  }
}
