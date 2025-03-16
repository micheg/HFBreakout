package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxAxes;
import flixel.util.FlxSpriteUtil;
import ObjectFactory;
import flixel.sound.FlxSound;

class PlayState extends FlxState
{
	// ui objects
	var paddle:FlxSprite = null;
	var ball:FlxSprite = null;
	var BALL_SPEED:Float = 200;
	var PADDLE_SPEED:Float = 260;
	var grpWalls:FlxTypedGroup<FlxSprite> = null;
	var grpBricks:FlxTypedGroup<FlxSprite> = null;
	var score:Int = 0;
	var scoreLabel:FlxText = null;

	// state
	var gameStarted:Bool = false;
	var gameEnded:Bool = false;

	// sound
	var sndHit:FlxSound = null;

	// objects
   	override public function create()
    {
        super.create();
        initializeObjects();
        addObjects();
    }

    private function initializeObjects()
    {
        ball = ObjectFactory.createBall(BALL_SPEED);
        paddle = ObjectFactory.createPaddle();
        grpWalls = ObjectFactory.createWalls();
        grpBricks = ObjectFactory.createBricks();
        scoreLabel = ObjectFactory.createText();
        sndHit = ObjectFactory.CreateSound();
    }

    private function addObjects()
    {
        add(ball);
        add(paddle);
        add(grpWalls);
        add(grpBricks);
        add(scoreLabel);
    }

    // collisions
	private function hitBrick(Ball:FlxSprite, Brick:FlxSprite)	
	{	
    	Brick.kill();
    	score += 10;
    	updateScore(score);
    	sndHit.play(true);
	}

	private function hitBall(Ball:FlxSprite, Paddle:FlxSprite)
	{
		var ballMid:Int = Std.int(Ball.x + Ball.width / 2);
		var paddleMid:Int = Std.int(Paddle.x + Paddle.width / 2);

		if (ballMid < paddleMid)
		{
		    Ball.velocity.x = -BALL_SPEED;
		}
		else if (ballMid > paddleMid)
		{
		    Ball.velocity.x = BALL_SPEED;
		}
		else
		{
		    Ball.velocity.x = 0;
		}
		sndHit.play(true);
	}

	private function checkState():Void
	{
		if (!gameStarted)
		{
		    if (FlxG.keys.justPressed.SPACE)
		    {
		        gameStarted = true;
		    }
		    return;
		}

		if (gameEnded)
		{
		    if (FlxG.keys.justPressed.SPACE)
		    {
		        FlxG.resetState();
		    }
		    return;
		}
	}

	private function checkLeveLend():Void
	{
		if (grpBricks.countLiving() == 0)
		{
			endGame();
		}
	}

	private function checkGameEnd():Void
	{
		if (ball.y > FlxG.height)
		{
			endGame();
		}
	}

	override public function update(elapsed:Float)
    {
    	checkGameEnd();
    	checkState();
        super.update(elapsed);
        if(!gameEnded)
        {
        	handleCollisions();
        	handlePaddleMovement();
        }
    }

  	private function handlePaddleMovement():Void
    {
        paddle.velocity.x = 0;

        if (FlxG.keys.pressed.LEFT)
            paddle.velocity.x = -PADDLE_SPEED;
        else if (FlxG.keys.pressed.RIGHT)
            paddle.velocity.x = PADDLE_SPEED;

        FlxSpriteUtil.bound(paddle);
    }
    
    private function handleCollisions():Void
    {
        FlxG.collide(ball, grpWalls);
        FlxG.collide(ball, grpBricks, hitBrick);
        FlxG.collide(ball, paddle, hitBall);
    }

    private function updateScore(Value:Int):Void
	{
    	scoreLabel.text = 'SCORE: $Value';
	}

	private function endGame():Void
	{
		gameEnded = true;
		var endMessage = new FlxText(0, 0, 0, "GAME OVER", 32);
		endMessage.screenCenter();
		add(endMessage);
	}
}
