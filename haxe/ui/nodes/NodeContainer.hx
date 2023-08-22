package haxe.ui.nodes;

import haxe.ui.core.Component;
import haxe.ui.events.UIEvent;
import haxe.ui.validation.InvalidationFlags;
import haxe.ui.components.Image;
import haxe.ui.components.Canvas;
import haxe.ui.events.MouseEvent;

class NodeContainer extends Canvas {
	public var scale:Float = 1;

	private var nodes:Array<Node> = [];

	public function new() {
		super();
		this.backgroundImage = "assets/bg.png";
		this.customStyle.backgroundImageRepeat = "repeat";
	}

	@:bind(this, MouseEvent.MOUSE_WHEEL)
	private function mWheelZoom(e:MouseEvent) {
		this.nodeScale += (0.01 * e.delta);
		this.customStyle.backgroundWidth = nodeScale * 512;
		this.customStyle.backgroundHeight = nodeScale * 512;
		this.invalidateComponent(STYLE);
		// TODO make this scale child nodes too
	}

	override public function addComponent(c:Component) {
		if (Type.getClass(c) == node) {
			nodes.push(c);
		}
		super.addComponent(c);
	}

	override public function removeComponent(c:Component, dispose:Bool = true, invalidate:Bool = true) {
		nodes.remove(c);
		super.removeComponent(c, dispose, invalidate);
	}

	@:bind(this, UIEvent.COMPONENT_ADDED)
	private function nodeAdded(e:UIEvent) {
		trace(e);
	}
}
