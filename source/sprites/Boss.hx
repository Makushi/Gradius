package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.ui.FlxBar;
import flixel.math.FlxVelocity;
import flixel.math.FlxPoint;
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
	public var hpBar:FlxBar;

	
	public function new(?X:Float=0, ?Y:Float=0, enemyBullets:FlxTypedGroup<Bullet>) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.Granyan__png, true, 32, 32);
		animation.add("AniGra", [0, 1], 10, true);
		animation.play("AniGra");
		bullets = enemyBullets;
		firingTimer = new FlxTimer();
		firingTimer.start(1, Fire, 0);
		
		FlxTween.tween(this, { x: X, y: Y + 140 }, 2, 
		{ type : FlxTween.PINGPONG, ease : FlxEase.quadInOut });
		
		hpBar = new FlxBar(X - 50, Y + 175, null, 100, 10);
		hpBar.createFilledBar(0xFF8e0000, 0xFFFF0000);
		hpBar.setRange(0, hp);
		hpBar.value = hp;
	}
	
	public function Damage()
	{
		hp -= 500;
		hpBar.value = hp;
		if (hp <= 0)
		{
			FlxG.switchState(new GameOverState(true));
		}
		
	}
	
	private function Fire(Timer:FlxTimer):Void
	{
		if (alive)
		{
			var newBullet = new Bullet(this.x + 8, this.y + 8, 0, -150);
			//var playerPoint:FlxPoint = new FlxPoint(Reg.playerX, Reg.playerY);
			//FlxVelocity.moveTowardsPoint(newBullet, Reg.playerCoords, 60, 0);
			bullets.add(newBullet);
		}
	}
}