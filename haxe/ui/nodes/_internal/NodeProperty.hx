package haxe.ui.nodes._internal;

import haxe.ui.containers.HBox;
import haxe.ui.nodes._internal.enums.NodeInputType;
import haxe.ui.nodes._internal.NodeBox;
import haxe.ui.nodes._internal.NodeLabel;

class NodeProperty extends HBox {
	public var label:NodeLabel;
	public var box:NodeBox;

	@:isVar public var scale(get, set):Float = 1;
	private function get_scale():Float {
		return scale;
	}
	private function set_scale(val:Float):Float {
		return (scale = val);
	}

	var nodeInputType:NodeInputType;

	public function new() {
		super();
		this.autoWidth = true;
		this.autoHeight = true;

		this.box = new NodeBox();
		this.box.width = 16;
		this.box.height = 16;

		this.label = new NodeLabel();
		this.label.autoWidth = true;
		this.label.autoHeight = true;
		this.label.color = "#ffffff";

		this.addComponent(this.box);
		this.addComponent(this.label);
	}

	public function setDataType(type:NodeInputType) {
		switch (type) {
			case StringInput:
				this.box.resource = "assets/box_String.png";
			case IntInput:
				this.box.resource = "assets/box_Int.png";
			case ColorInput:
				this.box.resource = "assets/box_RGB.png";
			case ColorAlphaInput:
				this.box.resource = "assets/box_RGB.png";
			case BytesInput:
				this.box.resource = "assets/box_Bin.png";
			case RawInput:
				this.box.resource = "assets/box_Any.png";
			default:
				null;
		}
	}
}
