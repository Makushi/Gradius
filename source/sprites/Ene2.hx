package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

class Ene2 extends FlxSprite
{

	private var patron : Int = 0;
	private var subaj : Bool = false;
	private var disp : FlxSprite;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{		
		super(X, Y, SimpleGraphic);	
		makeGraphic(16, 16, 0xFF804000);		
			
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
		disp = new FlxSprite(this.x+8, this.y+8);
		disp.makeGraphic(10, 2, 0xFF804000);
		disp.velocity.x = -200;
		FlxG.state.add(disp);
	}
	
	private function DestruirDisp()
	{
		disp.destroy();
	}
}