package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxVelocity;
import flixel.math.FlxPoint;

/**
 * ...
 * @author Maximiliano Viñas Craba
 */
class Bullet extends FlxSprite
{
	public var direction:Int;
	
	public function new(?X:Float=0, ?Y:Float=0, Direction:Int, Velocity:Int, ?YVelocity:Int) 
	{
		super(X, Y);
		
		direction = Direction;
		velocity.x = Velocity; 
		if (YVelocity != null)
		{
			loadGraphic(AssetPaths.Missile__png, false, 16, 16);
			velocity.y = YVelocity; 
		}
		else{
			loadGraphic(AssetPaths.Bullet__png, false, 5, 5);
		}
		
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}