package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import states.PlayState;
import flixel.system.FlxSound;

/**
 * ...
 * @author ...
 */
class GameOverState extends FlxState
{	
	
	private var gameOver:FlxText;	
	private var scoreTxt:FlxText;
	private var highScoreTxt:FlxText;
	private var messageTxt:FlxText;
	private var replay:FlxButton;
	private var _score:Int;
	private var _victory:Bool;
	
	public function new(victory:Bool) 
	{
		_victory = victory;
		super();
	}
	
	override public function create():Void
	{
		super.create();
		
		gameOver = new FlxText(20, 50, 0, null, 20);
		if (_victory)
		{
			gameOver.text = "A WINNER IS YOU!";
		}
		else
		{
			gameOver.text = "GAME OVER";
		}
		gameOver.alignment = CENTER;
		gameOver.screenCenter(X);
		gameOver.color = 0xFFc300ff;
		

		add(gameOver);
		
		scoreTxt = new FlxText(0, 80, 0, "Score : " + Reg.score, 12);
		scoreTxt.alignment = CENTER;
		scoreTxt.screenCenter(X);
		scoreTxt.color = 0xFFc300ff;
		add(scoreTxt);
		
		highScoreTxt = new FlxText(0, 95, 0, "Highscore : " + Reg.highScore , 12);
		highScoreTxt.alignment = CENTER;
		highScoreTxt.screenCenter(X);
		highScoreTxt.color = 0xFFc300ff;
		add(highScoreTxt);

		replay = new FlxButton(0, 0, "Replay", Restart);
		replay.x = (FlxG.width / 2) - (replay.width / 2);
		replay.y = FlxG.height - replay.height - 10;
		add(replay);
	}
	
	private function Restart():Void
	{
		Reg.score = 0;
		Reg.playerLives = 3;
		FlxG.switchState(new PlayState());
	}
}