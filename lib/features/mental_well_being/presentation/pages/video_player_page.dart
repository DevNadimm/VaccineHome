import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void _playPause() => isPlaying ? _controller.pause() : _controller.play();

  void _seekBackward() {
    final newPosition = _controller.value.position - const Duration(seconds: 10);
    _controller.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
  }

  void _seekForward() {
    final newPosition = _controller.value.position + const Duration(seconds: 10);
    _controller.seekTo(newPosition < totalDuration ? newPosition : totalDuration);
  }

  void _seekTo(Duration position) {
    _controller.seekTo(position);
    setState(() {
      currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
        leading: const AppBarBackBtn(),
      ),
      body: Column(
        children: [
          _buildVideoPlayer(context),
          _buildProgressBar(context),
          _buildControlBar(),
          _buildVideoInfo(),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer(BuildContext context) {
    return Padding(
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
            topActions: const [],
            bottomActions: const [],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            _formatDuration(currentPosition),
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: AppColors.secondaryFontColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.primaryColorTransparent,
                inactiveTrackColor: AppColors.cardColorBold,
                trackHeight: 6.0,
                thumbColor: AppColors.primaryColor,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                overlayColor: Colors.red.withAlpha(32),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              ),
              child: Slider(
                min: 0,
                max: totalDuration.inMilliseconds.toDouble(),
                value: currentPosition.inMilliseconds.clamp(0, totalDuration.inMilliseconds).toDouble(),
                onChanged: (value) {
                  final newPosition = Duration(milliseconds: value.toInt());
                  _seekTo(newPosition);
                },
              ),
            ),
          ),
          Text(
            _formatDuration(totalDuration),
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: AppColors.secondaryFontColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(icon: HugeIcons.strokeRoundedGoBackward10Sec, onPressed: _seekBackward),
          _buildControlButton(
            icon: isPlaying ? HugeIcons.strokeRoundedPause : HugeIcons.strokeRoundedPlay,
            onPressed: _playPause,
            isMainButton: true,
          ),
          _buildControlButton(icon: HugeIcons.strokeRoundedGoForward10Sec, onPressed: _seekForward),
        ],
      ),
    );
  }

  Widget _buildVideoInfo() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
          size: 26,
        ),
        padding: const EdgeInsets.all(12),
      ),
    );
  }
}
