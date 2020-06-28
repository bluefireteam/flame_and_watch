import 'package:flutter/material.dart';
import 'package:flame/position.dart';
import 'dart:math';

import './cartridge.dart';
import './game.dart';

class ParachuteGameController extends FlameWatchGameController {

  Random random = Random();

  ParachuteGameController(FlameWatchGameCartridge c): super(c) {
    setDisplayText('score', '0');
  }

  // to get a 80% call with 0.8
  bool rollChance(double possibility) => random.nextDouble() <= possibility;
  int rollLane() => random.nextInt(3) + 1;

  int pos = 1;
  int score = 0;
  int miss = 0;

  int difficultProgression = 0;
  double difficult = 0.2;

  bool newFalling = false;

  bool firstLane1 = false;
  bool firstLane2 = false;
  bool firstLane3 = false;
  int firstLaneDrowing = -1;

  bool secondLane1 = false;
  bool secondLane2 = false;
  bool secondLane3 = false;
  int secondLaneDrowing = -1;

  bool thirdLane1 = false;
  bool thirdLane2 = false;
  bool thirdLane3 = false;
  int thirdLaneDrowing = -1;

  void onLeft() {
    if (pos - 1 >= 1) {
      pos--;
      boatBlock();
    }
  }

  void onRight() {
    if (pos + 1 <= 3) {
      pos++;
      boatBlock();
    }
  }

  void onTick() {
    propellerBlock();
    updateLanesBlock();
    drowingBlock();
  }

  void propellerBlock() {
    findSprite('big-chopper-propeller').toggle();
    findSprite('small-chopper-propeller').toggle();
  }

  void boatBlock() {
    findSprite('boat1').active = pos == 1;
    findSprite('boat2').active = pos == 2;
    findSprite('boat3').active = pos == 3;
  }

  void drowingBlock() {
    findSprite('drowing-1-1').active = firstLaneDrowing == 1;
    findSprite('drowing-1-2').active = firstLaneDrowing == 2;

    findSprite('drowing-2-1').active = secondLaneDrowing == 1;
    findSprite('drowing-2-2').active = secondLaneDrowing == 2;

    findSprite('drowing-3-1').active = thirdLaneDrowing == 1;
    findSprite('drowing-3-2').active = thirdLaneDrowing == 2;

    if (firstLaneDrowing == 1) {
      firstLaneDrowing = 2;
    } else if (firstLaneDrowing == 2) {
      firstLaneDrowing = -1;
    }

    if (secondLaneDrowing == 1) {
      secondLaneDrowing = 2;
    } else if (secondLaneDrowing == 2) {
      secondLaneDrowing = -1;
    }

    if (thirdLaneDrowing == 1) {
      thirdLaneDrowing = 2;
    } else if (thirdLaneDrowing == 2) {
      thirdLaneDrowing = -1;
    }
  }

  void increaseScoreBlock() {
    score++;
    difficultProgression++;

    if (difficultProgression == 10) {
      difficultProgression = 0;
      difficult = min(1.0, difficult + 0.1);
    }

    setDisplayText('score', '$score');
    sfx('rescue.wav');
  }

  void resetScoreBlock() {
    score = 0;
    difficultProgression = 0;
    difficult = 0.1;
    setDisplayText('score', '$score');
    sfx('gameover.wav');
  }

  void missBlock() {
    miss++;

    if (miss == 4) {
      miss = 0;
      resetScoreBlock();
    }

    findSprite('miss-marker-1').active = miss >= 1;
    findSprite('miss-marker-2').active = miss >= 2;
    findSprite('miss-marker-3').active = miss >= 3;
    sfx('drown.wav');
  }

