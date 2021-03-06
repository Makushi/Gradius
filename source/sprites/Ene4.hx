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
class Ene4 extends FlxSprite
{
	
	public var bullets:FlxTypedGroup<Bullet>;
	public var pointValue:Int = 400;
	private var firingTimer:FlxTimer;
	
	public function new(?X:Float=0, ?Y:Float=0, enemyBullets:FlxTypedGroup<Bullet>) 
	{		
		super(X, Y);	
		loadGraphic(AssetPaths.Ene4__png,false,16,16);
		bullets = enemyBullets;
	}	
	
	private function Direccion(xnave: Float, ynave : Float) : Int
	{
		var dire : Int = 0;
		// 0 izq, 1 izq arriba, 2 arriba, 3 der arriba, 4 derecha, 5 derecha abajo, 6 abajo, 7 izq abajo
			if (xnave <= this.x && ynave >= this.y && ynave <= this.y + 16)
			{
				dire = 0; 
			}
			else if (xnave <= this.x && ynave <= this.y)
			{
				dire = 1;
			}
			else if (xnave >= this.x && xnave <= this.x + 16 && ynave <= this.y)
			{
				dire = 2;
			}
			else if (xnave >= this.x + 16 && ynave <= this.y)
			{
				dire = 3;
			}
			else if (xnave >= this.x + 16 && ynave >= this.y && ynave <= this.y + 16)
			{
				dire = 4;				
			}
			else if (xnave >= this.x + 16 && ynave >= this.y + 16)
			{
				dire = 5;
			}
			else if (xnave >= this.x && xnave <= this.x + 16 && ynave >= this.y + 16)
			{
				dire = 6;
			}
			else if (xnave <= this.x && ynave >= this.y + 16)
			{
				dire = 7;
			}
		return dire;
	}
	
	public function AgregarDisp(xnave: Float, ynave : Float) 
	{
		if (alive)
		{
			var newBullet = new Bullet(this.x + 8, this.y + 8, Direccion(xnave+8, ynave+8), 0);
			trace(newBullet.direction);
			switch(newBullet.direction)
				{
					case 0:
						newBullet.velocity.x = -160;
						newBullet.velocity.y = 0;
					case 1:
						newBullet.velocity.x = -160;
						newBullet.velocity.y = -100;
					case 2:
						newBullet.velocity.x = -60;
						newBullet.velocity.y = -160;
					case 3:
						newBullet.velocity.x = 100;
						newBullet.velocity.y = -100;
					case 4:
						newBullet.velocity.x = 100;
						newBullet.velocity.y = 0;
					case 5:
						newBullet.velocity.x = 100;
						newBullet.velocity.y = 100;
					case 6:
						newBullet.velocity.x = -60;
						newBullet.velocity.y = 160;
					case 7:
						newBullet.velocity.x = -160;
						newBullet.velocity.y = 100;
				}
			bullets.add(newBullet);
		}
	}
	
	
}