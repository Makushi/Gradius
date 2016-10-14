package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.FlxObject;

class MenuState extends FlxState
{
	private var NameTxt:FlxText;
	private var instructionsTxt:FlxText;
	private var play:FlxButton;
	
	override public function create():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 1, true);
		super.create();
		NameTxt = new FlxText(20, 50, 0, "GRANYAN", 40);
		NameTxt.alignment = CENTER;
		NameTxt.screenCenter(X);
		NameTxt.color = 0xFFc300ff;
		add(NameTxt);
		
		instructionsTxt = new FlxText(0, 150, 0, "MOVE WITH THE ARROW KEYS\nFIRE WITH Z\nACTIVATE POWERUPS WITH X", 8);
		instructionsTxt.alignment = CENTER;
		instructionsTxt.screenCenter(X);
		add(instructionsTxt);

		play = new FlxButton(0, 0, "Play", Start);
		play.x = (FlxG.width / 2) - (play.width / 2);
		play.y = FlxG.height - play.height - 10;
		add(play);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	public function Start():Void
	{
		remove(NameTxt);
		remove(instructionsTxt);
		remove(play);
		FlxG.switchState(new PlayState());
	}
}