  void updateLanesBlock() {
    if (firstLane3) {
      firstLane3 = false;
      if (pos == 1) {
        increaseScoreBlock();
      } else {
        firstLaneDrowing = 1;
        missBlock();
      }
    }
    if (firstLane2) {
      firstLane2 = false;
      firstLane3 = true;
    }
    if (firstLane1) {
      firstLane1 = false;
      firstLane2 = true;
    }

    if (secondLane3) {
      secondLane3 = false;
      if (pos == 2) {
        increaseScoreBlock();
      } else {
        secondLaneDrowing = 1;
        missBlock();
      }
    }
    if (secondLane2) {
      secondLane2 = false;
      secondLane3 = true;
    }
    if (secondLane1) {
      secondLane1 = false;
      secondLane2 = true;
    }

    if (thirdLane3) {
      thirdLane3 = false;
      if (pos == 3) {
        increaseScoreBlock();
      } else {
        thirdLaneDrowing = 1;
        missBlock();
      }
    }
    if (thirdLane2) {
      thirdLane2 = false;
      thirdLane3 = true;
    }
    if (thirdLane1) {
      thirdLane1 = false;
      thirdLane2 = true;
    }

    // If there is already a new fall, we need to choose to which lane it will be
    if (newFalling) {
      final newLane = rollLane();
      if (newLane == 1)
        firstLane1 = true;
      if (newLane == 2)
        secondLane1 = true;
      if (newLane == 3)
        thirdLane1 = true;

      newFalling = false;
    } else if(rollChance(difficult)) {
      newFalling = true;
    }

    findSprite('falling-start').active = newFalling;

    findSprite('falling-1-1').active = firstLane1;
    findSprite('falling-1-2').active = firstLane2;
    findSprite('falling-1-3').active = firstLane3;

    findSprite('falling-2-1').active = secondLane1;
    findSprite('falling-2-2').active = secondLane2;
    findSprite('falling-2-3').active = secondLane3;

    findSprite('falling-3-1').active = thirdLane1;
    findSprite('falling-3-2').active = thirdLane2;
    findSprite('falling-3-3').active = thirdLane3;
  }
}

