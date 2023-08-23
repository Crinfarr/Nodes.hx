package haxe.ui.nodes;

import haxe.ui.components.Label;
import haxe.ui.containers.VBox;
import haxe.ui.components.Canvas;
import haxe.ui.nodes._internal.NodeProperty;
import haxe.ui.nodes._internal.enums.NodeInputType;
import haxe.ui.nodes._internal.Scalable;

class Node extends Scalable<VBox> {
	public var properties:Array<NodeProperty>;
	public var name:Label;
	@:isVar public var scale(get, set):Float = 1;
	private function get_scale():Float {
		return scale;
	}
	private function set_scale(val:Float):Float {
		scale = val;
		for (property in this.properties) {
			property.scale = scale;
		}
		return scale;
	}

	public function new(n:String) {
		super();

		this.name = new Label();
		this.name.textAlign = "center";
		this.name.percentWidth = 100;
		this.name.autoHeight = true;
		this.name.text = n;
		this.addComponent(this.name);

		this.properties = [];
		this.styleString = "background-color: #6f6f6f";
		this.autoWidth = true;
		this.autoHeight = true;
	}

	public function addProperty(name:String, type:NodeInputType) {
		var prop = new NodeProperty();
		prop.setDataType(type);
		prop.label.text = name;

		this.properties.push(prop);
		this.addComponent(prop);
		
	}
}
