package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import sprites.Bullet;
import flixel.group.FlxGroup.FlxTypedGroup;

class Ene3 extends FlxSprite
{
	
	public var bullets:FlxTypedGroup<Bullet>;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{		
		super(X, Y, SimpleGraphic);	
		makeGraphic(16, 16, 0xFF804000);
			
	}	
	
	private function Direccion(xnave: Float, ynave : Float) : Int
	{
		var dire : Int = 0;
		// 0 izq, 1 izq arriba, 2 arriba, 3 der arriba, 4 derecha, 5 derecha abajo, 6 abajo, 7 izq abajo
			if (xnave <= this.x + 8 && ynave >= this.y - 8 && ynave <= this.y + 24)
			{
				dire = 0; 
			}
			else if (xnave <= this.x + 8 && ynave <= this.y - 8)
			{
				dire = 1;
			}
			else if (xnave >= this.x - 8 && xnave <= this.x + 24 && ynave <= this.y - 8)
			{
				dire = 2;
			}
			else if (xnave >= this.x + 24 && ynave <= this.y - 8)
			{
				dire = 3;
			}
			else if (xnave >= this.x + 24 && ynave >= this.y - 8 && ynave <= this.y + 24)
			{
				dire = 4;				
			}
			else if (xnave >= this.x + 8 && ynave >= this.y + 24)
			{
				dire = 5;
			}
			else if (xnave >= this.x - 8 && xnave <= this.x + 24 && ynave >= this.y + 24)
			{
				dire = 6;
			}
			else if (xnave <= this.x - 8 && ynave >= this.y + 24)
			{
				dire = 7;
			}
		return dire;
	}
	
	public function AgregarDisp(xnave: Float, ynave : Float) 
	{
		var newBullet = new Bullet(this.x + 8, this.y + 8, Direccion(xnave, ynave));
        bullets = new FlxTypedGroup<Bullet>();
		bullets.add(newBullet);
		FlxG.state.add(newBullet);
	}
	
	public function Disparar()
	{
		for (bullet in bullets)
		{
			switch(bullet.direction)
			{
				case 0:
					bullet.x--;
					break;
				case 1:
					bullet.x--;
					bullet.y--;
					break;
				case 2:
					bullet.y--;
					break;
				case 3:
					bullet.x++;
					bullet.y--;
					break;
				case 4:
					bullet.x++;
					break;
				case 5:
					bullet.x++;
					bullet.y++;
					break;
				case 6:
					bullet.y++;
					break;
				case 7:
					bullet.x--;
					bullet.y++;
					break;
			}
		}
	}
	
}