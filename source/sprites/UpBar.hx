package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author Kasai Takunori
 */
class UpBar extends FlxSprite
{

	// de 0 a 5
	public var upNumber : Int = 0;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);	
		loadGraphic(AssetPaths.UpBar__png , true, 128, 10);
		animation.add("UB", [0], 5, false);
		animation.add("UBSpeed", [1], 5, false);
		animation.add("UBMissile", [2], 5, false);
		animation.add("UBShield", [3], 5, false);
		animation.add("UBOption", [4], 5, false);
		animation.play("UB");			
	}
	
	public function SwitchUp()
	{
		upNumber++;
		if (upNumber > 4) 
		{
			upNumber = 1;
		}	
		switch(upNumber)
		{			
			case 1:
				animation.play("UBSpeed");
			case 2:
				animation.play("UBMissile");
			case 3:
				animation.play("UBShield");
			case 4:
				animation.play("UBOption");						
		}
	}
	
	public function Reset()
	{
		animation.play("UB");
		upNumber = 0;
	}
	
}