package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import sprites.Bullet;
import states.GameOverState;

/**
 * ...
 * @author Maximiliano Viñas Craba
 */
class Boss extends FlxSprite
{
	
	public var hp:Int = 10000;
	public var pointValue:Int = 10000;
	public var bullets:FlxTypedGroup<Bullet>;
	private var firingTimer:FlxTimer;
	
	public function new(?X:Float=0, ?Y:Float=0, enemyBullets:FlxTypedGroup<Bullet>) 
	{
		super(X, Y);
		makeGraphic(32, 32, 0xFF00FF00);
		bullets = enemyBullets;
		firingTimer = new FlxTimer();
		firingTimer.start(2, Fire, 0);
		FlxTween.tween(this, { x: X, y: Y + 150 }, 2, 
		{ type : FlxTween.PINGPONG, ease : FlxEase.quadInOut });
	}
	
	public function Damage()
	{
		hp -= 500;
		if (hp <= 0)
		{
			FlxG.switchState(new GameOverState());
		}
		
	}
	
	private function Fire(Timer:FlxTimer):Void
	{
		if (alive)
		{
			var newBullet = new Bullet(this.x + 8, this.y + 8, 0, -100);
			bullets.add(newBullet);
		}
	}
}