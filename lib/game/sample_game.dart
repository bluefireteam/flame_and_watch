import 'package:flutter/material.dart';

import './cartridge.dart';
import './game.dart';

class BallGameController extends FlameWatchGameController {

  BallGameController(FlameWatchGameCartridge c): super(c);

  int pos = 1;

  void onLeft() {
    if (pos - 1 >= 1) {
      findSprite('boat$pos').active = false;
      pos--;
      findSprite('boat$pos').active = true;
    }
  }

  void onRight() {
    if (pos + 1 <= 3) {
      findSprite('boat$pos').active = false;
      pos++;
      findSprite('boat$pos').active = true;
    }
  }

  void onTick() {
    findSprite('big-chopper-propeller').toggle();
    findSprite('small-chopper-propeller').toggle();
  }
}

Future<FlameWatchGame> loadSampleGame(Size size) async {
  final cartridge = FlameWatchGameCartridge(
      gameName: 'ball example',
      background: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAABgCAYAAADVenpJAAAEHUlEQVR4nO2cPZLjIBCF0ZZPso4mceRwDrBVjuYEzp35JJtt7hNM5BtMuJGTieRkD6KNUGHUQIMA8fO+qqkay0jIvEfT9MgjBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALrjcD5NttemY6BcBvmLSbjH7T7o73OOydcUel+2tiAtCyFVVGE4M/txuw+UKahrQPQyGDjiCxEvtFPRg9MepME4w9XZ7BsJTOgRYs111l6jBw7n0+QaK3I2mgSPZYRQIDwfTi4mBMMAIe+nAOLz8cm1BluYcAmb0wi9GoA7k/X23HPYWzUTMEF6Yu3SqPODZr7tRqjzuckf5wO1aoJcOZU+fovBDL0RUyFIXWJcxSTqBrltaiVnMk2N22Lmytnqs2XTZy4VEWyVwt4KRFuWy50RQIVT1eMIppvClHj6JjwtkntH5TXQH+9v8819fn1bdxChpLhmjaQ2ghzjH66GH+9vk/yRxz6/vpMJBPH9xA8dL9mH9WRVdElK8QF/BxWyBaQSc6OYlPhCwAApUXMg1+5JP0fF56+w5BIA8fOjJ8BUaOeEe9lGXbZt13w5YBJeCIifEtfuh1uu19tw8raBaqwD8cvFZR6pq9EANuFtJ4JyWGMC5zYQtI3VAJj9dcB9zI6K9kYDQPy6eNzug6lmYNMSS0BjuLaKehQgDYDZ3w+IAJ2zMABmf3voYV99zYoAh/Npwnf+2mSnvpCzv+VHsMArLwaA8O3hqvTOBhj3P+eDPT+d2xs7IV7FFwKi14yu3aj8vh+fi/b4smYDrNEwigFUYIa8rNUvugEkMEJ6YmiXrBKIukF6YkyypKVgmCA9a02QbAkQAsvAVvhomiwCQPw6MEaA/fhc1AdsQPCy4EaBnX5ALRZwTQDxy4Mq+lBaOp8KNp0M0cuH0lbXkW0AFTwzUA82E+zHJ54Iah1qsu7H57xE7EyN8P3APvBeAmCAOjF9T3CxCwDt4/1MoASzvz2QBHYOloAOWeQAptCe6x9Dgbyouu70A6A9bPoiB+gc5ACN4/pXfywDYP1vC9UUZCXw3+EX60J///yGMSrAlgMMx8t1dQIII5SFj6ZRDCCBEfKzVj92EsgRV7+ZkHNC+u2BmBNVZR5cqoOUg4/Iw+d4uU6xP6Mc/00GLpb4rQufA3IAbQLFGvQQE0Dw+AxCbCcGt18In47VuwCuOLZ1zHQPJQkfkuDWQNRtIIcaB64Gg4aSzQA1DhZnbNZ8LvX6+nVs74X2QUF26huqKXIKHlOoXPlQanNx+6huVqrkXr44uETLkfh6lYJDO9maEsWXrIk2uYSXVGsAnRyGoMSJkSC6ll7u+SE0YwCKLcrNsZI3bh8qan/cz960ASS5ah2l4VpijpfrVOUHCwGlZ5oka1rJ4M/Pr3gXgnoboNb5D65JAVh+6/ZFAAAAAElFTkSuQmCC',
      sprites: {
        'chopper': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB8AAAASCAYAAACjMAXnAAAAgElEQVRIicWTUQ7AIAhDwez+V2ZfZAsRUhWkPxpN4WmVaC5x1lM1iupC8E9g0jmn4Ez0LxzRIgCe3/XqtZ9mHPndPTTzEjibeQYAGiWNhaLp4qbmTORnzvRdHzJflUTNb0iUvCX3zpPj36Kit30wNwDgR7oLc3wIMWO1zy1U4nsBJgQcD9rdBz0AAAAASUVORK5CYII=',
        'big-propeller': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAABCAYAAAAB3PQ6AAAAFUlEQVQImWNkYGD4z4AdMCKxsaoBAE5NAgFkEgjsAAAAAElFTkSuQmCC',
        'small-propeller': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA0AAAABCAYAAAAFKSQHAAAAFElEQVQImWNkYGD4z4AJGJHYGPIAQkUCAVYMpysAAAAASUVORK5CYII=',
        'boat1': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAMCAYAAAB4MH11AAAAVUlEQVQ4jWNkgID/DKiAkYFKgBGL4VS1hIkahgxvC2DhTLNIRga4IpsigB5E/9FoqlsAMxxf8iUF/IcT+BRQYPh/QhntPxY2KYARVyqihiWMDAwMDACr+hMHQNzxaQAAAABJRU5ErkJggg==',
        'boat2': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAPCAYAAAD+pA/bAAAAXUlEQVQ4jd2TwQoAIAhDtf//ZztEYaFiuC69q7DBNpkGQjtMINgQh5o0hMjfBjPnZyVrvLJLnBFZJiVjHcWLuYonLIHhjbhYj6aLjx4xA58rgop7B0Q8i8yK4EBNOi6DFwS0AzCLAAAAAElFTkSuQmCC',
        'boat3': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB0AAAAMCAYAAACeGbYxAAAAXUlEQVQ4je2SwQ7AIAhDX5f9/y+zqyHiZOBt72KMpCW1IsbcXYvZFJGQN2w1vjpEftOI1R8dK9IbUaFK7MRrw9myhJyQj3D2ZpO5DDYK7VIyBLg/ilZiVqa9HQjgAWIgDw41B4qcAAAAAElFTkSuQmCC',
      },
      gameSprites: [
        GameSprite(
            id: 'chopper',
            x: 90,
            y: 1,
            spriteName: 'chopper',
            active: true,
        ),
        GameSprite(
            id: 'big-chopper-propeller',
            x: 88,
            y: 1,
            spriteName: 'big-propeller',
            active: true,
        ),
        GameSprite(
            id: 'small-chopper-propeller',
            x: 105,
            y: 2,
            spriteName: 'small-propeller',
            active: false,
        ),
        GameSprite(
            id: 'boat1',
            x: 18,
            y: 65,
            spriteName: 'boat1',
            active: true,
        ),
        GameSprite(
            id: 'boat2',
            x: 50,
            y: 65,
            spriteName: 'boat2',
            active: false,
        ),
        GameSprite(
            id: 'boat3',
            x: 77,
            y: 65,
            spriteName: 'boat3',
            active: false,
        ),
      ]
  );

  final game = await FlameWatchGame.load(
      size, cartridge, BallGameController(cartridge),
  );

  return game;
}
