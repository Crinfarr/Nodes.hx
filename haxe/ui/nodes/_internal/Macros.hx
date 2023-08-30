package haxe.ui.nodes._internal;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr.Field;
import haxe.macro.Type.ClassType;
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
		 * Separate scalable children
		 */
		fields.push({
			name: 'scalableChildren',
			access: [APrivate],
			kind: FVar(macro :Array<Scalable>, {
				expr: EArrayDecl([]),
				pos: Context.currentPos()
			}),
			pos: Context.currentPos(),
		});

		fields.push({
			name: 'addComponent',
			access: [AOverride, APublic],
			kind: FFun({
				args: [
					{
						name: 'component',
						type: (macro :haxe.ui.core.Component)
					}
				],
				expr: macro {
					if (Std.isOfType(component, Scalable)) {
						scalableChildren.push(untyped component);
					}
					return super.addComponent(component);
				}
			}),
			pos: Context.currentPos(),
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
					if (baseWidth == null)
						baseWidth = width;
					if (baseHeight == null)
						baseHeight = height;
					super.set_width(baseWidth * scale);
					super.set_height(baseHeight * scale);
					this.customStyle.fontSize = 13 * scale;
					this.invalidateComponentStyle();
					for (child in scalableChildren) {
						child.scale = scale;
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
