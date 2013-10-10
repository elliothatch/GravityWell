package  
{
	/**
	 * ...
	 * @author Elliot Hatch
	 */
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	public class PlayState extends FlxState 
	{
		
		private var debris:FlxGroup;
		private var player:FlxSprite;
		
		override public function create():void
		{
			FlxG.bgColor = 0xffffffff;
			
			player = new FlxSprite(100, 200);
			player.makeGraphic(32, 48, 0xffdd2222);
			
			debris = new FlxGroup();
			for (var i:int = 0; i < 20; i++)
			{
				for (var j:int = 0; j < 20; j++)
				{
					var obj:FlxSprite = new FlxSprite(i * 30, j * 30);
					obj.makeGraphic(10, 10, 0xffaaffaa);
					debris.add(obj);
				}
			}
			player.maxVelocity.x = 80;
			player.maxVelocity.y = 80
			player.drag.x = player.maxVelocity.x * 4;
			player.drag.y = player.maxVelocity.y * 4;
			add(player);
			add(debris);
		}
		
		override public function update():void
		{
			player.acceleration.x = 0;
			player.acceleration.y = 0;
			if (FlxG.keys.LEFT)
				player.acceleration.x = - player.maxVelocity.x * 4;
			if (FlxG.keys.RIGHT)
				player.acceleration.x = player.maxVelocity.x * 4;
			if (FlxG.keys.UP)
				player.acceleration.y =  -player.maxVelocity.y * 4;
			if (FlxG.keys.DOWN)
				player.acceleration.y = player.maxVelocity.y * 4;
			if (FlxG.keys.SPACE)
			{
				for (var i:int = 0; i < debris.length; i++)
				{
					var obj:FlxSprite = debris.members[i];
					var playerXY:FlxPoint = new FlxPoint(player.x, player.y);
					var objXY:FlxPoint = new FlxPoint(obj.x, obj.y);
					var force = 1 / FlxU.getDistance(playerXY, objXY);
					obj.velocity.x += force *(player.x - obj.x) * FlxG.elapsed * 100;
					obj.velocity.y += force * ( player.y - obj.y) * FlxG.elapsed * 100;
				}
				/*
				for (var obj1:FlxBasic in debris.members)
				{
					var obj:FlxSprite = obj1 as FlxSprite;
					var playerXY:FlxPoint = new FlxPoint(player.x, player.y);
					var objXY:FlxPoint = new FlxPoint(obj.x, obj.y);
					var force = 1 / FlxU.getDistance(playerXY, objXY);
					obj.velocity.x += force *(player.x - obj.x) * FlxG.elapsed;
					obj.velocity.y += force * ( player.y - obj.y) * FlxG.elapsed;
				}*/
			}
			super.update();
		}
	}
	
	

}