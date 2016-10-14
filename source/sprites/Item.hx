package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Item extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Up__png, true, 16, 16);
		animation.add("UpAnim", [0, 1, 2, 3, 4, 5], 5, true);
		animation.play("UpAnim");
	}
	
}