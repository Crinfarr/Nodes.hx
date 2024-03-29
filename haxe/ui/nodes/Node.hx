package haxe.ui.nodes;

import haxe.ui.containers.VBox;
import haxe.ui.nodes._internal.NodeProperty;
import haxe.ui.nodes._internal.NodeLabel;
import haxe.ui.nodes._internal.enums.NodeInputType;
import haxe.ui.nodes.helpers.Scalable;

class Node extends VBox implements Scalable {
	public var properties:Array<NodeProperty>;
	public var name:NodeLabel;

	public function new(n:String) {
		super();

		this.name = new NodeLabel();
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
