package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxObject;

/**
 * ...
 * @author Maximiliano Viñas Craba
 */
class Bullet extends FlxSprite
{
	public var direction:Int;
	
	public function new(?X:Float=0, ?Y:Float=0, Direction:Int) 
	{
		super(X, Y);
		makeGraphic(5, 5);
		direction = Direction;
		//Comentado para Test
		//velocity.x = 300; 
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}