package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxAxes;
import flixel.sound.FlxSound;

class ObjectFactory
{
    public static function createText():FlxText
    {
        return new FlxText(16, 16, 0, "SCORE: 0", 16);
    }

    public static function CreateSound():FlxSound
    {
        return FlxG.sound.load(AssetPaths.hit__wav);
    }

    public static function createPaddle():FlxSprite
    {
        var _paddle = new FlxSprite(0, FlxG.height - 64, AssetPaths.paddle__png);
        _paddle.screenCenter(FlxAxes.X);
        _paddle.immovable = true;
        return _paddle;
    }

    public static function createBall(BALL_SPEED:Float):FlxSprite
    {
        var _ball = new FlxSprite();
        _ball.makeGraphic(16, 16, FlxColor.RED);
        _ball.screenCenter();
        _ball.velocity.set(BALL_SPEED, -BALL_SPEED);
        _ball.elasticity = 1;
        return _ball;
    }

    public static function createBricks():FlxTypedGroup<FlxSprite>
    {
        var _grpBricks = new FlxTypedGroup<FlxSprite>();

        for (row in 0...4)
        {
            for (col in 0...6)
            {
                var b = new FlxSprite(80 + col * 80, 64 + row * 32, AssetPaths.brick__png);
                b.immovable = true;
                b.color = 0xffea006e;
                _grpBricks.add(b);
            }
        }
        return _grpBricks;
    }

    public static function createWalls():FlxTypedGroup<FlxSprite>
    {
        var walls = new FlxTypedGroup<FlxSprite>();

        var topWall = new FlxSprite(0, 0);
        topWall.makeGraphic(FlxG.width, 8, FlxColor.LIME);
        walls.add(topWall);

        var leftWall = new FlxSprite(0, 0);
        leftWall.makeGraphic(8, FlxG.height, FlxColor.LIME);
        walls.add(leftWall);

        var rightWall = new FlxSprite(FlxG.width - 8, 0);
        rightWall.makeGraphic(8, FlxG.height, FlxColor.LIME);
        walls.add(rightWall);

        for (wall in walls.members)
        {
            wall.immovable = true;
        }

        return walls;
    }
}
