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
	private var bulletSound:FlxSound;
	public var bullets:FlxTypedGroup<Bullet>;
	public var missile : Bool = false;
	public var option : Bool = false;
	public var shield : Bool = false;
	private var shieldLive : Int = 0;
	public var op : Optione;
	private var spriShield : FlxSprite;
	
	public function new(?X:Float=0, ?Y:Float=0, playerBullets:FlxTypedGroup<Bullet>) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.Nave__png,false,16,16);
		bullets = playerBullets;
		bulletSound = FlxG.sound.load(AssetPaths.Shoot__wav);
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
			
			if (FlxG.keys.justPressed.X)
			{
				if (Reg.ub.upNumber != 0)
				{
					switch(Reg.ub.upNumber)
					{
						case 1:
							Aceleration();
							Reg.ub.Reset();
						case 2:
							if (missile == false)
							{
								missile = true;
								Reg.ub.Reset();
							}
						case 3:
							if (shield == false)
							{
								ActivateShield();
								Reg.ub.Reset();
							}
						case 4:
							if (option == false)
							{
								CreateOptione();
								Reg.ub.Reset();
							}
					}
				}
			}
			
			if (shield)
			{
				spriShield.x = this.x+8;
				spriShield.y = this.y;
			}
		}
		if (option){
			//Mueve al option dependiendo de la posicion player
			var dis : Int;
			dis = Math.round(Math.sqrt(Math.pow(op.x+4 - this.x, 2) + Math.pow(op.y+4 - this.y-8, 2)));
			if (dis > 18)
			{
				if (op.x >= this.x && op.y <= this.y)
				{
					op.x -= 2;
					op.y += 2;
				}
				else if (op.x <= this.x && op.y <= this.y)
				{
					op.x += 2;
					op.y += 2;
				}
				else if (op.x >= this.x && op.y >= this.y)
				{
					op.x -= 2;
					op.y -= 2;
				}
				else if (op.x <= this.x && op.y >= this.y)
				{
					op.x += 2;
					op.y -= 2;
				}
			}
		}
	}
	
	private function Shoot():Void{
        var newBullet = new Bullet(this.x + 8, this.y + 8, 1, 300);
        bullets.add(newBullet);
		if (missile){
			var newBulletM = new Bullet(this.x + 8, this.y + 8, 1, 200, 200);
			bullets.add(newBulletM);
		}
		
		if (option){
			var newBulletO = new Bullet(op.x + 2, op.y + 2, 1, 300);
			bullets.add(newBulletO);
		}
		bulletSound.play();
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
		spriShield = new FlxSprite();
		spriShield.velocity.x = this.velocity.x;
		spriShield.loadGraphic(AssetPaths.Shield__png, true, 16, 16);
		spriShield.animation.add("Shi3", [0], 5, false);
		spriShield.animation.add("Shi2", [1], 5, false);
		spriShield.animation.add("Shi1", [2], 5, false);
		FlxG.state.add(spriShield);
		spriShield.animation.play("Shi3");
	}
	
	public function SubstractShield(){
		shieldLive--;
		switch(shieldLive)
		{
			case 0:
				shield = false;
				spriShield.destroy();
			case 1:
				spriShield.animation.play("Shi1");
			case 2:
				spriShield.animation.play("Shi2");
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