Future<FlameWatchGame> loadParachuteGame(Size size) async {
  final cartridge = FlameWatchGameCartridge(
      gameName: 'Parachute rescuer',
      background: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAABgCAYAAADVenpJAAAEHUlEQVR4nO2cPZLjIBCF0ZZPso4mceRwDrBVjuYEzp35JJtt7hNM5BtMuJGTieRkD6KNUGHUQIMA8fO+qqkay0jIvEfT9MgjBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALrjcD5NttemY6BcBvmLSbjH7T7o73OOydcUel+2tiAtCyFVVGE4M/txuw+UKahrQPQyGDjiCxEvtFPRg9MepME4w9XZ7BsJTOgRYs111l6jBw7n0+QaK3I2mgSPZYRQIDwfTi4mBMMAIe+nAOLz8cm1BluYcAmb0wi9GoA7k/X23HPYWzUTMEF6Yu3SqPODZr7tRqjzuckf5wO1aoJcOZU+fovBDL0RUyFIXWJcxSTqBrltaiVnMk2N22Lmytnqs2XTZy4VEWyVwt4KRFuWy50RQIVT1eMIppvClHj6JjwtkntH5TXQH+9v8819fn1bdxChpLhmjaQ2ghzjH66GH+9vk/yRxz6/vpMJBPH9xA8dL9mH9WRVdElK8QF/BxWyBaQSc6OYlPhCwAApUXMg1+5JP0fF56+w5BIA8fOjJ8BUaOeEe9lGXbZt13w5YBJeCIifEtfuh1uu19tw8raBaqwD8cvFZR6pq9EANuFtJ4JyWGMC5zYQtI3VAJj9dcB9zI6K9kYDQPy6eNzug6lmYNMSS0BjuLaKehQgDYDZ3w+IAJ2zMABmf3voYV99zYoAh/Npwnf+2mSnvpCzv+VHsMArLwaA8O3hqvTOBhj3P+eDPT+d2xs7IV7FFwKi14yu3aj8vh+fi/b4smYDrNEwigFUYIa8rNUvugEkMEJ6YmiXrBKIukF6YkyypKVgmCA9a02QbAkQAsvAVvhomiwCQPw6MEaA/fhc1AdsQPCy4EaBnX5ALRZwTQDxy4Mq+lBaOp8KNp0M0cuH0lbXkW0AFTwzUA82E+zHJ54Iah1qsu7H57xE7EyN8P3APvBeAmCAOjF9T3CxCwDt4/1MoASzvz2QBHYOloAOWeQAptCe6x9Dgbyouu70A6A9bPoiB+gc5ACN4/pXfywDYP1vC9UUZCXw3+EX60J///yGMSrAlgMMx8t1dQIII5SFj6ZRDCCBEfKzVj92EsgRV7+ZkHNC+u2BmBNVZR5cqoOUg4/Iw+d4uU6xP6Mc/00GLpb4rQufA3IAbQLFGvQQE0Dw+AxCbCcGt18In47VuwCuOLZ1zHQPJQkfkuDWQNRtIIcaB64Gg4aSzQA1DhZnbNZ8LvX6+nVs74X2QUF26huqKXIKHlOoXPlQanNx+6huVqrkXr44uETLkfh6lYJDO9maEsWXrIk2uYSXVGsAnRyGoMSJkSC6ll7u+SE0YwCKLcrNsZI3bh8qan/cz960ASS5ah2l4VpijpfrVOUHCwGlZ5oka1rJ4M/Pr3gXgnoboNb5D65JAVh+6/ZFAAAAAElFTkSuQmCC',
      sprites: {
        'chopper': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB8AAAASCAYAAACjMAXnAAAAgElEQVRIicWTUQ7AIAhDwez+V2ZfZAsRUhWkPxpN4WmVaC5x1lM1iupC8E9g0jmn4Ez0LxzRIgCe3/XqtZ9mHPndPTTzEjibeQYAGiWNhaLp4qbmTORnzvRdHzJflUTNb0iUvCX3zpPj36Kit30wNwDgR7oLc3wIMWO1zy1U4nsBJgQcD9rdBz0AAAAASUVORK5CYII=',
        'big-propeller': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAABCAYAAAAB3PQ6AAAAFUlEQVQImWNkYGD4z4AdMCKxsaoBAE5NAgFkEgjsAAAAAElFTkSuQmCC',
        'small-propeller': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA0AAAABCAYAAAAFKSQHAAAAFElEQVQImWNkYGD4z4AJGJHYGPIAQkUCAVYMpysAAAAASUVORK5CYII=',
        'boat1': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAMCAYAAAB4MH11AAAAVUlEQVQ4jWNkgID/DKiAkYFKgBGL4VS1hIkahgxvC2DhTLNIRga4IpsigB5E/9FoqlsAMxxf8iUF/IcT+BRQYPh/QhntPxY2KYARVyqihiWMDAwMDACr+hMHQNzxaQAAAABJRU5ErkJggg==',
        'boat2': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAPCAYAAAD+pA/bAAAAXUlEQVQ4jd2TwQoAIAhDtf//ZztEYaFiuC69q7DBNpkGQjtMINgQh5o0hMjfBjPnZyVrvLJLnBFZJiVjHcWLuYonLIHhjbhYj6aLjx4xA58rgop7B0Q8i8yK4EBNOi6DFwS0AzCLAAAAAElFTkSuQmCC',
        'boat3': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB0AAAAMCAYAAACeGbYxAAAAXUlEQVQ4je2SwQ7AIAhDX5f9/y+zqyHiZOBt72KMpCW1IsbcXYvZFJGQN2w1vjpEftOI1R8dK9IbUaFK7MRrw9myhJyQj3D2ZpO5DDYK7VIyBLg/ilZiVqa9HQjgAWIgDw41B4qcAAAAAElFTkSuQmCC',
        'falling-start': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAG0lEQVQImWNgQID/UMzAhCSAFfxHV4ChEkMFAJuEB/vDNNWaAAAAAElFTkSuQmCC',
        'falling-1-1': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAsAAAAKCAYAAABi8KSDAAAANklEQVQYlWNgIAEwovH/4xNnxKIQ3SC4AfgUY2jE5QyszmQi0mScAK+m/0gKiDadKIXIJuMFAE0sDf4TlE4JAAAAAElFTkSuQmCC',
        'falling-1-2': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAwAAAAXCAYAAAA/ZK6/AAAAc0lEQVQ4ja1SQQ7AIAir+/+fu5OGQQFJ1osKrQVlIYIitsImIQbRFnTkI1oDMgDgUbZVzAta/F6SKhEULpkrq6QkdzeWeZqV7nzgmyrnCPi+0lUv44/bAnprU07qTLEP5K7p4HozraWgxVhg4YdwNPap6AVt8R4IdORAkAAAAABJRU5ErkJggg==',
        'falling-1-3': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAcCAYAAAC+lOV/AAAAhElEQVQ4jcVU0RKAIAzC/v+f6am7QjaX5rWnnMCE0xp8Mei3cJGQLOcogIcqlYkdt00SAfhjaw5hf8nzcmDbPdscdPIdRNOD7s8cm7qoiKQ4CojSe5TzU3pRQJ/2K///3bA7mcgfxdAS5TtM+lLMBDLc94FFvvdPXioNrHzrHHD6T5MKnGZ6Ig/bw8FdAAAAAElFTkSuQmCC',
        'falling-2-1': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAOCAYAAADnqNYmAAAAN0lEQVQYlWNgQID/MAYjugADAwMjE5okAwMDAwMTAwFAnJkoAJtKFAE4jdVMrLbjdSe6uRic/wB4Ww4DhV4pCgAAAABJRU5ErkJggg==',
        'falling-2-2': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAsAAAAXCAYAAADduLXGAAAAZklEQVQ4jb2SQQ4AIQgD2/3/n/FmoICuHiQxUjMKJRI5zOVEIzykQQ+vwHmBP0EAwFeV67TC6z6etMHNDhy0YSnZgXpgbgVQDVUVJnM052vYUM+5Na+mAqgvKXD/kd7DlZcUOqagB2PZFxfWYgf8AAAAAElFTkSuQmCC',
        'falling-2-3': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA0AAAAYCAYAAAAh8HdUAAAAcUlEQVQ4jc1SWw7AIAyC3f/O3ddM7WA+4sdIjLVCqK2ERqSY9ZKG6MAsmhE0IRcFAIDLlfBxlqIhjpRHUY7KAcbN5lbeFMox0p7Xy7UqXVM63lbLt+f0YDSvxt1yqqgdlBWoSVfSmQ/7c5FCmHhKYHM30fMaEjk3uV4AAAAASUVORK5CYII=',
        'falling-3-1': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAsAAAAICAYAAAAvOAWIAAAANElEQVQYlWNgYGD4D8XoAEOcEUkCGx9FHSOSADbTcSrGpQmuhgmPacTYSJoibBpwhRhuGwAaZQ38lW/CgQAAAABJRU5ErkJggg==',
        'falling-3-2': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAwAAAAXCAYAAAA/ZK6/AAAAcUlEQVQ4jaVSSRLAMAjC/v/P9tRMXXCZcNNA3BBYKCKEBRk5cD9BRz4iWZABAE9Wtsp5QYvrlkILSUwr+Lz+c9O2lAaDiiapsC0ccrb30k/TO5xP1ofzAgW3B11KGBTN0J5seJMZ7ty6FjD4gUvblI8vumIeCBPVh5EAAAAASUVORK5CYII=',
        'falling-3-3': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAwAAAAXCAYAAAA/ZK6/AAAAcUlEQVQ4jaVSSRLAMAjC/v/P9tRMXXCZcNNA3BBYKCKEBRk5cD9BRz4iWZABAE9Wtsp5QYvrlkILSUwr+Lz+c9O2lAaDiiapsC0ccrb30k/TO5xP1ofzAgW3B11KGBTN0J5seJMZ7ty6FjD4gUvblI8vumIeCBPVh5EAAAAASUVORK5CYII=',
        'drowing-1': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABYAAAAKCAYAAACwoK7bAAAAXUlEQVQoka1RQQ7AIAyi+/+f683YDjq2jJMRRGgDHHmcQ2hGXIZpEs0jPqURKIGCXPYPJ+7UlHa9an+kxjA1TbTErqljvpf356yLMeDNUnG3dkrgLo/pRyRL8YLHAjieFgiKBf6lAAAAAElFTkSuQmCC',
        'drowing-2': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAECAYAAACzzX7wAAAAHUlEQVQImWNkQID/DKiAEU5gkYQrYsQjiTAGnxUAJ2cEBI7UGsEAAAAASUVORK5CYII=',
        'miss-label': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABIAAAAGCAYAAADOic7aAAAANklEQVQYlWNgQID/DKjgPxbx/wT4GILYFBDi43QBLhcRNIwYr+Hks+ByHh6LGLHxGXE5j1QAABF+Gu29g39bAAAAAElFTkSuQmCC',
        'miss-marker': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAYAAAAFCAYAAABmWJ3mAAAAIElEQVQImWNgYGD4z4AK/mPjoCuCC8IlWNAkGXEZBQcAOkoH/j7JiCMAAAAASUVORK5CYII=',
      },
      gameSprites: [
        GameSprite(id: 'chopper', x: 90, y: 1, spriteName: 'chopper', active: true),
        GameSprite(id: 'big-chopper-propeller', x: 88, y: 1, spriteName: 'big-propeller', active: true),
        GameSprite(id: 'small-chopper-propeller', x: 105, y: 2, spriteName: 'small-propeller', active: false),
        GameSprite(id: 'boat1', x: 18, y: 65, spriteName: 'boat1', active: true),
        GameSprite(id: 'boat2', x: 50, y: 65, spriteName: 'boat2', active: false),
        GameSprite(id: 'boat3', x: 77, y: 65, spriteName: 'boat3', active: false),

        GameSprite(id: 'falling-start', x: 82, y: 8, spriteName: 'falling-start', active: false),

        GameSprite(id: 'falling-1-1', x: 63, y: 12, spriteName: 'falling-1-1', active: false),
        GameSprite(id: 'falling-1-2', x: 46, y: 20, spriteName: 'falling-1-2', active: false),
        GameSprite(id: 'falling-1-3', x: 27, y: 47, spriteName: 'falling-1-3', active: false),

        GameSprite(id: 'falling-2-1', x: 72, y: 15, spriteName: 'falling-2-1', active: false),
        GameSprite(id: 'falling-2-2', x: 63, y: 27, spriteName: 'falling-2-2', active: false),
        GameSprite(id: 'falling-2-3', x: 59, y: 51, spriteName: 'falling-2-3', active: false),

        GameSprite(id: 'falling-3-1', x: 79, y: 16, spriteName: 'falling-3-1', active: false),
        GameSprite(id: 'falling-3-2', x: 82, y: 25, spriteName: 'falling-3-2', active: false),
        GameSprite(id: 'falling-3-3', x: 90, y: 47, spriteName: 'falling-3-3', active: false),

        GameSprite(id: 'drowing-1-1', x: 17, y: 78, spriteName: 'drowing-1', active: false),
        GameSprite(id: 'drowing-1-2', x: 23, y: 90, spriteName: 'drowing-2', active: false),

        GameSprite(id: 'drowing-2-1', x: 56, y: 78, spriteName: 'drowing-1', active: false),
        GameSprite(id: 'drowing-2-2', x: 62, y: 90, spriteName: 'drowing-2', active: false),

        GameSprite(id: 'drowing-3-1', x: 88, y: 78, spriteName: 'drowing-1', active: false),
        GameSprite(id: 'drowing-3-2', x: 94, y: 90, spriteName: 'drowing-2', active: false),

        GameSprite(id: 'miss-label', x: 27, y: 5, spriteName: 'miss-label', active: true),
        GameSprite(id: 'miss-marker-1', x: 39, y: 12, spriteName: 'miss-marker', active: false),
        GameSprite(id: 'miss-marker-2', x: 33, y: 12, spriteName: 'miss-marker', active: false),
        GameSprite(id: 'miss-marker-3', x: 27, y: 12, spriteName: 'miss-marker', active: false),
      ],
       digitalDisplays: {
         'score': GameDigitalDisplay(position: Position(5, 5)),
       },
  );

  final game = await FlameWatchGame.load(
      size, cartridge, ParachuteGameController(cartridge),
  );

  return game;
}
