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
 * @author Maximiliano Viñas Craba
 */
class GameOverState extends FlxState
{	
	
	private var gameOver:FlxText;	
	private var scoreTxt:FlxText;
	private var highScoreTxt:FlxText;
	private var _score:Int;
	private var _victory:Bool;
	private var replayText:FlxText;
	private var optionPointer:FlxSprite;
	private var granyan:FlxSprite;
	
	public function new(victory:Bool) 
	{
		_victory = victory;
		super();
	}
	
	override public function create():Void
	{
		super.create();

		gameOver = new FlxText(20, 50, 0, null, 20);
		
		granyan = new FlxSprite();
		
		if (_victory)
		{
			gameOver.text = "A WINNER IS YOU!";
			granyan.loadGraphic(AssetPaths.GranyanDefeated__png);
		}
		else
		{
			gameOver.text = "GAME OVER";
			granyan.loadGraphic(AssetPaths.Granyan__png, true, 32, 32);
			granyan.animation.add("titleAnimation", [0, 1], 5, true);
			granyan.animation.play("titleAnimation");
		}
		gameOver.alignment = CENTER;
		gameOver.screenCenter(X);
		gameOver.color = 0xFFc300ff;
		
		add(gameOver);
		
		granyan.x = (FlxG.width / 2) - granyan.width / 2 ;
		granyan.y = 120;
		add(granyan);
		
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
		
		replayText = new FlxText(0, 0, "REPLAY");
		replayText.x = (FlxG.width / 2) - (replayText.width / 2);
		replayText.y = FlxG.height - replayText.height - 10;
		add(replayText);
		
		optionPointer = new FlxSprite();
		optionPointer.loadGraphic(AssetPaths.Nave__png);
		optionPointer.x = replayText.x - optionPointer.width - 5;
		optionPointer.y = replayText.y - 1;
		add(optionPointer);
	}
	
	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			Restart();
		}
		super.update(elapsed);
	}
	
	private function Restart():Void
	{
		Reg.score = 0;
		Reg.playerLives = 3;
		FlxG.switchState(new PlayState());
	}
}