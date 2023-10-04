class_name Util
extends Node

static func vec2_max(a: Vector2, b: Vector2) -> Vector2:
	return Vector2(max(a.x, b.x), max(a.y, b.y))

static func vec2i_max(a: Vector2i, b: Vector2i) -> Vector2i:
	return Vector2i(max(a.x, b.x), max(a.y, b.y))
