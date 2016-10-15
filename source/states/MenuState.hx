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
	private var playText:FlxText;
	private var optionPointer:FlxSprite;
	private var granyan:FlxSprite;
	
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
	   
		playText = new FlxText(0, 0, "PLAY");
		playText.x = (FlxG.width / 2) - (playText.width / 2);
		playText.y = FlxG.height - playText.height - 10;
		add(playText);
		
		granyan = new FlxSprite();
		granyan.loadGraphic(AssetPaths.Granyan__png, true, 32, 32);
		granyan.animation.add("titleAnimation", [0, 1], 5, true);
		granyan.animation.play("titleAnimation");
		granyan.x = (FlxG.width / 2) - granyan.width / 2 ;
		granyan.y = 100;
		add(granyan);
		
		optionPointer = new FlxSprite();
		optionPointer.loadGraphic(AssetPaths.Nave__png);
		optionPointer.x = playText.x - optionPointer.width - 5;
		optionPointer.y = playText.y - 1;
		add(optionPointer);
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			Start();
		}
		super.update(elapsed);
	}
	
	public function Start():Void
	{
		remove(NameTxt);
		remove(instructionsTxt);
		FlxG.switchState(new PlayState());
	}
}
