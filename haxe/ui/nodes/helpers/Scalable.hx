package haxe.ui.nodes.helpers;

#if !macro
import haxe.ui.core.Component;
#end
@:autoBuild(haxe.ui.nodes._internal.Macros.applyScalable())
interface Scalable {
	private var baseWidth:Null<Float>;
	private var baseHeight:Null<Float>;
	private var scalableChildren:Array<Scalable>;
	public function addComponent(component:Component):Component;
	@:isVar public var scale(get, set):Float;
	private function get_scale():Float;
	private function set_scale(value:Float):Float;
	private function set_width(value:Null<Float>):Null<Float>;
	private function set_height(value:Null<Float>):Null<Float>;
}
