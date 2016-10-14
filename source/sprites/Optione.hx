package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxObject;

/**
 * ...
 * @author Maximiliano Viñas Craba
 */
class Optione extends FlxSprite
{
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.Option__png,false,8,8);
		velocity.x = 60;
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}