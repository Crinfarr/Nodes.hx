package haxe.ui.nodes._internal;

import haxe.macro.Expr.Field;
import haxe.rtti.Meta;
import haxe.macro.Compiler;
#if macro
import haxe.macro.Expr.FieldType;
import haxe.macro.Expr.Access;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Context;
import haxe.macro.Type;
#end

class Macros {
	macro function applyScalable():Array<Field> {
		var fields:Array<Field> = Context.getBuildFields();
		
		Compiler.addMetadata('@scalable', Context.getLocalClass().toString());
		trace(Meta.getFields(Context.getLocalClass().get()));

		fields.push({
			name: 'scale',
			access: [APublic],
			pos: Context.currentPos(),
			kind: FProp('get', 'set', (macro :Float)),
			meta: [
				{
					name: ':isVar',
					pos: Context.currentPos()
				}
			]
		});

		fields.push({
			name: 'get_scale',
			kind: FFun({
				args: [],
				ret: (macro :Float),
				expr: macro {
					if (scale == null)
						scale = 1;
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
					return scale;
				}
			}),
			pos: Context.currentPos(),
		});

		return fields;
	}
}
