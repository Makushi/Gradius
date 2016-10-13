package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;
import sprites.Bullet;

class Ene3 extends FlxSprite
{

	private var patron : Int = 0;
	private var subaj : Bool = false;
	public var bullets:FlxTypedGroup<Bullet>;
	private var firingTimer:FlxTimer;
	
	public function new(?X:Float=0, ?Y:Float=0, enemyBullets:FlxTypedGroup<Bullet>) 
	{		
		super(X, Y);	
		makeGraphic(16, 16, 0xFF804048);
		velocity.x = 50;
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
		if (patron % 84 == 0)
		{
			subaj = (subaj) ? false : true;
			patron = 0;
		}
		if (patron > 20)
		{
			if (subaj) 
			{
				this.y += 0.5;			
			}
			else 
			{
				this.y-=0.5;
			}
		}
		patron++;
	}	
	
	private function AgregarDisp(Timer:FlxTimer):Void
	{
		var newBullet = new Bullet(this.x + 8, this.y + 8, 0, -100);
		bullets.add(newBullet);
	}
	
}