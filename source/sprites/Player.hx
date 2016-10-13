package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxState;
import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.group.FlxGroup.FlxTypedGroup;


/**
 * ...
 * @author Maximiliano Viñas Craba
 */
class Player extends FlxSprite
{
	public var speed:Int = Reg.playerSpeed;
	public var bullets:FlxTypedGroup<Bullet>;
	
	public function new(?X:Float=0, ?Y:Float=0, playerBullets:FlxTypedGroup<Bullet>) 
	{
		super(X, Y);
		makeGraphic(16, 16);
		bullets = playerBullets;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		Movement();
	}
	
	public function Movement():Void 
	{
		if (this.alive)
		{
			if (FlxG.keys.pressed.LEFT)
			{
				this.x -= speed;
			}
	 
			if (FlxG.keys.pressed.RIGHT)
			{
				this.x += speed;
			}
	 
			if (FlxG.keys.pressed.UP)
			{
				this.y -= speed;
			}
	 
			if (FlxG.keys.pressed.DOWN)
			{
				this.y += speed;
			}
			
			if (FlxG.keys.justPressed.Z)
			{
				Shoot();
			}
		}
	}
	
	private function Shoot():Void{
        var newBullet = new Bullet(this.x + 8, this.y + 8, 1, 300);
        bullets.add(newBullet);
    }
}