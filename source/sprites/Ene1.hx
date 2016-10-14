package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Kasai Takunori
 */
class Ene1 extends FlxSprite
{

	private var patron : Int = 0;
	public var pointValue:Int = 100;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{		
		super(X, Y, SimpleGraphic);	
		loadGraphic(AssetPaths.Ene1__png,false,16,16);
	}

	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		Movimiento();
	}
	
	public function Movimiento() 
	{
		
		if (patron >= 224 ) // Final
		{
			this.x+=2;
		}
		else if (patron >= 208)
		{
			this.y++;
		}
		else if (patron >= 160)
		{
			if (patron % 2 == 0) 
			{
				this.x+=2;
			}
			this.y--;
		}
		else if (patron >= 96)
		{
			this.x+=2;
		}
		else if (patron >= 64)
		{
			if (patron % 2 == 0) 
			{
				this.x--;
			}
			this.y++;
		}
		else //Inicio
		{
			this.x--;
		}		
		patron++;
	}
	
}