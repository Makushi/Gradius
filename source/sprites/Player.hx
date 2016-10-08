package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxState;
import flixel.FlxG;
import flixel.system.FlxSound;

/**
 * ...
 * @author Maximiliano Viñas Craba
 */
class Player extends FlxSprite
{
	public var speed:Int = Reg.playerSpeed;
	public var lives:Int = Reg.playerLives;
	public var bullet:Bullet;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(16, 16);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		Movement();
	}
	
	public function Movement():Void 
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
	}
}