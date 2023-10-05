class_name Util
extends Node

#region // 󰵉 VECTOR.

static func vec2_max(a: Vector2, b: Vector2) -> Vector2:
	return Vector2(max(a.x, b.x), max(a.y, b.y))

static func vec2i_max(a: Vector2i, b: Vector2i) -> Vector2i:
	return Vector2i(max(a.x, b.x), max(a.y, b.y))

#endregion 󰵉 VECTOR.

#region //  STOPWATCH.

static var stopwatch_start: int = 0

## Start stopwatch. See [method Util.end].
static func start() -> void:
	stopwatch_start = Time.get_ticks_usec()

## Stop stopwatch. Returns microseconds since last [method Util.start].
static func stop() -> int:
	return Time.get_ticks_usec() - stopwatch_start

## stop stopwatch, but it prints. See [method Util.start].
static func stop_print() -> void:
	print(Time.get_ticks_usec() - stopwatch_start)

#endregion  STOPWATCH.
