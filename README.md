# <img src="./addons/BetterTabContainer/class-icon.svg" width="25" alt="icon"/> A Mobile-friendly tabs container for Godot 3
This addon adds a container, that can have multiple tabs, which the user can change by swiping left or right on the screen. It is based on the ScrollContainer node.

<p align="center">
<a href="https://youtu.be/SpJnDzuDmR8">Watch a Video Showcase</a>
<br><br>
<a href="https://youtu.be/SpJnDzuDmR8">
<img src="https://cdn.discordapp.com/attachments/510776441084968977/1005441626409287740/thumb.png" width="800"/>
</a>
</p>

## Getting Started
1. Download the addon and place it into your project directory, either manually, or through the Asset Store
2. Activate it in the Project Settings ("Plugins" tab)
3. Add a `BetterTabContainer` node to a scene. It is recommended that it is either set to full rect or has a "Fill" horizontal size flag
4. Add multiple nodes to it. Each child node counts as a separate tab, it can be any type of Control node. Please ignore the "ScrollContainer can only have one node" warning, I am actively trying to get rid of it
5. Done! 

## Customizing the Node
- You can set the "Current Tab" property in the inspector. By default, it is set to 0, meaning the first tab is active on start
- You can connect the "tab_switched" signal to another node to detect when it's changed
- If you want to change the tab through code (for example, if you have a list of tab buttons next to the container), you can call the `switch_tab(tab)` method
- You might also want to hide the horizontal scroll bar, as it does nothing
- If you want to be able to swipe on tabs, make sure to set all of the children containers' mouse filter to "Pass", so it detects input

## Examples & Screenshots
TODO

## Contributing
Feel free to improve the code, fix bugs or add functionality by [creating an issue](https://github.com/GDUcrash/BetterTabContainer/issues/new) or [submitting a pull request](https://github.com/GDUcrash/BetterTabContainer/pulls)
