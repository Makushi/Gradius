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
			loadGraphic(AssetPaths.BulletMultiDire__png, true, 11, 11);
			animation.add("BullP", [0], 5, false);
			animation.add("BullE", [1], 5, false);
			animation.add("BullE1", [2], 5, false);
			animation.add("BullE2", [3], 5, false);
			animation.add("BullE3", [4], 5, false);
			animation.add("BullE4", [5], 5, false);
			animation.add("BullE5", [6], 5, false);
			animation.add("BullE6", [7], 5, false);
			animation.add("BullE7", [8], 5, false);
			if (Velocity > 0)
			{	
				animation.play("BullP");
			}
			else
			{
				switch(direction) 
				{
					case 0:	
						animation.play("BullE");
					case 1:	
						animation.play("BullE1");
					case 2:	
						animation.play("BullE2");
					case 3:	
						animation.play("BullE3");
					case 4:	
						animation.play("BullE4");
					case 5:	
						animation.play("BullE5");
					case 6:	
						animation.play("BullE6");
					case 7:	
						animation.play("BullE7");
					case 8:	
						animation.play("BullE8");
							
				}
				
			}	
		}
		
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}