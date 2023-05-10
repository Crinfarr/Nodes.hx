package haxe.ui.nodes;

import haxe.ui.components.Image;
import haxe.ui.containers.HBox;
import haxe.ui.components.Label;
import haxe.ui.containers.VBox;
import haxe.ui.components.Canvas;

private enum NodeInputType {
    StringInput;
    IntInput;
    ColorInput;
    ColorAlphaInput;
    BytesInput;
    RawInput;
}

class NodeContainer extends Canvas {
    public function new() {
        super();
    }
}

class Node extends VBox {
    public var properties:Array<NodeProperty>;
    public var name:Label;
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

private class NodeProperty extends HBox {
    public var label:Label;
    public var box:Image;
    var nodeInputType:NodeInputType;
    public function new() {
        super();
		this.autoWidth = true;
		this.autoHeight = true;

        this.box = new Image();
		this.box.width = 16;
		this.box.height= 16;

        this.label = new Label();
        this.label.autoWidth = true;
        this.label.autoHeight= true;
        this.label.color = "#ffffff";

        this.addComponent(this.box);
        this.addComponent(this.label);
    }
    public function setDataType(type:NodeInputType) {
        switch (type) {
            case StringInput:
                this.box.resource = "assets/_internal/box_String.png";
                this.box.autoSize();
            case IntInput:
                this.box.resource = "assets/_internal/box_Int.png";
                this.box.autoSize();
            case ColorInput:
                this.box.resource = "assets/_internal/box_RGB.png";
                this.box.autoSize();
            case ColorAlphaInput:
                this.box.resource = "assets/_internal/box_RGB.png";
                this.box.autoSize();
            case BytesInput:
                this.box.resource = "assets/_internal/box_Bin.png";
                this.box.autoSize();
            case RawInput:
                this.box.resource = "assets/_internal/box_Any.png";
                this.box.autoSize();
            default: null;
        }
    }
}