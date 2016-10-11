package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;

class Ene2 extends FlxSprite
{

	private var patron : Int = 0;
	private var subaj : Bool = false;
	public var bullets:FlxTypedGroup<Bullet>;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{		
		super(X, Y, SimpleGraphic);	
		makeGraphic(16, 16, 0xFF804048);
	}

	public function Movimiento() 
	{
		if (patron % 32 == 0)
		{
			subaj = (subaj)?false:true;
			AgregarDisp();
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
	
	private function AgregarDisp() 
	{
		var newBullet = new Bullet(this.x + 8, this.y + 8, 0);
        bullets = new FlxTypedGroup<Bullet>();
		bullets.add(newBullet);
		FlxG.state.add(newBullet);
	}
	
}