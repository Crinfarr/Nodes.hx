package;

import haxe.ui.containers.VBox;
import haxe.ui.nodes.Nodes.Node;

@:build(haxe.ui.ComponentBuilder.build("assets/main-view.xml"))
class MainView extends VBox {
    public function new() {
        super();
        var testcomponent = new Node("Test Node");
        testcomponent.addProperty("Test String", StringInput);
        addComponent(testcomponent);
        testcomponent.addProperty("Test Int", IntInput);
        testcomponent.addProperty("Test Color", ColorInput);
        testcomponent.addProperty("Test Color w/Alpha", ColorAlphaInput);
        testcomponent.addProperty("Test Bytes", BytesInput);
        testcomponent.addProperty("Test Raw", RawInput);
    }
}