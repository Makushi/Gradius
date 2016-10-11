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
	private var replay:FlxButton;
	
	public function new() 
	{
		super();
	}
	
	override public function create()
	{
		super.create();
		
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