package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

class Ene3 extends FlxSprite
{
	
	private var disp : FlxSprite;
	private var time : Int;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{		
		super(X, Y, SimpleGraphic);	
		makeGraphic(16, 16, 0xFF804000);		
			
	}	
	//En el state recibe la posicion de la nave y dispara.
	//El tiempo de disparo lo hace el enemigo o state??
	public function Disparar(xnave: Int, ynave : Int) 
	{
		// 0 izq, 1 izq arriba, 2 arriba, 3 der arriba, 4 derecha, 5 derecha abajo, 6 abajo, 7 izq abajo		
		if (time % 32 == 0)
		{
			disp = new FlxSprite(this.x+8, this.y+8);
			disp.makeGraphic(10, 2, 0xFF804000);
			disp.velocity.x = -200;
			FlxG.state.add(disp);
			time = 0;
		}
		if (disp.alive)
		{
			if (xnave <= X + 8 && ynave >= y - 8 && ynave <= y + 24)
			{
				//0
				disp.x--;
			}
			else if (xnave <= X + 8 && ynave >= y - 8)
			{
				//1
				disp.x--;
				disp.y--;
			}
			else if (xnave >= X - 8 && xnave <= X + 24 && ynave <= y - 8)
			{
				//2
				disp.y--;
			}
			else if (xnave >= X + 24 && ynave >= y - 8)
			{
				//3
				disp.x++;
				disp.y--;
			}
			else if (xnave >= X + 24 && ynave >= y - 8 && ynave <= y + 24)
			{
				//4
				disp.x++;				
			}
			else if (xnave >= X + 8 && ynave <= y + 24)
			{
				//5
				disp.x++;
				disp.y++;
			}
			else if (xnave >= X - 8 && xnave <= X + 24 && ynave >= y + 24)
			{
				//6
				disp.y++;
			}
			else if (xnave <= X - 8 && ynave >= y + 24)
			{
				//7
				disp.x--;
				disp.y++;
			}
		}
		time++;
	}
	
	private function DestruirDisp()
	{
		disp.destroy();
	}
}