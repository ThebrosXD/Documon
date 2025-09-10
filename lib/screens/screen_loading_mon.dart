import 'package:documon/screens/screen_menu_mon.dart';
import 'package:documon/styles/colors_mon.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ScreenLoadingMon extends StatefulWidget {
  const ScreenLoadingMon({super.key});

  @override
  State<ScreenLoadingMon> createState() => _ScreenLoadingMonState();
}

class _ScreenLoadingMonState extends State<ScreenLoadingMon>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _audioMusic = AudioPlayer();
  late AnimationController _pokeAnimation;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _soundMusic();
    animaPokeBallControllerJ();
    animationPokeBallJump();
  }

  @override
  void dispose() {
    _pokeAnimation.dispose();
    _audioMusic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsMon.primary,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "DocuMon",
              style: TextStyle(
                color: Colors.amberAccent,
                fontSize: 54,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    blurRadius: 40.0,
                    color: Colors.black,
                    offset: Offset(4.0, 1.0),
                  ),
                ],
                fontFamily: 'BespokeSlab'
              ),
              textAlign: TextAlign.center,
            ),
            Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/International_Pok%C3%A9mon_logo.svg/640px-International_Pok%C3%A9mon_logo.svg.png",
              scale: 4.5,
            ),
            SizedBox(height: 64),
            GestureDetector(
              onTap: () {
                _soundMusicStop();
                _soundEnter();
                _startAnimation();
                Future.delayed(Duration(seconds: 3), () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => ScreenMenuMon(),
                    ), (Route<dynamic> route) => false,
                  );
                });
              },
              child: AnimatedBuilder(
                animation: _pokeAnimation,
                builder: (context, child) => Transform.translate(
                  offset: Offset(0, _animation.value),
                  child: Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Pokebola-pokeball-png-0.png/960px-Pokebola-pokeball-png-0.png",
                    scale: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _soundMusic() async {
    await _audioMusic.play(AssetSource("audios/PokemonMusic.wav"));
    await _audioMusic.setVolume(1);
    await _audioMusic.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> _soundMusicStop() async {
    await _audioMusic.stop();
  }

  Future<void> _soundEnter() async {
    final player = AudioPlayer();
    await player.play(AssetSource("audios/pokeEnter.wav"));
    await player.setVolume(1);
  }

  void animaPokeBallControllerJ() {
    _pokeAnimation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }

  void animationPokeBallJump() {
    _animation = Tween<double>(
      begin: 0,
      end: -20,
    ).animate(CurvedAnimation(parent: _pokeAnimation, curve: Curves.bounceIn));
  }

  void _startAnimation() {
    _pokeAnimation.forward().then((_) => _pokeAnimation.repeat(reverse: true));
  }
}
