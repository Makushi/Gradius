package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxState;
import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.group.FlxGroup.FlxTypedGroup;
import sprites.Optione;

/**
 * ...
 * @author Maximiliano Viñas Craba
 */
class Player extends FlxSprite
{
	public var speed:Int = Reg.playerSpeed;
	private var speedBkUp:Int = Reg.playerSpeed;
	public var bullets:FlxTypedGroup<Bullet>;
	public var missile : Bool = false;
	public var option : Bool = false;
	public var shield : Bool = false;
	private var shieldLive : Int = 0;
	public var op : Optione;
	
	public function new(?X:Float=0, ?Y:Float=0, playerBullets:FlxTypedGroup<Bullet>) 
	{
		super(X, Y);
		makeGraphic(16, 16);
		bullets = playerBullets;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		Movement();
	}
	
	public function Movement():Void 
	{
		if (this.alive)
		{
			if (FlxG.keys.pressed.LEFT)
			{
				this.x -= speed;
			}
	 
			if (FlxG.keys.pressed.RIGHT)
			{
				this.x += speed;
			}
	 
			if (FlxG.keys.pressed.UP)
			{
				this.y -= speed;
			}
	 
			if (FlxG.keys.pressed.DOWN)
			{
				this.y += speed;
			}
			
			if (FlxG.keys.justPressed.Z)
			{
				Shoot();
			}
		}
		if (option){
			//Mueve al option dependiendo de la posicion player
			
		}
	}
	
	private function Shoot():Void{
        var newBullet = new Bullet(this.x + 8, this.y + 8, 1, 300);
        bullets.add(newBullet);
		if (missile){
			var newBulletM = new Bullet(this.x + 8, this.y + 8, 1, 300, 300);
			bullets.add(newBulletM);
		}
		
		if (option){
			var newBulletO = new Bullet(op.x + 2, op.y + 2, 1, 300);
			bullets.add(newBulletO);
		}
    }
	
	public function Aceleration(): Void
	{
		speed += 1; 
	}
	
	public function Reset(): Void
	{
		speed = speedBkUp;
		missile = false;
		option = false;
	}
	
	public function ActivateShield(){
		shieldLive = 3;
		shield = true;
		//Cambiar imagen de una animacion
	}
	
	public function SubstractShield(){
		shieldLive--;
		if (shieldLive == 0){
			shield = false;
			//Desactivar imagen de animacion 
		}
	}
	
	public function CreateOptione()
	{
		op = new Optione(this.x - 12, this.y - 12);
		option = true;
		FlxG.state.add(op);
	}
	
	public function DeleteOptione()
	{
		op.destroy();
		option = false;
	}
}