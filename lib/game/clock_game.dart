import 'package:flutter/material.dart';
import 'package:flame/position.dart';

import './cartridge.dart';
import './game.dart';

class ClockGameController extends FlameWatchGameController {


  ClockGameController(FlameWatchGameCartridge c): super(c) {
  }

  void onLeft() {
  }

  void onRight() {
  }

  void onTick() {
  }
}

Future<FlameWatchGame> loadClockGame(Size size) async {
  final cartridge = FlameWatchGameCartridge(
      gameName: 'ball example',
      background: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAABgCAYAAADVenpJAAAFXElEQVR4nO2cPXLkIBCF0dacZCdy4sihD7BVjnwC5858ks029wkc+QYON3LiaCbZg2gDF1MMaqCBpgXS+6pc5dFIgHiP5kdojAEAAAAASHD79DDHPoeOgX6Z7D8h4T5f3yf/e84x+5nCzyt2LmjLQkgXVxhOy/58fZ8oU1BpQPQ+mDjiGyMX2qnowTkftCHYwt3WnBsJQvgRoiad2jT2wO3Tw5yqK7I1hgSXMkIpEJ4PZyxmDMMAJd+3AOLzyRlrTbEwkRJW0wh7NQC3Jfvnc69hT9VCwATtkZqlUdcXtfxYQajruYM/zg1t1QRaYyq//haVWVqQ0EKQ28WkFpOoAnLPGRXNwTRVb4uWa1trzpTNb7lURIitFO5tgWjN5fJkBHDhrOpxBPNNERp45g54toj2jCqroh/vby6Fe/v4is4gSmmR5oi0NoKt4x+pEx/vb2b7Z4+9fXw1Ewji54lfWl82j+jFruiWluID/gyqZApIDcyDYlLiGwMDtMQdA6VmT/41LjlPYckuAOLr4w+AqdDOCff2HLfbjqV5dSAkvDEQvyWp2Q93ud4/hzNum6iTfSB+v6TMY3UNGiAmfOxC0A81JkhOA8G2iRoArX8MuNvsqGgfNADEH4vP1/cptGYQ0xJdwMZITRX9KHCgTlJu/Xt/kWTVSIsIsHMWBlih759W/OupDM3ww777mewCfBSf08/mu1JsASfnuPuZm5ZPTfml0+uCKwPY1r/yFixrAvu/8T7nlMU/N/f61umtzpUBOtl75+cpWQYbXaTS9NObve+MWeanaprUSu/FAKfjz8vBPe/OrWBVoUs5GHMtvjEQvRB37EIdl44+JL52J+f/4+m8LFxnL2umWlFOBVLnUukZZpqp9GJlbWqAGg1Zs4CcAnQWJfyKqS1bLD0qAljBuxTfGKEIQNGZEUKUTC9r8hLNR0K7ZiuB+K2gC7Np1PolGlnTpWBFE/RstqYrfrUmEBkDhBikGxiemje0m0UAiD8GwQhwPJ0X6wMxIHg/5LzYuzCAu1jANcHK4g+x4qYNtehDaZncFRy6uKMWX2MAzWmgOpS2vo5sA7h0tl8QBogQM8HxdMaOoK1DNdbj6XzpIg6hkwZ5PxD9fyUHY9LPjMHYvH18TaH3BJsuBIE+cc2QNQboLPwDAUYeBKL/FwBdwA5ZjAFCoV3rh6GALov3AgadBUgYchemjuk78hgACIAxwMZJ/dQfywDo/7eFawryYdC/21+shP7++Q1jDEBsDDDdPb9UDwBhhL7I0VTEABYYQZ9a/diDQI64fmFKrinJdw9INlSXS+VSGbSsfEQePnfPL7P0Pdr6X6XipMTfuvAakBUYE0iq0ktMAMHlmYxZTwxuvhC+HdWzAK44sX4sVIaehC8Z4I6A6DSQw4gVN4JBS1EzwIiVxambmvty0/fTiX1XmgcFmWluqKbQFFxSKK3xUGtzcfMYrlW6aHdfHFKiaQx8s5aCSzNZmx7Ft9REGy3hLcMawEfDEJQ4EgPEVNfLvb6EzRiAYo3lZqnBGzcPFzc/7r1v2gAWrbWO3kh1MXfPL/OQN1YClp5pmvRpPYPHz9dkLwTtrYIAAGC7bDKca+9uGplNVArGMeU0edjQ24MgCpjgm6xKaNXSSkO25mYWiXS4aWqas3klWzjLlBqip/LtaT+khhGqn/tLsJbwOWjugSzJtzSKslcCWwHx6/Kv3ViS/fRIipY7dCRZW3yqHJLdFGspeK1XvKidxJqGkBZfardQiJLyJiu3x+lSaxNoCx+6LofSMncnLhdpE7Qweuk7fZoLW8MawLLlzR4aj667vflceliVBGA4/gP3TdyzOah+nwAAAABJRU5ErkJggg==',
      sprites: {
        'bullet': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAQAAAAKCAYAAACT+/8OAAAAHUlEQVQImWNggID/UMzACGPAABMDDgDXQjygxBYAX5cJ/cXiJmoAAAAASUVORK5CYII=',
      },
      gameSprites: [
        GameSprite(id: 'bullet', x: 63, y: 16, spriteName: 'bullet', active: true),
      ],
      digitalDisplays: {
      },
  );

  final game = await FlameWatchGame.load(
      size, cartridge, ClockGameController(cartridge),
  );

  return game;
}
