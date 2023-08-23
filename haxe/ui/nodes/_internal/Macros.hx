package haxe.ui.nodes._internal;

import haxe.macro.Expr.FieldType;
import haxe.macro.Expr.Access;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Context;
import haxe.macro.Type;

class Macros {
    public static macro function resolveScalable():ComplexType {
        switch (Context.getLocalType()) {
            case TInst(_, [t1]):
                var type = Context.toComplexType(t1);
                return Context.toComplexType(t1);
            case t:
                Context.fatalError('Scalable<T> must extend a class', Context.currentPos());
                return null;
        }
    }
    public static macro function addScalableFields():Array<Field> {
        var fields = Context.getBuildFields();
        var scalebase = 1;
        var pos = Context.currentPos();
        var fieldName = 'scale';

        var prop:Field = {
            name: 'scale',
            access: [Access.APublic],
            kind: FieldType.FProp('get', 'set', macro:Float)
        }
        return Context.getBuildFields();
    }
}