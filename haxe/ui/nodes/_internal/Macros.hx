package haxe.ui.nodes._internal;

import haxe.macro.Type.ClassType;
#if macro
import haxe.macro.Context;
import haxe.macro.Expr.Field;
import haxe.macro.Expr.Access;
import haxe.rtti.Meta;
import haxe.macro.Compiler;

// import haxe.ui.core.Component;
#end
class Macros {
	macro function applyScalable():Array<Field> {
		var isComponent = false;
		var _last:haxe.macro.Type.Ref<ClassType> = Context.getLocalClass();
		do {
			isComponent = _last.toString() == 'haxe.ui.core.Component';
			if (isComponent)
				break;
			_last = _last.get().superClass.t;
		} while (_last.get().superClass != null);
		if (!isComponent) {
			Context.error('Non-component classes cannot be Scalable', Context.currentPos());
		}

		var fields:Array<Field> = Context.getBuildFields();
		// Compiler.addMetadata('scalable', Context.getLocalClass().toString());
		Context.getLocalClass().get().meta.add('scalable', [macro true], Context.currentPos());

		/**
		 * Base width and height (to use with scale)
		 */
		fields.push({
			name: 'baseWidth',
			access: [APrivate],
			pos: Context.currentPos(),
			kind: FVar(macro :Null<Float>, macro null)
		});

		fields.push({
			name: 'baseHeight',
			access: [APrivate],
			pos: Context.currentPos(),
			kind: FVar(macro :Null<Float>, macro null)
		});

		/**
		 * scale, getters, and setters
		 */
		fields.push({
			name: 'scale',
			access: [APublic],
			pos: Context.currentPos(),
			kind: FProp('get', 'set', (macro :Float), (macro 1)),
			meta: [
				// make sure var field is generated
				{
					name: ':isVar',
					pos: Context.currentPos()
				}
			]
		});

		fields.push({
			name: 'get_scale',
			access: [APrivate],
			kind: FFun({
				args: [],
				ret: (macro :Float),
				expr: macro {
					return scale;
				}
			}),
			pos: Context.currentPos()
		});
		fields.push({
			name: 'set_scale',
			kind: FFun({
				args: [
					{
						name: 'value',
						type: (macro :Float),
					}
				],
				ret: (macro :Float),
				expr: macro {
					scale = value;
					super.set_width(baseWidth * scale);
					super.set_height(baseHeight * scale);
					
					for (component in this.childComponents.filter((e) -> {
						haxe.rtti.Meta.getType(Type.getClass(e)).scalable != null;
					})) {
						trace('scaling');
						component.scale = scale;
					}
					return scale;
				}
			}),
			pos: Context.currentPos(),
		});

		/**
		 * Override set_width to modify base width instead
		 */
		fields.push({
			name: 'set_width',
			kind: FFun({
				args: [
					{
						name: 'value',
						type: (macro :Null<Float>)
					}
				],
				ret: (macro :Null<Float>),
				expr: macro {
					baseWidth = value;
					return super.set_width(baseWidth * scale);
				}
			}),
			access: [AOverride, APrivate],
			pos: Context.currentPos()
		});

		/**
		 * Override set_height to modify base height instad
		 */
		fields.push({
			name: 'set_height',
			kind: FFun({
				args: [
					{
						name: 'value',
						type: (macro :Null<Float>)
					}
				],
				ret: (macro :Null<Float>),
				expr: macro {
					baseHeight = value;
					return super.set_height(baseHeight * scale);
				}
			}),
			access: [AOverride, APrivate],
			pos: Context.currentPos()
		});

		return fields;
	}
}
