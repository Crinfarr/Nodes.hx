package haxe.ui.nodes._internal;

import haxe.ui.components.Image;

class NodeBox extends Image {
	@:noCompletion private var baseWidth:Null<Float> = null;
	@:noCompletion private var baseHeight:Null<Float> = null;

	@:isVar public var scale(get, set):Float = 1;

	private function get_scale():Float {
		return scale;
	}

	private function set_scale(val:Float):Float {
		scale = val;
		this.width = scale * baseWidth;
		this.height = scale * baseHeight;
		return scale;
	}

	override private function set_width(value:Null<Float>):Null<Float> {
		return (super.width = (baseWidth = value) * scale);
	}

	override private function get_width():Null<Float> {
		return (super.width != null) ? super.width * scale : null;
	}

	override private function set_height(value:Null<Float>):Null<Float> {
		baseHeight = value;
		return (super.height = baseHeight * scale);
	}

	public function new() {
		super();
	}
}
