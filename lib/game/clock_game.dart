import 'package:flutter/material.dart';
import 'package:flame/position.dart';
import 'package:intl/intl.dart';

import './cartridge.dart';
import './game.dart';

class ClockGameController extends FlameWatchGameController {

  final hourFormat = DateFormat('HH');
  final minutesFormat = DateFormat('mm');
  final monthFormat = DateFormat('MM');
  final dayFormat = DateFormat('dd');
  final weekDayFormat = DateFormat('EEE');

  ClockGameController(FlameWatchGameCartridge c): super(c) {}

  void onLeft() {}

  void onRight() {}

  void onTick() {
    findSprite('bullet').toggle();

    final date = DateTime.now();
    setDisplayText('hour', hourFormat.format(date));
    setDisplayText('minutes', minutesFormat.format(date));
    setDisplayText('month', monthFormat.format(date));
    setDisplayText('monthDay', dayFormat.format(date));
    setDisplayText('weekDay', weekDayFormat.format(date).toUpperCase());
  }
}

Future<FlameWatchGame> loadClockGame(Size size) async {
  final cartridge = FlameWatchGameCartridge(
      tickTime: 1.0,
      gameName: 'Clock',
      background: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAABgCAYAAADVenpJAAAFU0lEQVR4nO2csXLkIAyG8c0+yW2VZquUeYCbSZUnSJ9un+S66/MEqfIGKa9Kk2q3uQfxFRl2MBYgQJIB65vZydprg61fgJBxjFEURVEURUlwen6cY9uhfUq7TPZLSLjP1/fJ/x2zz25D+HXFjlV4WQnp4gqDadmfr+8T5BRQGSp6G0wY8Y2h69qh3gNzvMJDsIW7rTm3Jwjh9xA15dSWsQdOz49zylZgawwJTuUIpajweDCxmDEIByj5nQMVH09OrDXFuomUsJKOsFcHwLZk/3jsOeipWgh1An6oZmnQ+UUtP3Yh0PnY4A9zQ6M6gVRM5dtvZczSCwklgtwhJpVMgi4Qe0yvSAbTkN1WLde21pwpm99yoR4hlincW4Joy3R5sgdwwWT1MIL5ThEKPHMDnhGRnlFlGfrp4e52cW8fX9EZRCkcZfYItyNYG/9IHfj0cDfbj9339vHFJpCKnyd+qb1sHdGTXdEtnOIr+BlUyRQQCsyDYkLiG6MOwIkbA6VmT/45LjlPYcEhQMWXxw+Aoa4d093bY9xhO1bmYkdIeGNUfE5Ssx9sut4/BhO3TdDBPip+u6Scx+oadICY8LETlXaocYLkNFAZm6gDaOvvA+wyO6i3DzqAit8Xn6/vUyhnENNSh4DBSE0V/V4AdABt/ftBe4Cds3IAbf3j4Xf77jaqBzg9P876zt+YHNwN2/pHXoKlLFk4gLDw2qMsYbF1KtN7c4DL8edt555X5+6NgzFL8Y0RE71FB7L33eK1ofC1uzjfj5fr6nh9WXNJlw5Qo+EhfUjeBWQ4w2y+De0bnUoEyCg1ZVKXR0JtAyZxAJfMpd3WCex3423XGtg/v7ZM6vKqoOi92TKByIvzjcdtTLfH4Shvdj7uPhPZLoZi6GVNBe8seWR7A/vZ5F2/XMiHAJeBgkMMIdHtfvcvKTVvaLM5QKPiUwvgxzCT91vzBB3geLmu8gMxGhbchXpmMXnfofHeHRJEbJTzYu/KAdxkAdYJCsVPBYCpMlMGpTY2prxmGgGU9IG0TK4KDp3cQIvnaFEciaDNkkuQtr6OaAdwaWTNQC8OsCkxJzherroiaHSgxnq8XG9DxCF0UOPvB26agRuJgzHpZ8ZK37x9fE2h9wRZE0FKm2SvCbQ00v0rhPQYBOr4T4gOATtkFQOEunapfwylyOLqqrOAHRDTt7cYQMd/YjQGGJzUv/pDOYCO/2PhOgX4MOjf6ReqoL9/fo/mGMM9DDImHgNM9y/n6gBwQEfomhxNSRzAoo4gT61+6CAQI65/MSXnlNS7BygbqsvNuFAFnMbXngfP/ct5pr5Ha/9NDEcl/ujCSwAaMCYQldFLnEAFp2cyZjsxsPWq8HxUzwKw4sTGsdA1tCR8SYDbA6TTQAw9Gq4HBy1FzAF6NBbGNjX35ZbvlxP7rbQOCLDS3K4aQlJwSqGk4iFu58LW0V2rdJEevjCkRJMIfLNSwaWVbE2L4ltqehsp4S3dOoCPhENA4lAEiKmhF3t+CcM4AMQW6Waq4A1bh4tbH/beh3YAi1SuozVSQ8z9y3nu8sZK0NQzDMuY1jL6+HlJdiJobwZSFEUZlyG7c+nVTT0zhFE0jimH5WFDaw+CINQJvskyAldLK+2yJRezUJSDLVPSOdmNbMGkKSVET9Xb0npICUeofu5PwVbC5yC5BrKk3tJeFJ0J5ELFr6u/dmFJ9tMjKjhX6FCytfjQdVAOU6hU8FaveEEriSUdglp8qtVCIUquN2ncFqdL3E4gLXzovBxKr7k5cbFQOwGHo5e+0yeZ2OrWASwjL/aQeHTd7M3n0kJWUlG64z/cY9YitsZmGQAAAABJRU5ErkJggg==',
      sprites: {
        'bullet': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAQAAAAKCAYAAACT+/8OAAAAHUlEQVQImWNggID/UMzACGPAABMDDgDXQjygxBYAX5cJ/cXiJmoAAAAASUVORK5CYII=',
      },
      gameSprites: [
        GameSprite(id: 'bullet', x: 63, y: 20, spriteName: 'bullet', active: true),
      ],
      digitalDisplays: {
         'hour': GameDigitalDisplay(position: Position(42, 18), size: GameDigitalDisplaySize.MEDIUM, text: '--'),
         'minutes': GameDigitalDisplay(position: Position(70, 18), size: GameDigitalDisplaySize.MEDIUM, text: '--'),
         'month': GameDigitalDisplay(position: Position(26, 48), size: GameDigitalDisplaySize.SMALL, text: '--'),
         'monthDay': GameDigitalDisplay(position: Position(48, 48), size: GameDigitalDisplaySize.SMALL, text: '--'),
         'weekDay': GameDigitalDisplay(position: Position(74, 48), size: GameDigitalDisplaySize.SMALL, text: '--'),
      },
  );

  final game = await FlameWatchGame.load(
      size, cartridge, ClockGameController(cartridge),
  );

  return game;
}
