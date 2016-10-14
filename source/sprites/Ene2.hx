package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;
import sprites.Bullet;

/**
 * ...
 * @author Kasai Takunori
 */
class Ene2 extends FlxSprite
{

	private var patron : Int = 0;
	private var subaj : Bool = false;
	public var pointValue:Int = 300;
	public var bullets:FlxTypedGroup<Bullet>;
	private var firingTimer:FlxTimer;
	
	public function new(?X:Float=0, ?Y:Float=0, enemyBullets:FlxTypedGroup<Bullet>) 
	{		
		super(X, Y);	
		loadGraphic(AssetPaths.Ene2__png,false,16,16);
		bullets = enemyBullets;
		firingTimer = new FlxTimer();
		firingTimer.start(2, AgregarDisp, 0);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		Movimiento();
	}
	
	public function Movimiento():Void
	{
		if (patron % 32 == 0)
		{
			subaj = (subaj) ? false : true;
		}
		if (subaj) 
		{
			this.y++;
		}
		else 
		{
			this.y--;
		}
		this.x-= 0.1;
		patron++;
	}	
	
	private function AgregarDisp(Timer:FlxTimer):Void
	{
		if (alive)
		{
			var newBullet = new Bullet(this.x + 8, this.y + 8, 0, -100);
			bullets.add(newBullet);
		}
	}
	
}