## Scrollable tabs, based on the ScrollContainer
##
## to get started, add BetterTabContainer node to your scene,
## set it's size to full rect or hwide and add a few nodes to it
## please ignore the "multiple nodes" warning. Each node inside
## is treated as a separate tab. You might also want to hide
## the horizontal scroll bar at the bottom, as it does nothing

extends ScrollContainer

signal tab_switched(tab)

onready var tabs_holder := MarginContainer.new()
onready var children    := get_children()
onready var sizex       := rect_size.x

export(int) var current_tab = 0

var scroll_velocity := Vector2.ZERO
var scrolling       := false
var target_scroll   := 0.0
var current_scroll  := 0.0

func _ready() -> void:
	# add a tab holder to the container and move all the children to it
	add_child(tabs_holder)
	for child in children:
		if(child is ScrollBar): continue
		remove_child(child)
		tabs_holder.add_child(child)
		child.mouse_filter = Control.MOUSE_FILTER_PASS
	children = tabs_holder.get_children()
		
	# adjust all the properties of the containers
	scroll_vertical_enabled = false
	scroll_horizontal_enabled = true
	tabs_holder.size_flags_vertical = 3
	tabs_holder.rect_min_size.y = 1280
	tabs_holder.mouse_filter = Control.MOUSE_FILTER_PASS
	
	# connect required signals
	get_tree().get_root().connect("size_changed", self, "resize")
	tabs_holder.connect("sort_children", self, "resize")
	connect("gui_input", self, "_manage_input")
	resize()
	switch_tab()
	update_target_scroll(true)
	
func _process(delta: float) -> void:
	if (scrolling):
		current_scroll = scroll_horizontal
	else:
		# smoothly scroll to the current tab
		current_scroll += (target_scroll - scroll_horizontal) * 8.0 * delta
		scroll_horizontal = current_scroll
	
func resize() -> void:
	# handle window resizing
	sizex = rect_size.x
	tabs_holder.rect_min_size.x = sizex * children.size()	
	
	var childi := 0
	for child in children:
		child.rect_size.x = sizex
		child.rect_position.x = sizex * childi
		childi += 1
		
	update_target_scroll(true)
	
func _manage_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		# when the drag is stopped, end scrolling
		if (!event.is_pressed()):
			end_scroll()
	elif (event is InputEventScreenDrag):
		scroll_velocity = event.relative
	elif (event is InputEventScreenTouch):
		scrolling = true
		
func end_scroll() -> void:
	# calculate current tab, based on the horizontal scroll and the drag velocity 
	# and then switch to it
	current_tab = int(round((scroll_horizontal - scroll_velocity.x) / sizex))
	switch_tab()
	scroll_velocity = Vector2.ZERO
	scrolling = false
	
func update_target_scroll(instant:bool=false) -> void:
	# calculate horizontal scrolling required to fully switch to a single tab, with no overlaps
	# if instant is true, also update the current scroll
	target_scroll = current_tab * sizex
	if (instant): 
		current_scroll = target_scroll
		scroll_horizontal = current_scroll
	
func switch_tab(tab:int=-1) -> void:
	if (tab >= 0): current_tab = tab
	update_target_scroll()
	emit_signal("tab_switched", current_tab)
