package haxe.ui.nodes;

import haxe.ui.util.Variant;
import haxe.ui.styles.Style;
import haxe.ui.core.Component;
import haxe.ui.events.UIEvent;
import haxe.ui.validation.InvalidationFlags;
import haxe.ui.components.Image;
import haxe.ui.components.Canvas;
import haxe.ui.events.MouseEvent;

class NodeContainer extends Canvas {
	@:isVar public var scale(get, set):Float = 1;

	private function get_scale():Float {
		return scale;
	}

	private function set_scale(val:Float):Float {
		scale = val;
		this.customStyle.backgroundWidth = scale * 512;
		this.customStyle.backgroundHeight = scale * 512;
		this.invalidateComponent("style");
		for (node in nodes) {
			node.scale = scale;
		}
		return scale;
	}

	private var nodes:Array<Node> = [];

	public function new() {
		super();
		this.backgroundImage = "assets/bg.png";
		this.customStyle.backgroundImageRepeat = "repeat";
	}

	@:bind(this, MouseEvent.MOUSE_WHEEL)
	private function mWheelZoom(e:MouseEvent) {
		this.scale += (0.01 * e.delta);
	}

	override public function addComponent(c:Component):Component {
		if (Type.getClass(c) == Node)
			nodes.push(cast(c, Node));
		return super.addComponent(c);
	}

	override public function removeComponent(c:Component, dispose:Bool = true, invalidate:Bool = true):Component {
		if (Type.getClass(c) == Node)
			nodes.remove(cast(c, Node));
		return super.removeComponent(c, dispose, invalidate);
	}

	@:bind(this, UIEvent.COMPONENT_ADDED)
	private function nodeAdded(e:UIEvent) {
		trace(e);
	}
}
